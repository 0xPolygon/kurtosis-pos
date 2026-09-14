---
name: kurtosis-pos-chaos
description: Chaos-test a running kurtosis-pos devnet with tartarus (kill, pause, partition, netem) and judge the results. Covers the topology facts that decide what a fault does (VeBlop single producer, heimdall quorum and span runway, witness-sync nodes, sequence store on the sealing path), the reusable oracle/episode harness in seq-store-testing/campaign, baseline numbers and log noise to ignore, an episode catalog with exact commands, expected outcomes from the 2026-09-10 campaign to regress against, and the report format.
allowed-tools: Bash, Read, Glob, Grep, Write, Edit
compatibility: Requires a running enclave, tartarus on PATH with sudo iptables/tc for partition and netem, cast, polycli, jq, docker, python3.
---

## Related skills

- **kurtosis-pos-deploy** — bring up the enclave first (`robust-seqstore.yml` is the seqstore layout this skill was built on)
- **kurtosis-pos-interact** — ports, logs, shells, cast
- **kurtosis-pos-investigate** — protocol mechanisms and the anomaly-signal thresholds this skill reuses
- **tartarus** (global skill) — the fault CLI contract; read it once per session

---

## What this skill is for

Run fault episodes against a live enclave, measure the chain with an external oracle, and write findings other engineers can act on. The 2026-09-10 campaign (30 episodes, `seq-store-testing/campaign/CAMPAIGN.md`) is the reference: reuse its harness, compare against its numbers, and extend its catalog. Reading order for a new campaign: this file, then `CAMPAIGN.md` "Executive summary" and "Findings", then the tartarus skill.

---

## Topology facts that decide outcomes

Confirm each against the running enclave; they were true for `robust-seqstore.yml` with `bor:b56ff74a4` and `heimdall-v2:0.11.0`.

- **Validator N is `l2-el-N` / `l2-cl-N`, signer `0xNNNN…`** (`0x11111f7e…` = v1). `bor_getAuthor latest` on any node names the sealer; the digit after `0x` is the node index. Do **not** use `/bor/spans/latest` for "who is in turn": it returns the next *registered* span, which is usually the future one.
- **VeBlop elects one producer per 128-block span** from the `producer_votes` set (validators 1-3 here). "In-turn" is one node; the other two producers are fallbacks that take over after a stall (observed 6-12 s gaps). Validators 4-7 are stateless witness-sync nodes that never seal.
- **Block time is 1 s in this devnet** (baseline 1.00 block/s). Every throughput number below is relative to that.
- **Heimdall needs 5 of 7 equal-stake validators.** Losing 3 heimdalls, or the bor nodes of 4 validators (their heimdalls cannot validate without a local bor), freezes milestones and checkpoints immediately (F9). Block production continues only until the end of the already-committed span, then halts until quorum returns (F10). Spans are committed about one span ahead, so the halt budget is at most 128 blocks.
- **Bor has a heimdall failover list.** A producer whose own heimdall dies fails over to another validator's heimdall within seconds and keeps sealing at full rate (p08, p17). Killing all producer heimdalls is a finality event, not a liveness event.
- **Stateless nodes store no receipts** (`eth_getBlockReceipts` -> `receipts length mismatch`, `eth_getTransactionReceipt` -> `receipt not found`) and have no txpool; the package keeps them out of nginx/erpc upstreams. Do not point tooling at them.
- **Sequence store wiring:** producers publish to `seqstore-ingress:9550` (gRPC) and read their own tail through `seqstore-gateway:9550` (envoy in front of 3 gateways) at *every block build*; RPC nodes el-8/el-9 stream from the same envoy. Ingress writes to Redpanda rf=3 min.insync=2 transactionally. Producer config is `[sequencer] publisher-endpoint / consumer-endpoint` in `/etc/bor/config.toml`.
- **The store is on the sealing path** (contrary to the design brief): a 500 ms ConfirmSeal barrier on publish and a 1 s tail-read budget (`bor/eth/sequencer/reader.go tailReadTimeout`) at build start. Ingress outage or > ~250 ms one-way latency costs 25-33 % block rate; gateway/envoy outage or 400 ms latency costs ~50 % (F2, F3).
- **The L1 is one geth + one lighthouse with no peers.** SIGKILL of `el-1-geth-lighthouse` resets it to block 7 and stops checkpoints permanently (F11). Use `kurtosis service stop`, `pause`, or `kill --param signal=TERM` for L1 faults, and expect to redeploy afterwards.
- **Load-balancer race:** dependent setup transactions through `nginx` fail intermittently (receipt on one node, next request on another). Point setup scripts at one bor RPC node; keep the balancer for load tests.

