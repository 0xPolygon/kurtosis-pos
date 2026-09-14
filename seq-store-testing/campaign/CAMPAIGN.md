# Chaos campaign: robust-seqstore.yml on enclave `pos`

## Executive summary

30 fault episodes (kill, pause, partition, netem latency/loss) against the sequence store, the block producers, the heimdall layer and the L1, 2026-09-10 22:15Z to 2026-09-11 00:12Z, with a 1 Hz oracle on all nine bor nodes and 5 tx/s of background load. Headline results:

- **No network-wide reorg and no unrecoverable halt in any episode.** The only reorgs were on isolated or frozen producers themselves (p04: 1 block, p05: 9 blocks, p14: 1 block); no connected node ever changed the hash of a height it had reported. Stopping 2 of 3 producers (p02) was survived with a 7 s gap; stopping all 3 (p03) halted for the hold plus ~33 s and recovered cleanly.
- **The sequence store is on the block-production critical path (F2, F3), contrary to the design brief.** Ingress outage or latency costs 25-33 % throughput; gateway/envoy outage or latency costs ~50 %; both together (s09) 39 %. Cause: a 500 ms ConfirmSeal barrier on publish plus a 1 s tail read through the gateway LB at every block build.
- **The store lags and lies during outages (F1, F4, F7).** The producer skips publishing whole block ranges when the ingress is unavailable, the auditor then reports those sealed, canonical blocks as "reorg, all txs dropped", and an isolated in-turn producer keeps feeding the store a fork that slows the fallback producer.
- **Heimdall dependencies define the halt budget (F9, F10).** Losing 3 of 7 heimdalls, or merely the bor nodes of the 4 witness-sync validators, freezes soft finality immediately; block production survives only until the end of the already-committed span, then halts until quorum returns (61 s halt in p13). Bor's heimdall failover (p08, p17) makes a producer's own heimdall dispensable.
- **Log hygiene (F5, F6, F8), a client-facing blip on producer kills (F12: nginx 504s for a few seconds), and one devnet hazard (F11: SIGKILL of the single L1 geth resets it to block 7 and stops checkpoints permanently).**

Findings are ranked in the Findings section; every episode has a record under `records/` and an entry below.

Started 2026-09-10 (UTC evening). Tool: tartarus (kill / pause / partition /
netem-latency). Focus: the sequence store first, then the block producers.
Anything that halts the chain, reorgs, or leaves a node unable to rejoin is a
finding. Stopping 2 of 3 producers must be survivable.

## Topology under test

See `../topology.svg`. Validator N is `l2-el-N` / `l2-cl-N`, signer `0xNNNN...`.
Producers (in `producer_votes`): validators 1, 2, 3. VeBlop elects ONE producer
per 128-block span, so "in-turn" is a single node; the other two producers
are backups. Validators 4-7 are stateless witness-sync, stake and sign
checkpoints but never seal. 7 equal-stake validators: CometBFT tolerates 2
faulty; losing 3 halts Heimdall consensus (milestones, checkpoints, spans).

Sequence store: `seqstore-ingress` (single writer, transactional producer into
Redpanda rf=3 min.insync=2), 3 gateways behind envoy `seqstore-gateway`, an
auditor. Producers publish to the ingress over gRPC; RPC nodes el-8 and el-9
stream from the gateway LB and serve preconfs.

## Oracle

`campaign/probe.sh` (1 Hz, `probes/oracle.log`): block author, milestone end
block, checkpoint count, ingress ok-entries, gateway-0 position, every node's
head number:hash, and each producer's `sequencer_publish_*` counters plus
seal-to-broadcast p50. `campaign/loadtest.sh` keeps 5 tx/s of counter calls
flowing through nginx (`probes/loadtest.log`). `campaign/analyze.py <id>`
summarizes a fault window: stalls, hash divergence, reorgs, finality and
store progress, producer publish deltas.

Baseline (before any fault): 0 ERROR / 0 WARN in the last 2000 bor log lines
on all nine nodes; all heads agree; milestone trails head by ~5 blocks;
ingress `publisher_streams=3`, `self_fences_total=0`, `takeovers ok=1`;
producer `sequencer_publish_ack` p50 3.8 ms, `barriertimeout=0`.

## Plan and status

Legend: `[ ]` planned, `[x]` done, `!` finding, `~` degraded but recovered, `ok` no impact.

### Sequence store

| id                  | fault        | targets                  | hold | hypothesis                                                                        | status                                |
| ------------------- | ------------ | ------------------------ | ---- | --------------------------------------------------------------------------------- | ------------------------------------- |
| s01-pause-ingress   | pause        | seqstore-ingress         | 60s  | chain continues; producers hit the 500 ms ConfirmSeal barrier, seal latency rises | [x] ~ F1                              |
| s02-kill-ingress    | kill+restart | seqstore-ingress         | 45s  | publishers redial; one takeover; no self-fence; no gap in entries                 | [x] ~ F1 (43-block gap)               |
| s03-kill-rp1        | kill+restart | seqstore-redpanda-0      | 60s  | rf=3/min.insync=2 absorbs one broker; ingress commits continue                    | [x] ok                                |
| s04-kill-rp2        | kill+restart | redpanda-0, redpanda-1   | 60s  | below min.insync: ingress cannot commit; do producers stall or only degrade?      | [x] ~ F1 (67 s no commits)            |
| s05-pause-gateways  | pause        | gateway-0,1,2            | 60s  | RPC consumers lose stream; preconfs stop on el-8/9; chain unaffected              | [x] ! F3 (0.47 blocks/s)              |
| s06-kill-envoy      | kill+restart | seqstore-gateway         | 45s  | consumers reconnect after envoy returns                                           | [x] ~ F3 (0.71 blocks/s)              |
| s07-netem-ingress   | netem 400ms  | seqstore-ingress         | 90s  | ack latency > barrier? seal latency pinned                                        | [x] ~ F2 (0.67 blocks/s, barrier +61) |
| s08-part-ingress-rp | partition    | ingress vs redpanda-*    | 60s  | ingress cannot flush; same signature as s04                                       | [x] ~ F1/F2 (0.74 blocks/s)           |
| s09-part-prod-store | partition    | el-1,2,3 vs seqstore-*   | 60s  | producers publish_failed/redial, chain continues                                  | [x] ~ F2+F3 (0.61 blocks/s)           |
| s10-kill-auditor    | kill+restart | seqstore-auditor         | 45s  | no impact                                                                         | [x] ok (see F4 evidence)              |
| s11-netem-gateway   | netem 400ms  | seqstore-gateway (envoy) | 90s  | slow reads: tail read budget burned every block                                   | [x] ! F3 (0.51 blocks/s)              |

### Block producers

| id                  | fault        | targets                        | hold | hypothesis                                                                                | status                                                                        |
| ------------------- | ------------ | ------------------------------ | ---- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| p01-kill-inturn     | kill+restart | in-turn el-N                   | 45s  | backup producer takes over after timeout; short stall; no reorg                           | [x] ~ 10 s stall, F5                                                          |
| p02-kill-2of3       | kill+restart | in-turn + one backup           | 90s  | remaining producer takes over; chain survives                                             | [x] ok 7 s stall, survived                                                    |
| p03-kill-3of3       | kill+restart | el-1,2,3                       | 60s  | chain halts (4-7 cannot seal); resumes on restart; no reorg                               | [x] ~ 95 s halt as designed, no reorg                                         |
| p04-pause-inturn    | pause        | in-turn el-N                   | 60s  | like kill but the node is frozen, not gone; on unpause it may seal stale blocks -> reorg? | [x] ~ 1-block local reorg on the paused node only                             |
| p05-part-inturn-bor | partition    | in-turn el-N vs all other el-* | 90s  | isolated producer forks; rewinds on milestone mismatch (reorg on that node only)          | [x] ~ 11-block private fork, 9-block local rewind; 12 s stall; F7             |
| p06-part-inturn-cl  | partition    | in-turn cl-N vs other cl-*     | 90s  | 1 of 7 heimdall out: consensus fine; bor of that node loses span/milestone feed           | [x] ok, no impact                                                             |
| p07-netem-inturn    | netem 800ms  | in-turn el-N                   | 90s  | slow block propagation; backups may take over -> possible fork                            | [x] ~ 0.47 blocks/s, no fallback, no fork                                     |
| p08-kill-inturn-cl  | kill+restart | in-turn cl-N                   | 60s  | bor keeps sealing within span using cached span; milestones continue (6 of 7)             | [x] ok, heimdall failover to cl-1                                             |
| p09-kill-rabbit     | kill+restart | l2-cl-N-rabbitmq of in-turn    | 60s  | no impact on sealing; state-sync path only                                                | [x] ok                                                                        |
| p10-pause-3cl       | pause        | cl-4,5,6                       | 90s  | 4 of 7 < 2/3: heimdall halts; bor continues; milestones stop; does bor stop at span end?  | [x] ~ milestones frozen 93 s, chain 0.99/s, crossed 1 span boundary (see p13) |
| p11-kill-witness4   | kill+restart | el-4..7                        | 60s  | producers unaffected; witnesses resync                                                    | [x] ! F9 milestones frozen 94 s; F8 receipt mismatch on rejoin                |
| p12-kill-rpc9       | kill+restart | el-9                           | 45s  | consumer resumes stream from position; preconfs resume                                    | [x] ok                                                                        |
| s12-pause-gw0       | pause        | seqstore-gateway-0 only        | 60s  | envoy health check routes around it; no impact                                            | [x] ok (barrier +6 while envoy noticed)                                       |
| s13-netem-gw0       | netem 400ms  | seqstore-gateway-0 only        | 90s  | a slow-but-ready gateway is not ejected; 1/3 of tail reads slow                           | [x] ~ rate 1.00, barrier +61, 90 store-read WARNs                             |

### Added during the campaign

| id                  | fault          | targets                                         | hold | hypothesis                                                                    | status                                                |
| ------------------- | -------------- | ----------------------------------------------- | ---- | ----------------------------------------------------------------------------- | ----------------------------------------------------- |
| p13-pause-3cl-long  | pause          | cl-4,5,6                                        | 240s | quorum loss longer than the span runway: bor halts at the span boundary       | [x] ! F10 halted 61 s at 8319 (span end)              |
| p14-part-inturn-all | partition      | in-turn el-N vs all other el-* + all seqstore-* | 90s  | compare with p05: no store fork entries -> faster fallback                    | [x] ~ 6 s stall, 0.92 blocks/s; confirms F7           |
| p15-loss-inturn     | netem loss 30% | in-turn el-N                                    | 90s  | retransmits slow propagation; fallback may fire                               | [x] ~ 0.78 blocks/s, no fallback, no fork             |
| p16-kill-l1         | kill+restart   | el-1-geth-lighthouse                            | 120s | checkpoints stall; L2 unaffected; resumes                                     | [x] ~ L2 1.00/s; L1 resync after SIGKILL, see episode |
| p17-kill-prod-cl    | kill+restart   | cl-1,2,3                                        | 90s  | producers fail over to witness heimdalls; 4 of 7 heimdall -> milestones stall | [x] ~ chain 1.01/s, milestones frozen 94 s            |

## Cross-episode summary

Generated by `campaign/summary.py` from `records/*.json` and `probes/oracle.log`. Baseline is 1.00 block/s. "network stall" is the longest gap with no new block on nodes other than the faulted one; "worst node stall" includes the faulted node itself. Per-node reorgs counts a node changing the hash it reports for a height it already reported (0 everywhere: no node other than an isolated producer ever reorged, and those rewinds show up as "height backwards").

| id                  | fault                      | targets                                                                 | hold s | blocks/s during | network stall s | worst node stall s | per-node reorgs | height backwards | milestone frozen s |
| ------------------- | -------------------------- | ----------------------------------------------------------------------- | ------ | --------------- | --------------- | ------------------ | --------------- | ---------------- | ------------------ |
| p01-kill-inturn     | kill                       | l2-el-1-validator                                                       | 46     | 0.78            | 11              | 64                 | 0               | 1                | 10                 |
| p02-kill-2of3       | kill                       | l2-el-2-validator,l2-el-3-validator                                     | 93     | 0.90            | 7               | 7                  | 0               | 0                | 11                 |
| p03-kill-3of3       | kill                       | l2-el-1-validator,l2-el-2-validator,l2-el-3-validator                   | 64     | 0.00            | 95              | 95                 | 0               | 0                | 95                 |
| p04-pause-inturn    | pause                      | l2-el-2-validator                                                       | 60     | 0.82            | 7               | 10                 | 0               | 0                | 10                 |
| p05-part-inturn-bor | partition                  | 1 vs 8 nodes                                                            | 91     | 0.73            | 12              | 89                 | 0               | 1                | 9                  |
| p06-part-inturn-cl  | partition                  | 1 vs 8 nodes                                                            | 91     | 0.99            | 0               | 5                  | 0               | 0                | 3                  |
| p07-netem-inturn    | netem-latency 800ms        | l2-el-1-validator                                                       | 90     | 0.47            | 1               | 1                  | 0               | 0                | 4                  |
| p08-kill-inturn-cl  | kill                       | l2-cl-3-validator                                                       | 61     | 1.00            | 0               | 0                  | 0               | 0                | 3                  |
| p09-kill-rabbit     | kill                       | l2-cl-1-rabbitmq                                                        | 60     | 1.00            | 0               | 0                  | 0               | 0                | 2                  |
| p10-pause-3cl       | pause                      | l2-cl-4-validator,l2-cl-5-validator,l2-cl-6-validator                   | 90     | 0.99            | 29              | 29                 | 0               | 0                | 93                 |
| p11-kill-witness4   | kill                       | l2-el-4-validator,l2-el-5-validator,l2-el-6-validator,l2-el-7-validator | 65     | 1.02            | 98              | 98                 | 0               | 4                | 94                 |
| p12-kill-rpc9       | kill                       | l2-el-9-rpc                                                             | 46     | 1.00            | 0               | 2                  | 0               | 0                | 2                  |
| p13-pause-3cl-long  | pause                      | l2-cl-4-validator,l2-cl-5-validator,l2-cl-6-validator                   | 240    | 0.81            | 60              | 60                 | 0               | 0                | 242                |
| p14-part-inturn-all | partition                  | 1 vs 17 nodes                                                           | 91     | 0.92            | 6               | 90                 | 0               | 2                | 8                  |
| p15-loss-inturn     | netem-latency 1ms loss 30% | l2-el-3-validator                                                       | 90     | 0.78            | 2               | 2                  | 0               | 0                | 2                  |
| p16-kill-l1         | kill                       | el-1-geth-lighthouse                                                    | 121    | 1.00            | 0               | 0                  | 0               | 0                | 2                  |
| p17-kill-prod-cl    | kill                       | l2-cl-1-validator,l2-cl-2-validator,l2-cl-3-validator                   | 93     | 1.01            | 0               | 0                  | 0               | 0                | 94                 |
| s01-pause-ingress   | pause                      | ingress                                                                 | 60     | 0.75            | 0               | 0                  | 0               | 0                | 2                  |
| s02-kill-ingress    | kill                       | ingress                                                                 | 45     | 0.78            | 1               | 1                  | 0               | 0                | 2                  |
| s03-kill-rp0        | kill                       | redpanda-0                                                              | 61     | 1.00            | 0               | 0                  | 0               | 0                | 2                  |
| s04-kill-rp2        | kill                       | redpanda-0,redpanda-1                                                   | 62     | 0.74            | 1               | 2                  | 0               | 0                | 2                  |
| s05-pause-gateways  | pause                      | gateway-0,gateway-1,gateway-2                                           | 60     | 0.47            | 3               | 3                  | 0               | 0                | 2                  |
| s06-kill-envoy      | kill                       | gateway                                                                 | 45     | 0.71            | 4               | 4                  | 0               | 0                | 3                  |
| s07-netem-ingress   | netem-latency 400ms        | ingress                                                                 | 90     | 0.67            | 0               | 0                  | 0               | 0                | 2                  |
| s08-part-ingress-rp | partition                  | 1 vs 3 nodes                                                            | 60     | 0.74            | 1               | 2                  | 0               | 0                | 2                  |
| s09-part-prod-store | partition                  | 3 vs 9 nodes                                                            | 61     | 0.61            | 2               | 2                  | 0               | 0                | 2                  |
| s10-kill-auditor    | kill                       | auditor                                                                 | 46     | 1.00            | 2               | 2                  | 0               | 0                | 2                  |
| s11-netem-gateway   | netem-latency 400ms        | gateway                                                                 | 90     | 0.51            | 2               | 2                  | 0               | 0                | 2                  |
| s12-pause-gw0       | pause                      | gateway-0                                                               | 60     | 1.00            | 0               | 0                  | 0               | 0                | 2                  |
| s13-netem-gw0       | netem-latency 400ms        | gateway-0                                                               | 90     | 1.00            | 0               | 0                  | 0               | 0                | 2                  |

## Episodes

### s01-pause-ingress — pausing the ingress must not stop the chain

**Hypothesis.** Store is off the critical path for sealing; expect no stall, maybe higher seal latency.

**Fault.** kind=pause node=seqstore-ingress. record `records/s01-pause-ingress.json`:
started_at 22:15:14.377Z, applied 22:15:14.449Z, verified 22:15:14.474Z (observed status=paused), stopped 22:16:14.571Z. In-turn producer: v1 (l2-el-1) for the whole hold (span 3072-3199).

**Observations.** `probes/oracle.log` 22:13:44..22:17:44Z, `records/s01-pause-ingress-l2-el-1-bor-heimdall-v2-validator.log`.

- Heights advanced on all 9 nodes throughout; max stall 0 s; no divergence, no reorg; milestone never unchanged > 2 s; checkpoints 75 -> 79.
- el-1 `Successfully sealed new block ... elapsed` went from 3-10 ms to 503-521 ms on every block during the pause (the 500 ms ConfirmSeal barrier), back to ms after unpause. `sequencer_publish_barriertimeout` 0 -> 9.
- el-1 WARN every ~5 s: `Sequencer ack stall, reconnecting inflight=11..19 waited=5.04s`.
- el-1 WARN 7x: `Sequencer backfill jumping finalized heights from=3138 through=3140 floor=3141` (and 3141.., 3146.., 3151.., 3157.., 3164.., 3175..): the publisher skips ranges instead of queueing them.
- Ingress on unpause: `entry rejected kind=open height=3157 status=stale_commitment`, same for 3141. Ingress ok-entries 6204 -> 6206 over the 60 s, then resumed.

**Result.** Hypothesis confirmed for liveness. Degradation: ~500 ms extra seal latency per block on the in-turn producer, and the store permanently lacks the lifecycle entries for the blocks sealed during the outage (see F1).

**Recovery.** state=completed, recovery=recovered, restored status=running. Seal latency normal within one block of unpause. No endpoint changes.

### s02-kill-ingress — killing the ingress; publishers must redial and the store must resume without self-fencing

**Fault.** kind=kill node=seqstore-ingress restart=true. `records/s02-kill-ingress.json`: started 22:19:07.702Z, applied 22:19:08.274Z, stopped 22:19:53.699Z. In-turn producer v3 (l2-el-3). `endpoint_changes`: 4 (9550 -> 36233, 9600 -> 36235 on both address families).

**Observations.** oracle 22:17:37..22:21:23Z; logs `records/s02-kill-ingress-{seqstore-ingress,l2-el-2,l2-el-3,l2-el-9}*.log`.

- All nodes advanced; max stall 1 s; no divergence, no reorg; milestone never unchanged > 2 s; checkpoints 80 -> 84.
- el-3 (in-turn): 125 seals in the window, 35 slow (>= 100 ms), max 546 ms; `sequencer_publish_barriertimeout` 0 -> 3. One WARN `Sequencer backfill jumping finalized heights from=3355 through=3397 floor=3398`: a single 43-block hole in the store.
- el-1, el-2 (backups): `sequencer_publish_redial` 0 -> 1, WARN `Sequencer redialed the store after prolonged silence`. Seals normal.
- Ingress after restart: `seqstore_ingress_replay_entries 6885` (replayed the whole topic at boot), `takeovers_total{ok}=1`, `self_fences_total=0`, `publisher_streams=3` within the post window.
- el-9 at 22:20:05Z (12 s after ingress restart): 2x WARN `Preconf application skipped: open parent neither canonical nor speculative tip`; then normal. `sequencer_preconf_pendingentries=1` afterwards.