---

## Harness (reuse, do not rewrite)

Everything lives in `seq-store-testing/campaign/`. Copy the directory to a new campaign folder or reuse it in place; keep `store/` (tartarus records) with it.

```bash
cd seq-store-testing
source campaign/lib.sh                 # exports TARTARUS_OUTPUT=json, TARTARUS_STATE_DIR=campaign/store, E=pos
tartarus doctor --enclave $E 2>/dev/null | jq -c '.data.checks[] | select(.status!="ok")'
tartarus fault list | jq -e '.data.records==[]'                  # nothing left from an earlier session
refresh_nodes                                                     # campaign/nodes.json (atomic write)
nohup campaign/probe.sh    >/dev/null 2>campaign/probes/probe.err    & echo $! > campaign/probes/probe.pid
nohup campaign/loadtest.sh >/dev/null 2>campaign/probes/loadtest.err & echo $! > campaign/probes/loadtest.pid
sleep 90                                                          # baseline before the first fault
```

Helpers in `lib.sh`:

| helper | what it does |
| --- | --- |
| `port SERVICE CONTAINER_PORT` | host port from `nodes.json`; empty when the node is down |
| `head_of PORT` | `"<number> <hash12>"` of latest (named to avoid shadowing coreutils `head`) |
| `in_turn` | node index of the current sealer via `bor_getAuthor` on el-8 |
| `milestone`, `checkpoint_count`, `span_producer` | heimdall REST via el-8's heimdall |
| `producer_metrics PORT` | `sequencer_publish_*` counters + state gauge for a producer |
| `episode ID [--logs "svc …"] [--post SECS] -- <tartarus fault run args>` | runs the fault, saves `records/ID.json`, waits, runs `analyze.py`, saves windowed docker logs and an anomaly summary |
| `window_logs ID SVC`, `anomalies FILE`, `seal_summary FILE` | evidence extraction |

`probe.sh` writes one line per second to `probes/oracle.log`: author, milestone end, checkpoint count, ingress ok-entries, gateway-0 position, every node's `height:hash`, each producer's publish metrics. `loadtest.sh` keeps 5 tx/s of counter calls flowing through nginx (needs `bootstrap.env` from `bootstrap.sh`). `analyze.py <id>` prints block rate per phase (before/during/after), per-node stalls, per-node reorgs, cross-node hash changes, height-went-backwards, milestone/store progress, producer metric deltas. `summary.py` builds the cross-episode markdown table.

Tartarus after the 2026-09-14 update (check `tartarus fault kinds`): kinds are `kill`, `stop` (SIGTERM, then SIGKILL after `timeout`), `pause`, `partition`, `netem` (was `netem-latency`; `delay`, `jitter`, `loss_percent`, at least one of delay/loss), `throttle` (`cpus`, via `docker update`). `--node`/`--group` accept globs (`'l2-cl-*-heimdall-v2-*'`). `--note "..."` is stored on the record and shown by `inspect`/`list`. `--verify-every 15s` on `run` appends mid-hold primitive read-backs to `observations[]`. Ids may be 64 chars. stderr noise is down to one line, so `2>/dev/null` is no longer needed.

Rules learned the hard way:

- tartarus ids are `[A-Za-z0-9_-]`, **max 64 chars** (was 19); the wrapper refuses longer ones.
- A `kill`/`stop` of `l2-cl-8-heimdall-v2-bor-rpc-archive` or `l2-cl-9-heimdall-v2-bor-rpc` leaves them dead: their container command re-runs `heimdalld init` and exits on "genesis.json file already exists" (finding H5 in `seq-store-testing/campaign/HEIMDALL-MATRIX.md`). Validator heimdalls restart fine. Until the launcher is fixed, do not include cl-8/cl-9 in restart faults, and point REST probes (`hport` in `lib.sh`) at a validator heimdall.
- A producer partitioned from heimdall during its turn wedges (H2); plan a recorded restart (`--kind stop --for 5s`) after such episodes and check `eth_syncing`/`whitelist-no-remote` before the next one.
- Wait for the right point in the span: `head` vs `(head/128+1)*128` decides whether a hold crosses a boundary; the h04/h05 episodes show the wait loop.
- Re-read ports after any kill (Kurtosis republishes on restart); the probe does so every 15 s.
- Never `pkill -f` a pattern that appears in your own command line (it killed the shell once).
- Do not name a shell function `head`.
- Faults that restart containers give them new IPs; peers log `DNS lookup of static node failed` and may take 60-85 s to re-peer (p03). Budget `--post` accordingly (90-150 s for kills, 60 s for pauses/netem).
- Run episodes sequentially; a second fault mid-episode contaminates the window.

---

## Oracle: what to measure and what "bad" looks like

| signal | source | flag when |
| --- | --- | --- |
| block rate during the hold | `analyze.py` "block rate per phase" | < 0.95 blocks/s with the fault on a component that is supposed to be off the critical path |
| network stall | longest no-new-block gap on *non-faulted* nodes | > 15 s for a single-node fault; any stall for store/RPC faults |
| per-node reorg | same node reports a different hash for a height it already reported | any occurrence on a connected node (isolated producers rewinding is expected) |
| height went backwards | node's head decreased | expected on the faulted node after SIGKILL (state repair) or isolation; unexpected elsewhere |
| milestone frozen | `ms` unchanged | > 90 s |
| checkpoint count | `cp` unchanged | > 4 min (and check L1 health first) |
| producer `sequencer_publish_barriertimeout` | oracle `pN:` fields | increments on every block = store round trip > 500 ms |
| producer `sequencer_publish_state` | gauge | 1 live, 2 degraded, 3 resyncing, 4 failed, 5 contending (normal for a backup that lost its stream) |
| seal time | `Successfully sealed new block … elapsed=` in bor logs (`seal_summary`) | ~500 ms = barrier; ~750 ms = barrier + tail read; 4 s seen once during fallback with a foreign fork in the store |
| ingress commits | `window committed` lines / `seqstore_ingress_entries_total{status="ok"}` | flat = store cannot commit (below min.insync or partitioned) |

Reorg detection must be **per node**. A cross-node "first seen vs later" comparison attributes an isolated producer's private hashes to whoever reports the canonical one first and produces false reorgs (this happened in p05 before the per-node check was added).

---

## Baseline noise to ignore (and not report as findings again)

- Heimdall-v2 emits ~55 `ERR` lines/min on a healthy node: `Failed to read request err="websocket: close 1006"` + `error while stopping connection error="already stopped"` pairs, `Checkpoint not in continuity`, `invalid proposer in msg`, `Checkpoint already exits in buffer`, and ~0.4/min `Multiple non-rp vote extensions detected … potential malicious activity` (bursts during bor halts). Already filed as F6.
- Bor after a SIGKILL restart: `Unclean shutdown detected`, `Truncating freezer table`, `Head state missing, repairing`, `Imported new chain segment blocks=N`, and `ERROR error handling milestone ws event err="chain out of sync"` once per second until at the tip (F5).
- Bor during any heimdall or bor stall: `ERROR connection lost; will attempt to reconnect on heimdall ws subscription … i/o timeout`.
- RPC consumers after any store hiccup: `Preconf application skipped: open parent neither canonical nor speculative tip / speculative parent was reconciled / open overtaken by canonical import / producer rebuilt in-progress block`, `Sequence stream session ended err="preconf application requires canonical re-anchor"`, `Preconf seal verification deferred`.
- Producers: `Slow transactions detected in the last 10 minutes`, `Chain head moved while acquiring sealing state, skipping work round`, `Possible producer stall: veblop fallback skipping while chain is stale` (informational unless the chain really stalled).
- el-9: `Relay service enabled but no block producer URLs provided` at boot (package config gap, not a fault effect).