**Result.** Liveness hypothesis confirmed. Same degradation as s01 (F1) but with one large hole instead of several small ones, because nothing accepted entries for 45 s.

**Recovery.** state=completed, recovery=recovered; ingress ports moved (probes re-read them).

### s03-kill-rp0 — one Redpanda broker down is absorbed

**Fault.** kind=kill node=seqstore-redpanda-0 restart=true. `records/s03-kill-rp0.json`: started 22:22:03.424Z, applied 22:22:04.197Z, stopped 22:23:04.602Z. In-turn v1. `endpoint_changes`: 4 (broker ports moved).

**Observations.** oracle 22:20:33..22:24:34Z. No stall (0 s), no divergence, no reorg. Ingress ok-entries 148 -> 1079 through the hold (commits never paused). el-1 seals: 97, 0 slow, max 41 ms; no barrier timeouts, no redials, no WARN/ERROR on ingress, gateway-0, or el-1.

**Result.** Hypothesis confirmed: rf=3 / min.insync=2 fully masks one broker loss. No degradation observed.

**Recovery.** state=completed, recovery=recovered; broker rejoined (no WARN in gateway-0 log).

### s04-kill-rp2 — two of three brokers down: ingress below min.insync

**Fault.** kind=kill nodes=seqstore-redpanda-0, seqstore-redpanda-1 restart=true. `records/s04-kill-rp2.json`: started 22:25:25.172Z, applied 22:25:26.546Z, stopped 22:26:27.358Z. In-turn v3 (l2-el-3). `endpoint_changes`: 8 (both brokers' ports moved).

**Observations.** oracle 22:23:55..22:27:57Z; logs `records/s04-kill-rp2-{seqstore-ingress,seqstore-redpanda-2,l2-el-2,l2-el-3,l2-el-9}*.log`.

- Chain: all nodes advanced, max stall 2 s (el-1, once); no divergence, no reorg; milestones and checkpoints (88 -> 93) unaffected.
- Ingress `window committed` lines: 4/s until 22:25:25, then **none until 22:26:33** (67 s; brokers restarted 22:26:27). Ingress ok-entries flat at 1364 for the whole hold. kgo WARN storm: `unable to open connection to broker`, `unable to AddPartitionsToTxn due to retryable broker err`, `produce partition load error` (thousands of lines, 24644-line log).
- redpanda-2 (survivor): `node_isolation_watcher: Is node isolated: true` at 22:25:35, back to false at 22:26:27; raft vote_request WARNs on `kafka_internal/tx` groups while re-electing.
- el-3 (in-turn): 127 seals, 51 slow (>= 100 ms), max 566 ms, mean 208 ms; barrier 3 -> 12; 7x `Sequencer backfill jumping finalized heights` covering 3723..3774. On recovery the ingress rejected the late entries for 3723.. as `stale_commitment`.
- el-9: 6x `Preconf application skipped: open parent neither canonical nor speculative tip`, 1x `open overtaken by canonical import number=3840` after the store caught up.

**Result.** Hypothesis confirmed: with only one broker the ingress cannot satisfy min.insync=2 and stops committing; the chain only degrades (F1 signature: ~500 ms seals, holes 3723-3774). Redpanda quorum re-formed within ~6 s of the brokers returning.

**Recovery.** state=completed, both instances recovered; commits resumed at 22:26:33Z.

### s05-pause-gateways — the read path (gateways) is also on the sealing path

**Hypothesis.** Gateways only serve consumers; pausing all three should leave block production untouched.

**Fault.** kind=pause nodes=seqstore-gateway-0,1,2 (fan-out under one id). `records/s05-pause-gateways.json`: started 22:28:52.693Z, applied 22:28:52.844Z, stopped 22:29:53.142Z. In-turn v1 (l2-el-1) throughout. No endpoint changes.

**Observations.** oracle 22:27:22..22:31:23Z; `records/s05-pause-gateways-{l2-el-1,seqstore-ingress,seqstore-gateway-0,l2-el-8,l2-el-9}*.log`.

- **Block rate 1.01/s before -> 0.47/s during -> 1.00/s after** (26 blocks in 55 s). All nine nodes saw a 3 s gap at 22:29:45Z. No divergence, no reorg, milestones fine.
- el-1 log per block: WARN `Sequencer could not read the store at build start number=N` (every block 3928..3937), WARN `Sequencer tail read rung out of budget, probing near tip` (34x), INFO `Coverage check skipped number=N reason="tail unreadable" outcome=1`. Seal cadence 2.0 s instead of 1.0 s (3930 @38.66, 3931 @40.67, 3932 @42.65 ...). `sequencer_publish_barriertimeout` 9 -> 39, `sequencer_gate_unknown` 51.
- The ingress kept committing normally (ok-entries 1927 -> 2034 over the hold) - the write path was healthy; only reads were blocked.
- After unpause: el-1 `Store holds content this block does not cover, adopting number=3937 ours=10 storeWindow=2`; el-8/el-9 25x `Preconf application skipped: open parent neither canonical nor speculative tip` and 1x `producer rebuilt in-progress block number=3937` while replaying the backlog.
- bor source: `eth/sequencer/reader.go` `tailReadTimeout = time.Second`; `adoption.go:211` logs the build-start read failure; `barrier.go` the coverage check. The producer reads its own tail through `consumer-endpoint = "seqstore-gateway:9550"` (config.toml) at every block build.

**Result.** Hypothesis refuted. The producer performs a synchronous tail read against the gateway LB at build start with a 1 s timeout, so an unreachable gateway pool costs ~1 s per block: throughput halves.

**Recovery.** state=completed, all three instances recovered; cadence back to 1 block/s within one block of unpause.

### s06-kill-envoy — killing the gateway front (envoy)

**Fault.** kind=kill node=seqstore-gateway restart=true. `records/s06-kill-envoy.json`: started 22:32:25.130Z, applied 22:32:25.662Z, stopped 22:33:11.108Z. In-turn v2 -> v3 (span boundary 4096 during the hold). `endpoint_changes`: 4.

**Observations.** Block rate 1.01 -> **0.71** -> 1.00; 4 s gap on all nodes at 22:32:32Z (right after the kill). No divergence/reorg. el-2: 8x `Sequencer tail read err="... connection error ... dial tcp"`, 1x `name resolver error: produced zero addresses`, 7x `could not read the store at build start`; seals themselves fast (max 46 ms); barrier p2 0 -> 7, p3 12 -> 15. el-8: 22x `Sequence stream session ended err="open stream: ... name resolver error: produced zero addresses"` then 1x `EOF`; 11x `Preconf application skipped ...` on catch-up, plus a new variant `speculative parent was reconciled`.

**Result.** Same mechanism as s05 with a faster failure mode (connection refused / no DNS resolves quickly, so less than the 1 s budget is burned). Consumers reconnect on their own once envoy is back.

### s07-netem-ingress — 400 ms (+-50 ms) one-way latency on the ingress

**Fault.** kind=netem-latency node=seqstore-ingress delay=400ms jitter=50ms. `records/s07-netem-ingress.json`: started 22:35:32.678Z, applied 22:35:32.722Z, stopped 22:37:02.851Z. In-turn v1. No endpoint changes.

**Observations.** Block rate 1.00 -> **0.67** -> 0.98 (59 blocks in 88 s). No stalls > 0 s, no divergence, no reorg. `sequencer_publish_barriertimeout` on el-1 39 -> 100 (+61 in ~88 blocks: the 500 ms barrier trips on most blocks once the round trip to the ingress exceeds it). No WARN/ERROR anywhere; the ingress kept committing (ok-entries 2859 -> 3679). A quiet 33 % throughput loss.

**Result.** Latency alone, with everything up, degrades cadence. Anything that pushes ingress RTT past ~500 ms is equivalent to an outage for the barrier.

### s08-part-ingress-rp — ingress cut off from all brokers

**Fault.** kind=partition groups=[seqstore-ingress] vs [redpanda-0,1,2]. `records/s08-part-ingress-rp.json`: started 22:39:07.142Z, applied 22:39:07.293Z, stopped 22:40:07.728Z. In-turn v2 -> v3.

**Observations.** Block rate 1.00 -> **0.74** -> 1.00. Stalls <= 2 s, no divergence/reorg. el-2: 63 seals, 31 slow, max 538 ms; 6x `Sequencer ack stall, reconnecting inflight=10..20 waited=5.0s`; 7x `backfill jumping finalized heights` covering 4447..4479; new WARN `Sequencer restoring abandoned sealed heights to the backfill from=4478 to=4479`. Ingress: periodic kgo `unable to open connection to broker` every 10 s, no self-fence.

**Result.** Same as s04 (F1/F2 signature): the ingress accepts but cannot commit, the producer waits the barrier and then skips.

### s09-part-prod-store — producers cut off from the entire store

**Fault.** kind=partition groups=[el-1,el-2,el-3] vs [ingress, envoy, gateway-0/1/2, redpanda-0/1/2, auditor]. `records/s09-part-prod-store.json`: started 22:42:31.751Z, applied 22:42:32.838Z, stopped 22:43:33.500Z. In-turn v1 throughout.

**Observations.** Block rate 1.00 -> **0.61** -> 1.00. Stalls <= 2 s on all nodes; no divergence/reorg. el-1: 128 seals, 36 slow, max 799 ms; steady cadence of **+1.61 s per block with seal elapsed ~753 ms** (barrier 500 ms + tail read); 48x `Sequencer tail read rung out of budget`; 1x `Possible producer stall: veblop fallback skipping while chain is stale currentBlock=4636 chainAgeSec=4 veblopTimeout=1s` (the backup-producer logic noticed the slow chain but correctly did not take over); 1x `backfill jumping`. el-9 after heal: `producer rebuilt in-progress block number=4671` + 2 skipped applications.

**Result.** Write and read paths both unreachable stack their penalties (F2 + F3). Still no liveness or safety failure.

### s10-kill-auditor — the auditor is off every path

**Fault.** kind=kill node=seqstore-auditor restart=true. `records/s10-kill-auditor.json`: started 22:45:12.074Z, applied 22:45:12.588Z, stopped 22:45:58.090Z. `endpoint_changes`: 2.

**Observations.** Block rate 1.00 throughout, no stalls, no barrier increments, nothing on any producer. On restart the auditor replayed the topic and logged `auditor: generation superseded block=3138 class=reorg superseded_txs=6 dropped=6` and `block=3937 class=revocation superseded_txs=9 dropped=0`: these are the s01 and s05 episodes viewed from the store (see F4).

**Result.** Hypothesis confirmed: no impact.

### s11-netem-gateway — 400 ms latency on envoy: slow reads equal dead reads

**Fault.** kind=netem-latency node=seqstore-gateway delay=400ms jitter=50ms. `records/s11-netem-gateway.json`: started 22:47:07.949Z, applied 22:47:08.032Z, stopped 22:48:38.117Z. In-turn v3.

**Observations.** Block rate 1.00 -> **0.51** -> 1.02 (45 blocks in 89 s). 2 s stalls on all nodes. el-3 `sequencer_publish_barriertimeout` 17 -> 62 (+45). No WARN on the producers except 2x `tail read rung out of budget` on el-2 (a backup). el-8: 25x `Preconf application skipped` while its stream lagged behind, 1x `Slow state commit block=4906 elapsed=102ms`.

**Result.** A gateway pool that answers slowly halves throughput exactly like a paused one: the build-start tail read is several round trips, so 400 ms one-way exhausts the 1 s budget. F3 confirmed with latency alone.

### p01-kill-inturn — killing the in-turn producer (v1)

**Hypothesis.** A backup producer takes over after the VeBlop timeout; short stall; no reorg.

**Fault.** kind=kill node=l2-el-1-bor-heimdall-v2-validator restart=true. `records/p01-kill-inturn.json`: started 22:50:41.675Z, applied 22:50:42.760Z, stopped 22:51:28.314Z. `endpoint_changes`: 12 (all el-1 ports moved).

**Observations.** oracle 22:49:11..22:52:58Z; logs `records/p01-kill-inturn-{l2-el-1,l2-el-2,l2-el-8}*.log`.

- Last el-1 seal: block 5055 at 22:50:41.340Z. First el-2 seal: block 5056 at 22:50:52.844Z. **Takeover gap 11.5 s** (10 s stall on every other node). Block rate 0.78/s over the hold, 1.00/s after. Authors during: v1 then v2.
- No divergence, no reorg on any running node. Milestone unchanged for 10 s (the stall), then normal.
- el-1 restart at 22:51:29Z: `Unclean shutdown detected`, `Head state missing, repairing number=5053`, 5x `Truncating freezer table ... items=5055 limit=5053`, `Truncated extra state histories number=2`. Its head went 5055 -> 5052 locally (path-scheme state repair after SIGKILL), then `Imported new chain segment blocks=40` and `blocks=18`; back at the tip by 22:51:56Z (~27 s after start).
- While syncing, el-1 logged **29x ERROR `error handling milestone ws event err="chain out of sync"`** (1/s, paired with INFO `Whitelisting milestone deferred`). Transient and self-healing, but at ERROR level.

**Result.** Hypothesis confirmed. Takeover ~11.5 s; no reorg; the killed node repairs its state and rejoins in under 30 s.

**Recovery.** state=completed, recovery=recovered; ports moved.

### p02-kill-2of3 — in-turn (v2) and one backup (v3) killed for 90 s

**Hypothesis.** The one remaining producer (v1, itself restarted 3 min earlier) takes over; chain survives.

**Fault.** kind=kill nodes=l2-el-2, l2-el-3 restart=true. `records/p02-kill-2of3.json`: started 22:53:53.299Z, applied 22:53:55.475Z, stopped 22:55:26.327Z. `endpoint_changes`: 24.

**Observations.** oracle 22:52:23..22:56:56Z; logs `records/p02-kill-2of3-{l2-el-1,l2-el-2,l2-cl-1}*.log`.

- **7 s stall**, then v1 sealed continuously: 157 seals in the window, max 68 ms, mean 9.8 ms. Block rate 0.90/s over the 92 s hold (the stall amortized), 1.00/s after.
- No divergence, no reorg, height never went backwards on running nodes. Milestone unchanged at most 11 s; checkpoints 126 -> 132.
- el-1 only WARN: 4x `DNS lookup of static node failed` for the two dead peers. Heimdall el-1 sibling: nothing notable.
- el-2 on restart: same pattern as p01 (`Head state missing, repairing number=5235`, one `Imported new chain segment blocks=97 elapsed=5.5s`, 34x ERROR `chain out of sync`).

**Result.** Hypothesis confirmed: the network survives 2 of 3 producers down with a single 7 s gap. Both killed nodes rejoined and all nine heads agreed 2 minutes later.

### p03-kill-3of3 — all three producers killed for 60 s

**Hypothesis.** Validators 4-7 cannot seal, so the chain halts; it resumes when the producers return; no reorg.

**Fault.** kind=kill nodes=l2-el-1,2,3 restart=true. `records/p03-kill-3of3.json`: started 22:58:38.463Z, applied 22:58:41.837Z, stopped 22:59:43.089Z. In-turn v2. `endpoint_changes`: 36.

**Observations.** oracle 22:57:08..23:01:13Z; logs `records/p03-kill-3of3-{l2-el-4,l2-el-8,l2-cl-4}*.log`.

- **0 blocks for 62 s**; total stall 95 s on every node (60 s hold + ~33 s for the restarted v2 to repair state and resume). Head frozen at 5512. Milestone unchanged 95 s; checkpoints 132 -> 136 (kept flowing for already-produced blocks).
- No divergence, no reorg, no height going backwards on the surviving nodes. All nine heads agreed at 5650 two and a half minutes later.
- el-8 (RPC) WARN 4x `Possible producer stall: veblop fallback skipping while chain is stale currentBlock=5512 chainAgeSec=7..68 veblopTimeout=1s`: the fallback logic sees the stall but the fallback candidates (the other producers) are also down.
- el-4 (witness-sync): during the halt 7x `Empty response received for witnesses requested from peer` / `deliver: Zero results received` from peers 5555/6666/7777 (the other witness nodes, which have no witnesses to give). 4x ERROR `connection lost; will attempt to reconnect on heimdall ws subscription ... i/o timeout` on el-4 and el-8 while the chain was stale.
- el-8 while catching up: 5x `Sequence stream session ended err="preconf application requires canonical re-anchor"`, 7x `Preconf seal verification deferred; retaining only an unsealed pending view number=5513..5519`, 5x `Preconf application skipped: sprint finalization requires canonical state`.
- **Follower lag after the restart.** v2 resumed sealing at 23:00:00Z (5513...). el-4, el-5 and el-8 stayed at 5512-5514 until 23:00:55Z (el-8 to 5530, el-4 to 5524), el-5 jumped to 5580 at 23:01:06Z, el-4 to 5595 at 23:01:22Z, el-8 to 5601 at 23:01:27Z. So followers imported nothing for ~55-85 s after production resumed, then caught up in one burst. All three restarted producers had logged `DNS lookup of static node failed` on their peers and vice versa; the containers came back with new IPs, so peers had to re-resolve static-node names. Kurtosis-specific to a degree (stable IPs in production), but it means RPC nodes served an 85-block-stale head for over a minute after the producers were healthy.
- Heimdall (cl-4) during the halt: 38x `Multiple non-rp vote extensions detected, there should be only one: potential malicious activity`, 13x `non-rp vote extension validation failed, accepting due to bor query error err="failed to validate checkpoint msg data"`, 139x `error while stopping connection error="already stopped"` and per-bor `Failed to read request err="websocket: close (abnormal closure)"` for every bor peer as their ws subscriptions timed out. CometBFT itself kept `Timed out ... step=RoundStepNewHeight` at ~460 ms and heights advanced; milestone propositions stopped at endBlock=5512.

**Result.** Hypothesis confirmed. This is the designed behavior of a 3-producer set: losing all producers halts the chain. Recovery was clean.

**Recovery.** state=completed, all three recovered; el-2 publisher `sequencer_publish_muted` 0 -> 1 after its restart.

### p04-pause-inturn — freezing the in-turn producer (v2)

**Hypothesis.** Same takeover as a kill, but the frozen node resumes with a stale view and may publish a stale block.

**Fault.** kind=pause node=l2-el-2-bor-heimdall-v2-validator. `records/p04-pause-inturn.json`: started 23:03:28.094Z, applied 23:03:28.140Z, stopped 23:04:28.257Z. No endpoint changes.

**Observations.** oracle 23:01:58..23:05:58Z; logs `records/p04-pause-inturn-{l2-el-2,l2-el-3,l2-el-8}*.log`.

- **7 s stall** on all other nodes (10 s on el-1, which then took over: authors during = v2 then v1). Block rate 0.82/s over the hold, 1.00 after. No divergence or reorg observed on any running node.
- el-2 on unpause: `Possible producer stall: veblop fallback skipping while chain is stale currentBlock=5721 chainAgeSec=61`; it had sealed its own 5722 (`41a46e..`) around the freeze. Then **`Chain reorg detected number=5721 hash=30d7d9.. drop=1 dropfrom=41a46e..7f2a52 add=1 addfrom=c78a9c..b269cc`**: a 1-block local reorg replacing its private 5722 with v1's canonical 5722. Immediately before that it logged `Sequencer ignoring a consensus-invalid store seal number=5722 store=c78a9c.. err="Signer 0x11111f7e..."` (it briefly judged v1's seal invalid because it still believed itself in turn), then `restoring abandoned sealed heights to the backfill from=5722 to=5722` and `backfill jumping ... floor=5795`. 2x ERROR `chain out of sync`, 1x ERROR heimdall ws `i/o timeout` (from the freeze). `Imported new chain segment blocks=45`.
- el-3: one `Chain head moved while acquiring sealing state was=5722 now=5723`. el-8: nothing.

**Result.** Hypothesis confirmed in the mild form: the only reorg is 1 block, local to the frozen producer; the network never adopted its stale block. Takeover 7 s.

**Recovery.** state=completed, recovery=recovered; all nine heads equal 2 minutes later.

### p05-part-inturn-bor — in-turn producer (v3) isolated from every other bor, heimdall left connected

**Hypothesis.** The isolated producer keeps sealing a private fork; the rest of the network falls back to another producer; the isolated node rewinds when it reconnects. Reorg expected only on the isolated node.

**Fault.** kind=partition groups=[l2-el-3] vs [el-1,2,4,5,6,7,8,9]. `records/p05-part-inturn-bor.json`: started 23:07:34.239Z, applied 23:07:34.730Z, stopped 23:09:05.397Z. `l2-cl-3` and the store were reachable from el-3 throughout.

**Observations.** oracle 23:06:04..23:10:35Z; logs `records/p05-part-inturn-bor-{l2-el-3,l2-el-1,l2-el-8,l2-cl-3}*.log`. Per-node reorg analysis (`analyze.py`, `per_node_reorgs`) = 0 for el-1,2,4-9; el-3 height went backwards 5962 -> 5952.

- **Network side.** 12 s stall at 5952, then v1 took over at 23:07:46Z (block 5953 `def3c6`). Block rate 0.73/s over the hold, 1.00 after. No divergence, no reorg on any connected node; el-8/el-9 imported only canonical blocks (their `Imported new chain segment` list is 5953 `def3c6`, 5954 `de03f7`, ... with no reorg line). *An earlier reading of the cross-node detector attributed el-3's hashes to el-8/9; the per-node check and the oracle rows disprove that.*
- **Isolated el-3.** Kept sealing 1/s: private blocks 5953 (`8c8aa2`) .. 5963 (`803a34`), 11 blocks. At 23:07:45.4Z: `Invalid header detected during background verification number=5953 err="Signer 0x33333f..."`, **`Rewinding chain due to an invalid header from=5961 to=5952 drop=9`**, `Rewinding blockchain to block target=5952`, then `Sealing state unavailable ... missing trie node` for one round, 141x ERROR `chain out of sync` while resyncing, `Imported new chain segment blocks=73` after the heal. It learned it was out of turn through its (still connected) heimdall, not through bor peers.
- **Fallback producer el-1 and the store.** el-3 kept publishing its private fork to the ingress (the store was not partitioned), so the store held v3-signed entries for 5953-5963. el-1 logged, per block, `Sequencer ignoring a consensus-invalid store seal number=5954..5963 store=<el-3 hash> err="Signer 0x33333f..."` and `Recovering a height sealed in the store but absent from the chain number=N records=R` (records=2 at 5953, i.e. it re-included the two transactions el-3 had preconfirmed), then `backfill jumping finalized heights from=5954 through=5966 floor=5967` and `withholding flush: the chain has not kept this block number=5964`. Its seals during the fallback: **5954 took 4.021 s**, then 503-543 ms each (barrier) until 5964. `sequencer_publish_barriertimeout` +2, `muted` 0 -> 1.
- **Heimdall cl-3** (proposer for the next checkpoint): machinery task retried 3x then `ERROR Failed processing task ... rpc error: code = InvalidArgument desc = Invalid parameters start: 5968 and end block: 6991` while bor-3 was still behind after its rewind; recovered on the next attempt.