---

## Episode catalog

All lines assume `source campaign/lib.sh` and use the wrapper. Replace `N` with `$(in_turn)` at run time. Hold times are what was used; `--post` is the observation window after recovery.

```bash
# --- sequence store (write path) ---
episode s01-pause-ingress --logs "seqstore-ingress ${EL[$(in_turn)]}" --post 60 -- --kind pause --node seqstore-ingress --for 60s
episode s02-kill-ingress  --logs "seqstore-ingress ${EL[$(in_turn)]} l2-el-9-bor-heimdall-v2-rpc" --post 75 -- --kind kill --node seqstore-ingress --for 45s
episode s03-kill-rp0      --logs "seqstore-ingress seqstore-gateway-0" --post 75 -- --kind kill --node seqstore-redpanda-0 --for 60s
episode s04-kill-rp2      --logs "seqstore-ingress seqstore-redpanda-2 ${EL[$(in_turn)]}" --post 90 -- --kind kill --node seqstore-redpanda-0 --node seqstore-redpanda-1 --for 60s
episode s07-netem-ingress --logs "seqstore-ingress ${EL[$(in_turn)]}" --post 60 -- --kind netem --node seqstore-ingress --param delay=400ms --param jitter=50ms --for 90s
episode s08-part-ingress-rp --logs "seqstore-ingress ${EL[$(in_turn)]}" --post 60 -- --kind partition --group seqstore-ingress --group seqstore-redpanda-0,seqstore-redpanda-1,seqstore-redpanda-2 --for 60s
# --- sequence store (read path) ---
episode s05-pause-gateways --logs "${EL[$(in_turn)]} seqstore-ingress l2-el-8-bor-heimdall-v2-rpc-archive" --post 75 -- --kind pause --node seqstore-gateway-0 --node seqstore-gateway-1 --node seqstore-gateway-2 --for 60s
episode s06-kill-envoy     --logs "seqstore-gateway ${EL[$(in_turn)]} l2-el-8-bor-heimdall-v2-rpc-archive" --post 75 -- --kind kill --node seqstore-gateway --for 45s
episode s11-netem-gateway  --logs "${EL[$(in_turn)]} l2-el-8-bor-heimdall-v2-rpc-archive" --post 60 -- --kind netem --node seqstore-gateway --param delay=400ms --param jitter=50ms --for 90s
episode s12-pause-gw0      --logs "seqstore-gateway l2-el-8-bor-heimdall-v2-rpc-archive" --post 60 -- --kind pause --node seqstore-gateway-0 --for 60s
episode s13-netem-gw0      --logs "seqstore-gateway-0 ${EL[$(in_turn)]}" --post 60 -- --kind netem --node seqstore-gateway-0 --param delay=400ms --param jitter=50ms --for 90s
episode s09-part-prod-store --logs "${EL[$(in_turn)]} seqstore-ingress" --post 60 -- --kind partition --group l2-el-1-bor-heimdall-v2-validator,l2-el-2-bor-heimdall-v2-validator,l2-el-3-bor-heimdall-v2-validator --group seqstore-ingress,seqstore-gateway,seqstore-gateway-0,seqstore-gateway-1,seqstore-gateway-2,seqstore-redpanda-0,seqstore-redpanda-1,seqstore-redpanda-2,seqstore-auditor --for 60s
episode s10-kill-auditor   --logs "seqstore-auditor" --post 45 -- --kind kill --node seqstore-auditor --for 45s
# --- producers ---
t=$(in_turn); episode p01-kill-inturn  --logs "${EL[$t]} ${EL[$((t%3+1))]} l2-el-8-bor-heimdall-v2-rpc-archive" --post 90 -- --kind kill --node "${EL[$t]}" --for 45s
t=$(in_turn); b=$((t%3+1)); episode p02-kill-2of3 --logs "${EL[$((b%3+1))]} ${EL[$t]}" --post 120 -- --kind kill --node "${EL[$t]}" --node "${EL[$b]}" --for 90s
episode p03-kill-3of3 --logs "l2-el-4-bor-heimdall-v2-validator l2-el-8-bor-heimdall-v2-rpc-archive l2-cl-4-heimdall-v2-bor-validator" --post 150 -- --kind kill --node l2-el-1-bor-heimdall-v2-validator --node l2-el-2-bor-heimdall-v2-validator --node l2-el-3-bor-heimdall-v2-validator --for 60s
t=$(in_turn); episode p04-pause-inturn --logs "${EL[$t]} ${EL[$((t%3+1))]}" --post 120 -- --kind pause --node "${EL[$t]}" --for 60s
t=$(in_turn); others=$(for n in 1 2 3 4 5 6 7 8 9; do [[ $n != $t ]] && printf '%s,' "${EL[$n]}"; done); episode p05-part-inturn-bor --logs "${EL[$t]} ${EL[$((t%3+1))]} l2-el-8-bor-heimdall-v2-rpc-archive l2-cl-$t-heimdall-v2-bor-validator" --post 120 -- --kind partition --group "${EL[$t]}" --group "${others%,}" --for 90s
t=$(in_turn); episode p07-netem-inturn --logs "${EL[$t]} ${EL[$((t%3+1))]}" --post 90 -- --kind netem --node "${EL[$t]}" --param delay=800ms --param jitter=100ms --for 90s
t=$(in_turn); episode p15-loss-inturn  --logs "${EL[$t]}" --post 90 -- --kind netem --node "${EL[$t]}" --param delay=1ms --param loss_percent=30 --for 90s
# --- heimdall / bridge / L1 ---
t=$(in_turn); episode p06-part-inturn-cl --logs "${CL[$t]} ${EL[$t]}" --post 90 -- --kind partition --group "${CL[$t]}" --group "$(for n in 1 2 3 4 5 6 7 8 9; do [[ $n != $t ]] && printf '%s,' "${CL[$n]}"; done | sed 's/,$//')" --for 90s
t=$(in_turn); episode p08-kill-inturn-cl --logs "${CL[$t]} ${EL[$t]}" --post 90 -- --kind kill --node "${CL[$t]}" --for 60s
t=$(in_turn); episode p09-kill-rabbit    --logs "l2-cl-$t-rabbitmq ${CL[$t]}" --post 60 -- --kind kill --node "l2-cl-$t-rabbitmq" --for 60s
episode p10-pause-3cl      --logs "l2-cl-1-heimdall-v2-bor-validator l2-el-1-bor-heimdall-v2-validator" --post 120 -- --kind pause --node l2-cl-4-heimdall-v2-bor-validator --node l2-cl-5-heimdall-v2-bor-validator --node l2-cl-6-heimdall-v2-bor-validator --for 90s
episode p13-pause-3cl-long --logs "l2-cl-1-heimdall-v2-bor-validator l2-el-1-bor-heimdall-v2-validator l2-el-2-bor-heimdall-v2-validator l2-el-3-bor-heimdall-v2-validator" --post 150 -- --kind pause --node l2-cl-4-heimdall-v2-bor-validator --node l2-cl-5-heimdall-v2-bor-validator --node l2-cl-6-heimdall-v2-bor-validator --for 240s
episode p11-kill-witness4  --logs "l2-el-4-bor-heimdall-v2-validator l2-cl-4-heimdall-v2-bor-validator" --post 120 -- --kind kill --node l2-el-4-bor-heimdall-v2-validator --node l2-el-5-bor-heimdall-v2-validator --node l2-el-6-bor-heimdall-v2-validator --node l2-el-7-bor-heimdall-v2-validator --for 60s
episode p17-kill-prod-cl   --logs "l2-el-1-bor-heimdall-v2-validator l2-cl-4-heimdall-v2-bor-validator" --post 120 -- --kind kill --node l2-cl-1-heimdall-v2-bor-validator --node l2-cl-2-heimdall-v2-bor-validator --node l2-cl-3-heimdall-v2-bor-validator --for 90s
episode p12-kill-rpc9      --logs "l2-el-9-bor-heimdall-v2-rpc" --post 90 -- --kind kill --node l2-el-9-bor-heimdall-v2-rpc --for 45s
# L1: never SIGKILL the single geth (F11). Use signal=TERM or pause.
episode p16-stop-l1        --logs "l2-cl-1-heimdall-v2-bor-validator el-1-geth-lighthouse" --post 120 -- --kind kill --node el-1-geth-lighthouse --param signal=TERM --for 120s
```

---

## Expected outcomes (2026-09-10 baseline, regress against these)

| episode | block rate during | network stall | other expected signature |
| --- | --- | --- | --- |
| s01 pause ingress | 0.75 | 0 | seals ~510 ms, `Sequencer ack stall, reconnecting` every 5 s, `backfill jumping finalized heights` (F1) |
| s02 kill ingress | 0.78 | 1 s | one large hole; ingress replays topic on boot, `takeovers ok=1`, no self-fence |
| s03 kill 1 broker | 1.00 | 0 | nothing |
| s04 kill 2 brokers | 0.74 | 2 s | ingress stops committing (min.insync), kgo WARN storm, F1 holes |
| s05 pause 3 gateways | **0.47** | 3 s | `could not read the store at build start`, `tail read rung out of budget` every block (F3) |
| s06 kill envoy | 0.71 | 4 s | consumers `name resolver error: produced zero addresses` |
| s07 netem 400 ms ingress | 0.67 | 0 | barrier +1 per block, no WARN at all (F2) |
| s08 partition ingress/brokers | 0.74 | 2 s | as s04 |
| s09 partition producers/store | 0.61 | 2 s | seals ~753 ms, cadence 1.6 s |
| s10 kill auditor | 1.00 | 2 s | auditor re-reports old supersessions on restart (F4 evidence) |
| s11 netem 400 ms envoy | **0.51** | 2 s | barrier +45, F3 by latency alone |
| s12 pause 1 gateway | 1.00 | 0 | barrier +6 while envoy ejects it |
| s13 netem 400 ms 1 gateway | 1.00 | 0 | barrier +61, 90 store-read WARNs, no throughput loss |
| p01 kill in-turn | 0.78 | 11 s | takeover ~11.5 s; killed node repairs state, back in < 30 s |
| p02 kill 2 of 3 | 0.90 | 7 s | survives |
| p03 kill 3 of 3 | 0.00 | 95 s | halt = hold + ~33 s; followers lag 55-85 s after restart (re-peering) |
| p04 pause in-turn | 0.82 | 7 s | 1-block local reorg on the frozen node only |
| p05 partition in-turn bor | 0.73 | 12 s | 11-block private fork, 9-block local rewind; fallback slowed by foreign store seals (F7) |
| p14 same + store cut off | 0.92 | 6 s | 4-block fork, no fallback penalty |
| p06 partition in-turn heimdall | 0.99 | 0 | nothing; sibling resyncs |
| p07 netem 800 ms in-turn | 0.47 | 1 s | no fallback, no fork |
| p15 loss 30 % in-turn | 0.78 | 2 s | no fallback, no fork |
| p08 kill in-turn heimdall | 1.00 | 0 | `Heimdall failover: switched to client` |
| p09 kill rabbitmq | 1.00 | 0 | heimdall bridge tasks retry with backoff to 34 s |
| p10 pause 3 heimdalls 90 s | 0.99 | 29 s on their bors | milestones frozen 93 s; crosses one span boundary |
| p13 pause 3 heimdalls 240 s | 0.81 | **60 s halt at span end** | resumes 17 s after quorum (F10) |
| p11 kill 4 witness bors | 1.02 | 0 | **milestones frozen 94 s** (F9); witness nodes repair state on restart |
| p12 kill el-9 | 1.00 | 0 | consumer re-anchors |
| p16 kill L1 geth (SIGKILL) | 1.00 | 0 | L1 reset to block 7, checkpoints stop for good (F11): use TERM |
| p17 kill 3 producer heimdalls | 1.01 | 0 | milestones frozen 94 s, chain unaffected |