**Result.** Hypothesis confirmed. No network-wide reorg; the private fork lived only on el-3 (and in the store). The store correctly did not mislead consumers, but it did slow the fallback producer (F7).

### p06-part-inturn-cl — in-turn producer's heimdall (cl-2) isolated from the other six heimdalls

**Fault.** kind=partition groups=[l2-cl-2] vs [cl-1,3,4,5,6,7,8,9]. `records/p06-part-inturn-cl.json`: started 23:12:21.390Z, applied 23:12:21.831Z, stopped 23:13:52.434Z.

**Observations.** Block rate 0.99 -> 0.99 -> 1.00; no stall during the hold; no divergence/reorg. Authors v2 then v3 at the natural span boundary (6272). Milestones (6 of 7 validators) and checkpoints (149 -> 155) unaffected. el-2 after the heal: 5x `Heimdall isn't synced, waiting for update`, a 5 s import pause at 23:14:23Z while cl-2 caught up, 3x ERROR heimdall ws `i/o timeout`, 3x ERROR `Failed to prefetch account err="fetcher is already terminated"`, 2x `Trie prefetcher failed opening ... missing trie node` (aborted work round). cl-2 itself: nothing at ERR level.

**Result.** Hypothesis confirmed: one heimdall out is invisible to the chain; bor-2 finished its span on cached span data and its sibling resynced in seconds.

### p07-netem-inturn — 800 ms (+-100 ms) latency on the in-turn producer (v1)

**Hypothesis.** Slow propagation; the fallback producer may take over and create a short fork.

**Fault.** kind=netem-latency node=l2-el-1-bor-heimdall-v2-validator delay=800ms jitter=100ms. `records/p07-netem-inturn.json`: started 23:17:06.106Z, applied 23:17:06.211Z, stopped 23:18:36.356Z.

**Observations.** oracle 23:15:36..23:20:06Z; logs `records/p07-netem-inturn-{l2-el-1,l2-el-2,l2-el-8}*.log`.