Any result materially worse than these is a regression; any result better on s05/s07/s11 or p05 means F2/F3/F7 were addressed and the table should be updated.

---

## Bor <-> heimdall connectivity matrix (2026-09-14, `campaign/HEIMDALL-MATRIX.md`)

What decides the outcome is the failure *mode*, not the component:

| mode (in-turn producer's heimdall) | network | producer | fork |
| --- | --- | --- | --- |
| kill / stop (connection refused) | continues 1.00 | fails over in ~1 s | no |
| pause (frozen) | continued 1.00 in h02, but only because the health registry switched (~10 s) before the next sprint-start call; otherwise like partition | | no |
| partition (own heimdall only) | 14 s gap, producer rotated, 0.86 | blocked 30 s on `clerk/time`, then wedged until heal +15 s | no |
| partition from all heimdalls | 14-17 s gap, rotated, 0.80-0.89 | sealed 5-10 blocks, then wedged **past the heal**; restart required | 1 private block |
| netem 2 s latency | 13 s gap, rotated, 0.83 | stuck for the hold, no failover ever, self-healed | no |
| all 9 heimdalls paused / killed | **halt** 0.09-0.14, 65-86 s stalls | in-turn producer sealed 14-16 blocks nobody imported | **14-16 block reorg on that producer** at recovery (retroactive rotation) |
| witness bor cut from all heimdalls (control) | 1.01 | stops importing for the hold, self-heals | no |

Mechanisms to remember: followers gate every import on a heimdall milestone fetch; producers block on `clerk/time` at each sprint start and `bor/spans/latest` near span ends with a 30 s attempt timeout; heimdall rotates an "ineffective" producer after ~11 heimdall blocks and does so retroactively from the last milestone on recovery; the `[heimdall] url` list (all 9 heimdalls in this package) is what makes kills harmless. Findings H1-H6 and the proposed `launcher.star` fix are in the matrix document.

---

## Report format

Keep one `CAMPAIGN.md` per campaign with: executive summary; topology under test; oracle description and baseline; plan/status table (ids, fault, targets, hold, hypothesis, status); the `summary.py` table; one section per episode (hypothesis, fault with record timestamps, observations with file names and quoted log lines, result, recovery); numbered findings ranked by impact with evidence pointers; close-out (`tartarus fault list` empty, `cleanup --all`, leftover iptables/tc check, enclave state); evidence layout; not-tested list. Quote record fields verbatim, distinguish primitive verification (tartarus saw it paused) from application behavior (block rate fell), and when an early reading turns out wrong, say so in the episode text rather than silently rewriting it.

---

## Ideas not yet run

Redpanda disk pressure; ingress outage > 5 min; two producers isolated at once; witness set partitioned from producers; CPU/memory throttling (`docker update`, no tartarus kind yet); flapping faults (repeated short kills); tx-level preconf accounting across F1/F7 windows; repeating p11/p13 after fixes to measure recovery.