- Block rate 0.99 -> **0.47** -> 1.00. No stall > 1 s, no divergence, no reorg, no height backwards. Authors v1 then v2, but only at the natural span boundary 6528; el-8 logged one `Possible producer stall ... chainAgeSec=5` and the fallback did not fire.
- el-1: 58 seals, 28 slow, max 807 ms, mean 371 ms; 56x `Sequencer tail read rung out of budget`, 20x `could not read the store at build start` (its own store round trips now exceed the 1 s budget: F3 from the producer's side), `sequencer_publish_barriertimeout` 2 -> 29; 1x `Unable to fetch span from heimdall id=59 err="context deadline exceeded"` (heimdall calls slowed too); 1x `Slow normal import phase block=6528 total=1.293s`.
- el-2 (next producer): clean. Milestones lagged at most 4 s.

**Result.** Hypothesis half-confirmed: throughput halves for as long as the slow node is in turn, but the network never forks because the producer is slow rather than absent. The 1 s VeBlop timeout did not trigger a takeover at ~2 s block intervals.

### p08-kill-inturn-cl — in-turn producer's heimdall (cl-3) killed for 60 s

**Fault.** kind=kill node=l2-cl-3-heimdall-v2-bor-validator restart=true. `records/p08-kill-inturn-cl.json`: started 23:20:48.707Z, applied 23:20:49.859Z, stopped 23:21:50.371Z. `endpoint_changes`: 12.

**Observations.** Block rate 1.00 throughout; no stall, no divergence, no reorg; milestones lag <= 3 s; checkpoints 160 -> 165. el-3 (in-turn, 128 seals, max 86 ms): `Heimdall failover: primary failed, cascading err="Get http://l2-cl-3...:1317/bor/spans/latest: dial tcp ..."`, `Heimdall failover: switched to client index=1`, `WS URL failed, switching to healthy endpoint ... to=ws://l2-cl-1-heimdall-v2-bor-validator:26657/websocket`; 2 ERROR lines for the dead ws. cl-3 on restart: 96x `ERR Failed to read request err="websocket: close 1006"` + 96x `error while stopping connection error="already stopped"` (bor ws clients reconnecting), otherwise the same `Checkpoint not in continuity` / `invalid proposer in msg` ERR lines that the untouched cl-8 also logs (baseline noise, see below).

**Result.** Hypothesis exceeded: bor does not even rely on its cached span, it fails over to another validator's heimdall (the package configures a fallback list) and keeps producing at full rate.

### p09-kill-rabbit — in-turn producer's RabbitMQ (l2-cl-1-rabbitmq) killed for 60 s

**Fault.** kind=kill node=l2-cl-1-rabbitmq restart=true. `records/p09-kill-rabbit.json`: started 23:23:45.686Z, applied 23:23:46.252Z, stopped 23:24:46.671Z. `endpoint_changes`: 2.

**Observations.** Block rate 1.00 throughout; no stall/divergence/reorg; checkpoints 163 -> 168; el-1 clean (92 seals, max 47 ms). cl-1: 13x `ERR BorChainListener: error sending task error="Set state pending error: Dial error: dial tcp: lookup l2-cl-1-rabbitmq ... no such host"`, 2x `HeimdallListener: error sending block level task`, 1x `RootChainListener: error sending task`, machinery `Broker failed` with retry backoff 1, 2, 3, 5, 8, 13, 21, 34 s, `ERROR Failed to reopen queue: machinery_task` once; reconnected after the restart.

**Result.** Hypothesis confirmed: RabbitMQ only carries this validator's bridge tasks (checkpoint/state-sync side work). The other six validators kept checkpoints flowing. Note the backoff reached 34 s, so a rabbit blip can delay that validator's bridge tasks by up to ~1 minute after recovery.

### p10-pause-3cl — three of seven heimdall validators frozen (quorum lost)

**Hypothesis.** 4 of 7 voting power is below 2/3: CometBFT stops committing; milestones, checkpoints and new spans stop; bor keeps sealing on the already-committed span; the open question is what happens at the next span boundary.

**Fault.** kind=pause nodes=l2-cl-4,5,6. `records/p10-pause-3cl.json`: started 23:26:52.172Z, applied 23:26:52.378Z, stopped 23:28:22.692Z.

**Observations.** oracle 23:25:22..23:29:52Z; logs `records/p10-pause-3cl-{l2-cl-1,l2-el-1,l2-el-2,l2-el-4,l2-el-8}*.log`.

- **Block rate 0.99/s throughout**, no divergence, no reorg. Authors v2 -> v3 at the span boundary 7040, inside the hold: the span for 7040-7167 had already been committed before the freeze, so the boundary was crossed normally.
- **Milestone unchanged for 93 s** (soft finality frozen for the whole hold). Checkpoint count 168 -> 173 over the window but flat during the hold.
- el-4, el-5, el-6 (the bor siblings of the frozen heimdalls) stalled 29 s at the start, then continued (heimdall failover to another validator's heimdall, same as p08).
- cl-1 (running validator): CometBFT `Stopping peer for error err="pong timeout"` for the three frozen peers, `Checkpoint not in continuity` bursts, `no checkpoint in buffer, cannot process checkpoint ack`. All bor nodes: 3x ERROR heimdall ws `i/o timeout` each (their subscriptions to the frozen heimdalls).

**Result.** Hypothesis confirmed for the 90 s hold. Whether bor stops at the *second* span boundary without a committed span is tested in p13.

### p11-kill-witness4 — all four witness-sync validators' bor killed for 60 s

**Hypothesis.** Producers unaffected; witness nodes resync on restart.

**Fault.** kind=kill nodes=l2-el-4,5,6,7 restart=true. `records/p11-kill-witness4.json`: started 23:30:47.559Z, applied 23:30:51.541Z, stopped 23:31:53.117Z. `endpoint_changes`: 48.

**Observations.** oracle 23:29:17..23:33:23Z; logs `records/p11-kill-witness4-{l2-el-4,l2-el-1,l2-cl-4}*.log`.

- Producers: block rate 1.02/s during, el-1 clean apart from `DNS lookup of static node failed` for the four dead peers. No divergence/reorg among running nodes.
- **Milestone unchanged for 94 s** although all producers and all seven heimdalls were up. cl-4: 57x `ERR unable to connect to bor chain ... name resolver error: produced zero addresses`, 52x `WRN Error occurred while generating milestone proposition error="failed to get the latest header"`, 3x `ERR Error validating checkpoint error="bor block not found locally: end=7263"`, 3x `ERR rootHash is not valid endBlock=7263`, 5x `SpanProcessor: error fetching current child block`. Heimdall validators 4-7 could neither propose nor validate milestones/checkpoints without their own bor, leaving 3 of 7 voting power, below 2/3 (F9).
- Witness nodes on restart: heights went backwards (el-4 7269 -> 7262, el-5 -> 7266, el-6 -> 7265, el-7 7275 -> 7267; SIGKILL state repair), `Timeout waiting for fast forward block, using fallback localHeight=7262 threshold=64`, `Syncing, discarded propagated block` x2, `Empty response received for witnesses requested from peer` x6, and on el-4 **1x ERROR `Failed to derive block receipts fields hash=2a54f6.. number=7263 err="transaction and receipt count mismatch"`** (F8). All four were back at the tip within the 120 s post window.

**Result.** Producers confirmed unaffected; the finality-path dependency on the witness nodes' bor (F9) was not in the hypothesis.

### p12-kill-rpc9 — plain RPC node (el-9, store consumer) killed for 45 s

**Fault.** kind=kill node=l2-el-9-bor-heimdall-v2-rpc restart=true. `records/p12-kill-rpc9.json`: started 23:35:46.087Z, applied 23:35:47.190Z, stopped 23:36:32.788Z. `endpoint_changes`: 12.

**Observations.** Block rate 1.00 throughout; nothing on producers or gateways (no WARN on gateway-0/1/2). el-9 on restart: 28x ERROR `chain out of sync` (F5), `Unclean shutdown detected`, `Truncated extra state histories number=1`; store consumer re-anchoring: 8x `Sequence stream session ended err="preconf application requires canonical re-anchor"`, `Preconf seal verification deferred; retaining only an unsealed pending view` for 7443..7455 (8 rounds each), `Preconf application skipped: sprint finalization requires canonical state`, then `open overtaken by canonical import number=7589` once it caught up. Also at boot: `WARN [tx-relay] No block producer URLs provided` / `Relay service enabled but no block producer URLs provided; relay will be non-functional` (a package configuration gap: `[relay] enable-preconfs = true` is rendered without producer URLs, so the private-tx relay on RPC nodes is inert).

**Result.** Hypothesis confirmed: the consumer resumes on its own; the stream re-anchors once the node is canonical again.

### s12-pause-gw0 — one gateway (of three) frozen behind envoy

**Fault.** kind=pause node=seqstore-gateway-0. `records/s12-pause-gw0.json`: started 23:38:23.022Z, applied 23:38:23.060Z, stopped 23:39:23.136Z.

**Observations.** Block rate 1.00 -> 1.00 -> 1.02; no stall; no divergence/reorg; milestones <= 2 s. In-turn el-2 `sequencer_publish_barriertimeout` 0 -> 6 (a handful of tail reads landed on the frozen gateway before envoy's `/ready` health check ejected it), then clean. Consumers el-8/el-9: 3 `Preconf application skipped` lines each while their pinned streams moved.

**Result.** Hypothesis confirmed: the envoy front does its job for a single unhealthy gateway; this is the positive control for F3, which needs all gateways (or envoy itself) to be unreachable or slow.

### s13-netem-gw0 — one gateway (of three) slow (400 ms) behind envoy

**Fault.** kind=netem-latency node=seqstore-gateway-0 delay=400ms jitter=50ms. `records/s13-netem-gw0.json`: started 23:41:21.087Z, applied 23:41:21.133Z, stopped 23:42:51.231Z.

**Observations.** Block rate 1.01 -> 1.00 -> 1.00; no stall; no divergence/reorg. In-turn el-3 then el-1 (span boundary): `sequencer_publish_barriertimeout` el-3 1 -> 29, el-1 29 -> 90 (+61 in ~45 blocks); `Sequencer tail read rung out of budget` 28x on el-3, 62x on el-1. Seals themselves stayed fast (el-3 max 37 ms, el-1 max 399 ms once). Consumers el-8/el-9: 25 `Preconf application skipped` lines (their pinned streams on the slow gateway lagged, then reconciled).

**Result.** Envoy's `/ready` health check does not detect a slow gateway (it answers, just late), so per-stream round-robin keeps sending a third of the producer's tail-read calls to it. Unlike s11 (all reads slow) this costs no throughput, only barrier timeouts and WARN noise: the read budget is exhausted but the build proceeds with `Coverage check skipped`. Acceptable degradation; noted as the boundary of F3.

### p13-pause-3cl-long — three heimdalls frozen for 240 s (two span boundaries)

**Hypothesis.** Bor runs on the already-committed span, then halts at its end because no new span can be committed; resumes when quorum returns.

**Fault.** kind=pause nodes=l2-cl-4,5,6. `records/p13-pause-3cl-long.json`: started 23:44:57.508Z, applied 23:44:57.700Z, stopped 23:48:58.074Z. At start: head 8122, latest committed span 71 = 8192-8319 (v3).

**Observations.** oracle 23:43:27..23:50:28Z; logs `records/p13-pause-3cl-long-{l2-cl-1,l2-el-1,l2-el-2,l2-el-3}*.log`.

- Blocks 8123..8319 produced at 1/s across the 8192 boundary (v2 -> v3). **Block 8319 sealed 23:48:14Z; block 8320 sealed 23:49:15Z: a 61 s halt at the last block of span 71.** Block rate 0.81/s over the hold. No divergence/reorg.
- All producers from 23:48:14Z: `an error while trying fetching from Heimdall path=bor/spans/72 attempt=1..5 error="... response code ..."` (span 72 did not exist), `Heimdall failover: primary failed, cascading` / `switched to client index=2` (every heimdall returned the same 404), `Possible producer stall ... chainAgeSec=34`.
- Milestone unchanged 242 s (whole hold plus recovery). Checkpoints flat during the hold.
- cl-1 after unpause: CometBFT committed height 10514 at 23:48:58.3Z (0.3 s after resume), `SpanProcessor: proposing new span spanId=72 startBlock=8320 endBlock=8447` at 23:49:01Z, `Freezing new veBlop span id=72 ... selectedProducers=[valID=1]` at 23:49:11Z, bor sealed 8320 at 23:49:15Z. Then `proposing new span spanId=73` immediately and `ERR blocks not in continuity lastSpanEndBlock=8575 lastSpanId=73` / `Checkpoint number in ack is not sequential` while the backlog drained.

**Result.** Hypothesis confirmed: heimdall quorum loss is survivable only for the remaining runway of the committed span (here 197 blocks, ~3.3 min); after that the chain halts until quorum is back, then recovers in ~17 s without a reorg (F10).

### p14-part-inturn-all — in-turn producer (v2) isolated from all bor peers AND the whole store

**Hypothesis.** Same as p05 but the isolated producer cannot publish its fork; the fallback producer should not be slowed by foreign store entries (F7 control).

**Fault.** kind=partition groups=[l2-el-2] vs [el-1,3,4,5,6,7,8,9, ingress, envoy, gateway-0/1/2, redpanda-0/1/2, auditor]. `records/p14-part-inturn-all.json`: started 23:52:49.984Z, applied 23:52:50.826Z, stopped 23:54:21.680Z.

**Observations.** oracle 23:51:19..23:55:51Z; logs `records/p14-part-inturn-all-{l2-el-2,l2-el-3,l2-el-8}*.log`.

- **6 s stall** (p05: 12 s), then v1 sealed at full rate: block rate 0.92/s over the hold (p05: 0.73), `sequencer_publish_barriertimeout` on el-1 unchanged at 90 (p05: +2 plus a 4 s seal), no `consensus-invalid store seal` lines anywhere.
- el-2: private fork 8536..8539 (4 blocks; p05: 11), `Sequencer ack stall, reconnecting inflight=3`, `tail read err=... connection error`, `Invalid header detected number=8536 err="Signer 0x222227..."`, `Rewinding chain due to an invalid header from=8536 to=8535 drop=1`, 146x ERROR `chain out of sync`, `Imported new chain segment blocks=87` after the heal. Its `sequencer_publish_state` gauge went 1 -> 3 (resyncing) <-> 2 (degraded) during the fault and settled at 5 afterwards; `bor/eth/sequencer/metrics.go` defines 5 as `gaugeContending`, the normal state for a backup whose stream is not the active writer. When el-2 became in-turn again at 8960 (00:00:04Z) it went back to 1 (live) within a block, `sequencer_publish_queue` drained 10 -> 0, the ingress kept `publisher_streams=3`, and it logged `Coverage check skipped number=8960 reason="store sealed through parent, nothing owed here"` and `backfill jumping finalized heights from=8536 through=8539 floor=8958` (its private fork was never published). No stuck publisher.
- el-8: one `Possible producer stall ... chainAgeSec=4`; el-3: clean.

**Result.** Hypothesis confirmed. Cutting the isolated producer off from the store made the network's recovery twice as fast and removed the fallback producer's barrier penalty entirely.

### p15-loss-inturn — 30 % packet loss on the in-turn producer (v3)

**Fault.** kind=netem-latency node=l2-el-3-bor-heimdall-v2-validator delay=1ms loss_percent=30. `records/p15-loss-inturn.json`: started 00:02:34.857Z, applied 00:02:34.956Z, stopped 00:04:05.052Z.

**Observations.** Block rate 1.00 -> **0.78** -> 1.01; stalls <= 2 s; no divergence, no reorg, no fallback (authors v3 only during the hold). el-3: 128 seals, 32 slow, max 764 ms, mean 107 ms; 20x `Sequencer tail read rung out of budget`, 23x `could not read the store at build start`; `sequencer_publish_barriertimeout` 29 -> 55. el-1 (next): clean. el-8: 9 `Preconf application skipped` lines (`open overtaken by canonical import` for 9125, 9126, 9154, 9178; `producer rebuilt in-progress block 9181`).

**Result.** Loss behaves like latency (p07) at a milder level: gRPC retransmits push the store round trips over the read budget and the barrier, costing 22 % throughput while the lossy node is in turn; block propagation itself coped.

### p17-kill-prod-cl — heimdalls of all three producers killed for 90 s

**Hypothesis.** Producers fail over to the witness validators' heimdalls and keep sealing; with 4 of 7 heimdall voting power, milestones and checkpoints stop.

**Fault.** kind=kill nodes=l2-cl-1,2,3 restart=true. `records/p17-kill-prod-cl.json`: started 00:10:16.292Z, applied 00:10:18.893Z, stopped 00:11:49.907Z. `endpoint_changes`: 36.

**Observations.** oracle 00:08:46..00:13:19Z; logs `records/p17-kill-prod-cl-{l2-el-1,l2-el-2,l2-el-3,l2-cl-4}*.log`.

- **Block rate 1.01/s during the hold**, no stall, no divergence, no reorg. Authors v3 -> v1 at the natural boundary.
- Each producer bor: `Heimdall failover: primary failed, cascading` -> `switched to client index=1..3` (cascading past the other two dead heimdalls to a witness heimdall), `WS URL failed, switching to healthy endpoint ... to=ws://l2-cl-2...` then onward, `Health registry: proactive switch (active unhealthy, cooled target) from=1 to=3`; el-2 once `ERROR Failed to fetch milestone end block from Heimdall for header verification err="context deadline exceeded"` (a verification that had to wait for the failover). Seals fast (max 50 ms).
- **Milestone unchanged 94 s**; checkpoints flat (also affected by the L1 state after p16, below). cl-4 (running): `Stopping peer for error err=EOF` for the three dead peers; otherwise baseline noise.

**Result.** Hypothesis confirmed. Losing every producer's heimdall is a finality event, not a liveness event, thanks to bor's heimdall failover list.

### p16-kill-l1 — the single L1 execution client (geth) killed for 120 s

**Hypothesis.** Checkpoint submission stalls; L2 block production is unaffected; checkpoints resume once L1 is back.

**Fault.** kind=kill node=el-1-geth-lighthouse restart=true. `records/p16-kill-l1.json`: started 00:06:02.103Z, applied 00:06:02.984Z, stopped 00:08:03.453Z. `endpoint_changes`: 10.

**Observations.** oracle 00:04:32..00:09:33Z; logs `records/p16-kill-l1-{l2-cl-1,el-1-geth-lighthouse,cl-1-lighthouse-geth}*.log`.

- L2: block rate 1.00 throughout, no stall, no divergence/reorg, milestones normal (<= 2 s). Checkpoint count 216 -> 218 across the window, flat during the hold.
- cl-1 during the hold: 24x `ERR BaseListener: error in fetching block header while polling err="Post http://el-1-geth-lighthouse:8545: dial tcp: lookup ..."`, `CheckpointProcessor: error while fetching current header block number`, `Could not fetch current header block from rootChain contract`.
- geth on restart: `Unclean shutdown detected`, freezer truncation on every table, `Truncated extra histories typ=state number=9746`, `SetHead invalidated safe block`, then 293x `Fetching the unknown forkchoice head from network` / `Could not retrieve unknown head from peers` (single-node L1: no peers to fetch from). Lighthouse: `Skipping more than an epoch head_slot: 10357, request_slot: 10432`, `ERROR Exec engine unable to produce payload: No payload ID, the engine is likely syncing`.
- After the restart heimdall (cl-1, and cl-4 during p17) logged `ERR Could not fetch current header block from rootChain contract error="no contract code at given address"`: geth answered RPC while its state was still being rebuilt, so the RootChain proxy had no code at the queried state. L1 and checkpoint health at the end of the campaign are recorded in the closing section.

**Result.** L2 hypothesis confirmed. The single-node L1 devnet is not crash-safe in the way the L2 is: a SIGKILL costs geth its recent state and the CL/EL pair takes minutes to re-anchor, and heimdall reads a wrong (code-less) state from the recovering geth in the meantime. This is a devnet-topology observation (one L1 node, no peers), not a PoS finding.

## Findings

### F1 — Ingress unavailability adds ~500 ms to every seal and leaves permanent gaps in the store

Episode s01. While the ingress is paused, the in-turn producer waits out the 500 ms ConfirmSeal barrier on every block (seal `elapsed` 3-10 ms -> ~510 ms, `sequencer_publish_barriertimeout` +9 in 60 s), reconnects every ~5 s (`Sequencer ack stall, reconnecting`), and then *jumps* over the unpublished heights (`Sequencer backfill jumping finalized heights from=3138 through=3140 floor=3141`, repeated for 7 ranges). When the ingress returns it rejects the late entries as `stale_commitment`. Net effect: the sequence store never receives entries for most blocks sealed during the outage, so consumers (el-8/el-9 preconfs, auditor) have holes they must fill from canonical blocks. Not a liveness or safety issue for the chain; a data-completeness and latency issue for the store. Worth confirming whether "jump" is the intended catch-up policy (metric `sequencer_publish_catchupskip`). Reproduced in s02 (one 43-block hole), s04 (3723-3774) and s08 (4447-4479).

### F2 — Ingress unavailability *or* latency reduces block throughput by 25-33 %

Episodes s01, s02, s04, s07, s08. Baseline is 1.00 block/s. With the ingress paused, killed, partitioned from its brokers, or below min.insync the in-turn producer waits the 500 ms ConfirmSeal barrier on every block and the chain runs at 0.74-0.78 block/s. With the ingress up but 400 ms away (s07) it runs at 0.67 block/s and `sequencer_publish_barriertimeout` increments on nearly every block, with no WARN anywhere. The design brief (`sequence-store-devops-implementation-brief.txt` line 92) states "Nothing in this service can affect block production"; `low-latency-transaction-sequencing-v5.txt` line 112 promises "The BP keeps mining (invariant holds)". Mining does continue, but cadence is measurably coupled to the store. Whether a 25-33 % throughput loss under store degradation is acceptable is a product decision; today it is not documented, not alarmed, and the RTT threshold (~500 ms round trip) is lower than the netem value a real WAN hop plus a slow broker can produce.

### F4 — Auditor reports "reorg, all txs dropped" for blocks that were sealed on-chain with every tx included

Episodes s01, s09 (evidence surfaced by s10). `records/auditor-supersessions.jsonl` (copied from the auditor's `/tmp/supersessions.jsonl`) contains `{"block":3138,"class":"reorg","superseded_txs":6,"dropped":[6 hashes],"replacement_sealed":false}` and `{"block":4636,"class":"reorg","superseded_txs":1,"dropped":[1 hash]}`. Both blocks are canonical on el-8 (archive): block 3138 has exactly those 6 transactions, block 4636 contains the 1, and every `cast receipt` shows `status=0x1` in that block. Nothing was dropped; the seal entries for those blocks never reached the store because the producer skipped the range while the ingress was paused (s01) or partitioned (s09) (F1). The auditor code path (`internal/auditor/auditor.go:277`, "exported as fully-dropped evidence rather than silently") then classifies the unsealed generation as a reorg with all txs dropped, and `seqstore_auditor_dropped_txs_total` (now 6) and `supersessions_total{class="reorg"}` (2) count it. If this evidence is meant to feed accountability or alerting, it produces false positives on every store outage. The same episode also produced one legitimate `class=revocation` for block 3937 (s05: producer rebuilt the in-progress block; `dropped=null`, `replacement_sealed=true`, canonical block has 20 txs).

### F6 — Heimdall-v2 emits ~55 ERR lines per minute on a healthy node, including "potential malicious activity"

Measured on the untouched `l2-cl-8-heimdall-v2-bor-rpc-archive` over its full 2 h 10 min log (21:15Z..23:26Z, before and between faults): 7005x `ERR Failed to read request err="websocket: close 1006 (abnormal closure)"` paired with 7005x `ERR error while stopping connection error="already stopped"` (a bor ws client reconnecting roughly every second), 827x `ERR Checkpoint not in continuity currentTip=N startBlock=N`, 59x `ERR invalid proposer in msg`, 56x `ERR Multiple non-rp vote extensions detected, there should be only one: potential malicious activity`, 14x `ERR Checkpoint already exits in buffer`. None of these correlate with a fault; they are steady-state. During the p03 bor halt the "potential malicious activity" line burst to 38 in 4 minutes on cl-4, and `non-rp vote extension validation failed, accepting due to bor query error` appeared. Consequences: (1) an "any ERROR" alert on heimdall-v2 is unusable; (2) the phrase "potential malicious activity" for what is a routine or bor-unavailable condition will send operators chasing slashing events. Log hygiene, low severity, high operational cost.

### F8 — Stateless (witness-sync) bor nodes store no receipts; the RPC reports it as an internal mismatch and one import path logs it at ERROR

Surfaced by p11, then checked across nodes and heights. On el-4/5/6/7 (syncmode stateless) `eth_getBlockReceipts` returns `receipts length mismatch: N vs 0` and `eth_getTransactionReceipt` returns `receipt not found` for **every** block that has transactions, including blocks imported long before any fault (5512-5514 at 23:00Z, 7255-7285, and a fresh block 8109); el-1/8/9 return the receipts. Cause in bor: `core/blockchain.go` `insertChainStatelessParallel` calls `writeBlockAndSetHead(block, nil, nil, ...)` (receipts and logs nil) and `core/block_validator.go:188` skips receipt validation in stateless mode, so receipts are never persisted; this is by design of stateless sync. Two rough edges: (1) `internal/ethapi/bor_api.go:292` surfaces the design choice as `receipts length mismatch`, which reads like corruption; an explicit "receipts not available on stateless nodes" would save an investigation; (2) after el-4's crash-restart its fast-forward fallback path (`Extend chain add=2` at 7264) logged `ERROR Failed to derive block receipts fields ... transaction and receipt count mismatch` (`core/types/receipt.go:414`) for 7263, i.e. that path expects receipts the node never stores. The package already keeps stateless nodes out of the nginx/erpc upstream pools, which hides this from users; it should be documented for operators who point tooling (or heimdall) at a witness node.

### F9 — Soft finality depends on the witness-sync validators' bor nodes, which never seal

Episode p11 (and p10 for comparison). Killing only the four stateless witness-sync bor nodes, with all producers and all seven heimdalls healthy, froze milestones for 94 s: heimdall validators 4-7 could not fetch headers from their own bor (`unable to connect to bor chain`, `Error occurred while generating milestone proposition`, `Error validating checkpoint ... bor block not found locally`) and so could neither propose nor vote, leaving 3 of 7 voting power. The threshold from the investigation playbook is 90 s. So the four nodes that are excluded from `producer_votes` and can never seal a block are nevertheless on the milestone/checkpoint critical path, and they are the nodes with the least state (stateless sync, no txpool). The effect is the same as p10 (3 heimdalls frozen). Operationally: witness-node bor availability must be treated like validator availability for finality SLOs, and a heimdall whose bor is down should probably fall back to another bor RPC for header validation the way bor falls back between heimdalls (p08).

### F7 — An isolated in-turn producer keeps feeding the store, and the fallback producer pays for it

Episode p05. Because the isolated producer could still reach the ingress, the store accepted 11 blocks of a fork that never became canonical (v3-signed 5953-5963). The fallback producer then had to reject one `consensus-invalid store seal` per block, wait the barrier on every block (503-543 ms) and once spent 4.0 s sealing 5954, running the chain at 0.73 block/s for the rest of the hold. Consumers were not misled (el-8/9 never imported the fork), and the two preconfirmed transactions were recovered into canonical 5953. Two follow-ups: (1) the ingress accepts entries from a producer that is no longer in turn as long as its signature is valid for the span, so the store can carry a fork for as long as the partition lasts; (2) the fallback path is serialized behind the same 500 ms barrier as normal operation, so recovery from a producer partition is slower than recovery from a producer kill (p01: 1.00 block/s immediately after takeover). **Control (p14):** the same partition with the store also unreachable from the isolated producer gave a 6 s stall (vs 12 s), 0.92 block/s during the hold (vs 0.73), a 4-block private fork (vs 11) and no barrier penalty on the fallback producer. The store's acceptance of the stale producer's entries is the entire difference.

### F10 — Heimdall quorum loss halts the chain at the end of the committed span

Episode p13 (p10 as the short control). With 3 of 7 heimdall validators frozen, bor kept producing through the span that was already committed (197 blocks of runway from the start of the fault), then stopped at block 8319, the last block of span 71, for 61 s because `bor/spans/72` did not exist on any heimdall. Milestones were frozen 242 s. When quorum returned, CometBFT committed within 0.3 s, span 72 was proposed 3 s later and frozen 10 s after that, and bor resumed 17 s after the heimdalls came back. No reorg, no divergence. This is the protocol's designed dependency, but it fixes the operational budget: a heimdall consensus outage is invisible to users for at most one span (128 blocks here) and then becomes a full halt. Spans are proposed only about one span ahead, so there is no way to buy more runway without changing that.

### F11 — SIGKILL of the enclave's single L1 geth resets it and permanently stops checkpoints (devnet hazard)

Episode p16. After `el-1-geth-lighthouse` was killed and restarted, geth logged `Loaded most recent local block number=10357` but truncated every state-history freezer table (`Truncating from head type=state ohead=9747 tail=0 nhead=1`, `Truncated extra histories typ=state number=9746`) and its RPC now answers `eth_blockNumber = 7`. Lighthouse reports `head_slot 10357, sync_distance 530+` and `Exec engine unable to produce payload: No payload ID, the engine is likely syncing` on every slot; with no L1 peers there is nothing to fetch the missing head from, so the pair never re-anchors. Heimdall validators read the RootChain proxy at a state where it has no code (`Could not fetch current header block from rootChain contract error="no contract code at given address"`), and the checkpoint count froze at 218 (last checkpoint 00:05:53Z, blocks 9208-9247). L2 block production and milestones are unaffected. Impact for this campaign: hard finality is off from p16 onwards, and any further L1-dependent test needs a redeploy. Impact for the package: killing (not stopping) the L1 execution client in a long-lived enclave is destructive; a `kurtosis service stop` (SIGTERM) or a second L1 node would avoid it. Not a PoS protocol finding.

### F12 — nginx returns 504 to clients while a killed upstream is still in its pool

`probes/loadtest.log`: 21x `504 Gateway Time-out` (12 on `eth_sendRawTransaction`, 6 on `eth_estimateGas`, 3 on `eth_blockNumber`) and 2x `Unable to estimate gas ... historical state <root>` from the background polycli loadtest through `nginx`, all within the minute after a bor upstream was SIGKILLed (22:50Z p01, 22:54Z p02, 22:58-59Z p03, 23:07Z p05, 23:36Z p12) and none at any other time. nginx has no active health check on the upstreams, so least-connections keeps handing a share of requests to the dead node until passive failure detection kicks in, and a node that has just rejoined but is still syncing answers `eth_estimateGas` with a missing-historical-state error. A user-facing blip of a few seconds per producer failure; `max_fails`/`fail_timeout` tuning or an active probe on `eth_blockNumber` would remove it. (erpc, the alternative front, was not deployed in this config.)

### F5 — Rejoining bor logs `chain out of sync` at ERROR level once per second while catching up

Episodes p01, p02. A producer restarted after SIGKILL logs `ERROR error handling milestone ws event err="chain out of sync"` every second (29x and 34x) until it reaches the tip, each paired with `INFO Whitelisting milestone deferred`. The condition is expected during resync and resolves itself; logging it at ERROR makes every restart look like an incident and will trip any "any ERROR" alert. Suggest WARN or a single summarized line.

### F3 — Gateway (read path) unavailability halves block throughput

Episodes s05, s06. Pausing the three gateways, whose only documented role is serving consumers, dropped the chain to 0.47 block/s for the whole hold; killing envoy gave 0.71 block/s. Cause: at every block build the producer reads the store tail through `consumer-endpoint` (the envoy LB) with `tailReadTimeout = time.Second` (`bor/eth/sequencer/reader.go:28`), logging `Sequencer could not read the store at build start` and `Coverage check skipped reason="tail unreadable"`. A frozen gateway (accepting TCP, never answering) burns the full second; a dead envoy fails fast. Stalls of 3-4 s were visible on every node. This makes the gateway pool and envoy production-critical components. Options: make the build-start read asynchronous or bounded to well under the block period, or read from a local cache / the ingress instead of the LB.

## Close-out

- `tartarus fault list` -> `[]` (nothing held). `tartarus fault list --done` -> 30 records, all `completed`. `tartarus cleanup --all` -> `{"ok":true,"records":0,"orphan_chains_removed":[]}`. No `tartarus` iptables chains and no netem qdiscs left on the host.
- Probes stopped at the end of the campaign; `probes/oracle.log` holds the full 1 Hz history (~2 h), `probes/loadtest.log` the polycli run: 31 error lines over the whole campaign, all clustered in the minutes when a bor node behind nginx was killed (p01, p02, p03, p05, p12), see F12.
- **State of the enclave at close:** all nine bor heads equal and advancing at 1 block/s, milestones advancing, `pos` enclave otherwise healthy. **Checkpoints frozen at 218 and the L1 (`el-1-geth-lighthouse`) stuck at block 7 since p16 (F11): redeploy before any test that needs L1 or checkpoints.** Producers el-1/2/3, witness nodes el-4..7, el-9, cl-1/2/3, cl-4..6 (paused), rabbitmq-1, ingress, envoy, redpanda-0/1 and the auditor were all killed or paused at least once and came back; their Kurtosis host ports changed (`endpoint_changes` in each record), so re-read ports with `kurtosis port print` / `tartarus cluster nodes`.

## Evidence layout

- `CAMPAIGN.md` (this file): plan, per-episode reports, findings.
- `records/<id>.json`: the tartarus record for each fault (params, timestamps, `targets_before/after`, `endpoint_changes`). `records/<id>-<service>.log`: docker logs of the named service from 30 s before the fault to 75 s after (gitignored, bulky). `records/auditor-supersessions.jsonl`: the auditor's evidence file (F4).
- `probes/oracle.log`: 1 Hz oracle. `campaign/analyze.py <id>` re-derives every number quoted above; `campaign/summary.py` regenerates the cross-episode table.
- `lib.sh` (helpers + `episode` wrapper), `probe.sh`, `loadtest.sh`: re-runnable harness. Typical use: `source campaign/lib.sh; nohup campaign/probe.sh & ; episode <id> --logs "<svc> ..." -- --kind <kind> --node <svc> --for 60s`.

## Not tested / ideas for a second pass

- Redpanda disk pressure or slow disk (only kill/partition/latency on brokers was tried).
- Long ingress outage (> 5 min) to see whether consumers' preconf views degrade further than the F1 holes.
- Two isolated producers at once (p05 with two nodes) and a partition that splits the witness set from the producers.
- CPU/memory throttling (`docker update`) on producers and gateways; tartarus has no primitive for it.
- Tx-level preconf accounting under faults: whether every preconfirmed tx during F1/F7 windows landed on chain (the auditor's "dropped" list was checked for two blocks only).
- Repeating p11/p13 after fixing F9/F10 expectations to measure recovery times with the L1 healthy.
