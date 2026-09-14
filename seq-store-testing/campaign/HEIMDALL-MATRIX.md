# Bor <-> Heimdall connectivity matrix

Question (from the Slack thread with Jerry Chen, 2026-09-14): heimdall is
supposed to be a hard dependency for bor ("if heimdall disconnects bor will
stop syncing", "if all heimdall nodes failed, bor shouldn't be able to
seal"). In the 2026-09-10 campaign the in-turn producer kept sealing at
1.00 block/s through the kill of its own heimdall (p08) and of all three
producer heimdalls (p17). Jerry's explanation: the package configures every
bor with all nine heimdall URLs (validators 1-7 and RPC heimdalls 8-9), so
bor failed over to a non-producer heimdall. Verified in
`/etc/bor/config.toml` on el-1: `[heimdall] url = "http://l2-cl-1...:1317,...,http://l2-cl-9-heimdall-v2-bor-rpc:1317"`,
same for `ws-address`.

This matrix isolates the failure mode (dead vs frozen vs unreachable vs
slow) and the failover target (own heimdall only vs every heimdall) for the
**in-turn producer**, and asks three things per cell: does the chain
continue uninterrupted, does it halt (and for how long / until what), does
anyone fork.

Outcome legend: **C** continued (rate >= 0.95, stall <= 3 s), **D** degraded
(stall or rate loss but no halt), **H** halted (no blocks for >= 15 s or
until an external event), **F** fork (per-node reorg on a connected node,
or a private chain on the producer that had to be rewound).

Environment: enclave `pos` (same as the campaign, now 4 days old, L1 dead
since p16 so checkpoints are frozen at 218 and are not an oracle here),
bor `b56ff74a4`, heimdall-v2 `0.11.0`, block time 1 s, span 128 blocks,
VeBlop single producer. Tartarus after the feedback round: kinds `kill`,
`stop`, `pause`, `partition` (glob groups), `netem`, `throttle`; `--note`,
`--verify-every`, ids up to 64 chars.

## Matrix

| id                          | failure mode                                | scope                                                                           | hold                            | expected                                                                                                                                                 | result                                                                                                           |
| --------------------------- | ------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| h01-part-own-cl             | partition (unreachable, TCP hangs/timeouts) | in-turn bor vs its own heimdall only                                            | 90 s                            | failover after timeouts; short gap; C or D                                                                                                               | **D** network (14 s stall, producer rotated); **H** on the producer for the whole hold                           |
| h02-pause-own-cl            | pause (frozen, timeouts)                    | in-turn producer's heimdall                                                     | 90 s                            | like h01 but heimdall's CometBFT peer also frozen (6/7 quorum ok); D                                                                                     | **C** 1.00 blocks/s, 0 stall                                                                                     |
| h03-stop-own-cl             | stop (SIGTERM, graceful)                    | in-turn producer's heimdall                                                     | 60 s                            | like p08 kill: instant failover; C                                                                                                                       | **C** 1.02 blocks/s, 0 stall                                                                                     |
| h04-part-all-cl-short       | partition                                   | in-turn bor vs all 9 heimdalls                                                  | 60 s, inside a span             | bor has no heimdall at all; Jerry expects halt; span is cached so maybe C until span end                                                                 | **D** network (14 s stall, rotation); **H** producer, **wedged after heal** (see episode)                        |
| h05-part-all-cl-span        | partition                                   | in-turn bor vs all 9 heimdalls                                                  | 150 s, crossing a span boundary | at the boundary the isolated bor cannot fetch the next span: does it stop (H on that node, fallback takes over) or keep sealing with the stale span (F)? | **D** network (17 s stall, rotation); **H** producer + wedge; **F** 1 private block on the isolated node only    |
| h06-pause-all-cl            | pause                                       | all 9 heimdalls                                                                 | 60 s                            | every bor loses heimdall (frozen); milestones stop; chain continues on cached span?                                                                      | **H** network (5 blocks in 55 s, 65 s stall); **F** 14-block reorg on the in-turn producer at recovery           |
| h07-kill-all-cl             | kill+restart                                | all 9 heimdalls                                                                 | 60 s                            | as h06 but connection refused instead of timeouts                                                                                                        | **H** network (86 s stall); **F** 16-block reorg on the in-turn producer at recovery; slow recovery (0.57/s)     |
| h08-netem-own-cl            | netem delay 2 s                             | in-turn producer's heimdall                                                     | 90 s                            | bor's heimdall calls hit context deadline; failover or slow sealing; D                                                                                   | **D** network (13 s stall, rotation); **H** producer for the hold (73 s), self-recovered after heal; no failover |
| h09-part-all-cl-nonproducer | partition                                   | a witness bor (el-4) vs the 7 validator heimdalls (cl-8/9 were down, see below) | 120 s                           | control: does a non-sealing bor stop importing without heimdall (milestone whitelist)?                                                                   | **H** for that node (111 s, self-healed after heal); **C** network                                               |
| h10-throttle-own-cl         | throttle (0.05 CPU cores)                   | in-turn producer's heimdall                                                     | 90 s                            | added: overloaded heimdall; slow answers -> like h08?                                                                                                    | **C** 1.01 blocks/s, 0 stall, no failover needed                                                                 |

Runs are sequential, one fault at a time, with the 1 Hz oracle and 5 tx/s
load running throughout. Each row gets a section below with the record id,
timestamps, author trail, and the decisive log lines.

## Episodes

### h01-part-own-cl — in-turn bor (el-2) partitioned from its own heimdall (cl-2), 90 s

Record `records/h01-part-own-cl.json`: started 22:13:08.491Z, applied 22:13:08.544Z, stopped 22:14:38.797Z; 5 mid-hold `observations[]` (iptables chain present). Span 2728 (348160-348287) was the next registered span; the fault started at head 348126 with v2 in turn.

**Network.** 14 s with no block (348127 sealed 22:13:08.85Z, 348128 by v1 at ~22:13:22Z). Block rate 0.86/s over the hold, 1.01 after. No divergence, no per-node reorg, no height backwards. Milestone frozen 15 s.

**Heimdall (cl-1).** `Block finalization time is greater than the change producer threshold, creating a new veblop span`, `Freezing new veBlop span id=2729 startBlock=348128 endBlock=348287 selectedProducers=[valID=1]`, `Span rotated due to the current producer's ineffectiveness currentProducerID=2` at 22:13:22.23Z. This is the VeBlop producer rotation: the network moved on without el-2.

**Isolated producer (el-2).** Sealed 348127 at 22:13:08.85Z, then nothing. The build for 348128 (a sprint start, which needs `clerk/time` state-sync data) blocked inside the heimdall call: `StateSyncData number=348,128 "fetch time"=30002`, `Commit new sealing work number=348,128 elapsed=30.850s` at 22:13:39.85Z. `Health registry: proactive switch from=0 to=1` at +9.7 s did not help the in-flight call; `Heimdall failover: primary failed, cascading ... context deadline exceeded` / `switched to client index=1` only at +30 s (`bor/consensus/bor/heimdall/failover_client.go: defaultAttemptTimeout = 30 * time.Second`). By then v1 owned 348128. el-2 then rejected the fallback chain: `Synchronisation failed, dropping peer reason=invalid-chain err="retrieved hash chain is invalid: Signer 0x11111f7e..."` (it never learned about span 2729), `Synchronisation stalled ... reason=whitelist-no-remote` every 10 s, `Whitelisting milestone deferred err="chain out of sync"`, and rebuilt its own 348128 every 10 s without sealing it. It stayed at 348127 until the partition healed and then imported 89 blocks at 22:14:57Z. **Even after failover to another heimdall (22:13:38Z) it did not recover for the remaining 60 s of the partition.** 130x ERROR `chain out of sync`.

**Heimdall side (cl-2).** 53x `unable to connect to bor chain ... DeadlineExceeded` and `Error occurred while generating milestone proposition` (the partition is symmetric); 6 of 7 kept milestones going.

**Result.** D for the network (one 14 s gap, then a producer rotation), H for the isolated producer for the whole hold plus ~15 s. No fork.

### h02-pause-own-cl — in-turn producer's heimdall (cl-3) frozen, 90 s

Record `records/h02-pause-own-cl.json`: 22:17:07.554Z .. 22:18:37.682Z. Block rate 1.01 -> **1.00** -> 0.99, 0 s stall everywhere, no divergence/reorg, milestone lag <= 4 s. el-3 sealed 94 blocks, max 53 ms, straight through sprint starts 348368/348384/348400.

Why it differs from h01: `Health registry: proactive switch from=0 to=1` at 22:17:17.9Z (+10 s) landed **before** the next sprint-start state-sync fetch at 22:17:23.1Z, which therefore went to a healthy heimdall (`"fetch time"=1`). The blocking `bor/spans/latest` attempt against the frozen primary timed out at +30 s (`Heimdall failover: primary failed, cascading` 22:17:37.7Z) without holding up a build. 5x ERROR `Failed to fetch milestone end block from Heimdall for header verification err="context deadline exceeded"` were harmless here because el-3 was importing nothing (it was the sealer).

**Result.** C. The same 30 s attempt timeout existed; it simply never coincided with a mandatory call.

### h03-stop-own-cl — in-turn producer's heimdall (cl-2) stopped with SIGTERM, 60 s

Record `records/h03-stop-own-cl.json`: 22:21:05.451Z .. 22:22:06.738Z, `endpoint_changes` 12. Block rate 1.00 -> **1.02** -> 1.00, 0 s stall, no divergence/reorg. el-2: `Heimdall failover: primary failed, cascading err="... dial tcp ..."` -> `switched to client index=1` within a second (connection refused fails fast), 111 seals, one 303 ms seal. cl-2 shut down cleanly (`Signal received: terminated`, `Waiting for running tasks to finish`).

**Result.** C, identical to p08 (SIGKILL). Dead heimdall = instant failover; the failure mode that hurts is the one that times out.

### h04-part-all-cl-short — in-turn bor (el-1) partitioned from all nine heimdalls, 60 s inside span 2725

Record `records/h04-part-all-cl-short.json`: started 22:24:45.585Z (head 348810, span 348800-348927, v1 in turn), applied 22:24:45.848Z, stopped 22:25:46.223Z. Group 2 was the glob `l2-cl-*-heimdall-v2-*` = all 9 heimdalls.

**Network.** el-1 sealed 348811..348815 after the cut (its cached span was valid and no mandatory heimdall call was due), then stopped. 14 s gap, then heimdall rotated the span to v2 (author trail v1@348811 -> v2@348818). Block rate 0.80/s over the hold, 1.00 after. No divergence, no per-node reorg, no height backwards. Milestone frozen 14 s.

**Isolated producer.** `Heimdall failover: primary failed, cascading` -> `switched to client index=2` -> `index=1` (every target is behind the same partition, so cascading is futile), 27x ERROR `Failed to fetch milestone end block from Heimdall for header verification err="context deadline exceeded"`, `Discarding sealed block: another producer's block owns this height number=348,816` (**correct: no fork**), then `Synchronisation failed, dropping peer reason=invalid-chain err="... Signer 0x22222743..."` for el-2, el-3 and the two RPC peers, and `Synchronisation stalled ... whitelist-no-remote` against the four witness peers.

**After the heal (22:25:46Z).** Heimdall reachable again (`Health registry: promoted to higher-priority endpoint index=0` at 22:27:13Z, milestone fetch errors stopped at 22:25:46Z), 8 peers connected, `eth_syncing` reports `currentBlock 348815, highestBlock 348837`, yet the head stayed at **348815 for the whole 90 s post window and beyond** (still 348815 at 22:27:51Z, 2 min after the heal, while the network was at 348983). Every 10 s: `Remote peer didn't respond ... err="remote peer doesn't have a target block number"` / `Synchronisation stalled, no peer action taken peer=<witness> reason=whitelist-no-remote`. The producer peers it needs were dropped as invalid-chain during the partition. Follow-up observation below.

**Result.** D for the network, H for the producer, and the producer did not self-heal when connectivity returned.

**Follow-up (22:27-22:34Z).** el-1 stayed at 348815 for 8 minutes after the heal. Mechanics from `records/h04-el-1-wedged.log`, `admin_peers` and the bor source:

- The full stall line: `Synchronisation stalled, no peer action taken peer=8c287aab reason=whitelist-no-remote err="remote peer doesn't have a target block number: last whitlisted block number 9247"` (sic, bor's spelling). 9247 is the end block of the last L1 checkpoint (frozen at 218 since the L1 died in the previous campaign, F11). The whitelist check asks the sync peer for that header (`eth/downloader/whitelist/service.go:426-432`).
- The witness-sync nodes cannot serve it: `eth_getBlockByNumber(9247)` returns null on el-5 and el-7 and the header on el-1/el-2/el-8. (Retention probe below.) The downloader keeps selecting a witness peer (they report the highest head) and, because `whitelist.ErrNoRemote` maps to "no peer action" (`eth/downloader/peer_response.go:117`), it never rotates to el-2/el-3/el-8/el-9, which have the block. `eth_syncing` showed `currentBlock 348815 highestBlock 348837` throughout; 8 peers connected including el-2 and el-3.
- Heimdall did not pick v1 for the next two spans (`Freezing new veBlop span id=2738 ... selectedProducers=[valID=2]`, `id=2739 ... [valID=3]`; the campaign-long pattern had been 1,2,3,1,2,3). The network therefore never waited on the wedged producer: max gap 3 s between 22:28 and 22:33. Whether this is an explicit "ineffective producer" penalty or the selection seed is not verified.
- **Restart (h04r, `records/h04r-restart-el1.json`, `stop --for 5s`):** el-1 back up 22:34:04Z, imported 87+176+121+178 blocks in four segments and reached the tip at 22:34:33Z (~30 s), sealing metrics reset. It logged the same `whitelist-no-remote` against the three witness peers once each during initial sync and then proceeded, so the wedge is a state of the running downloader, not of the database.

### h05-part-all-cl-span — in-turn bor (el-3) partitioned from all nine heimdalls across the 349695/349696 span boundary, 150 s

Record `records/h05-part-all-cl-span.json`: started 22:39:01.215Z (head 349654, span 2741 = 349568-349695 with v3 in turn, span 2742 = 349696-349823 for v1 already registered), applied 22:39:01.455Z, stopped 22:41:31.879Z; 4 mid-hold observations.

**Network.** el-3 sealed 349655..349664 after the cut (10 blocks). 17 s gap, then heimdall rotated the span and v1 sealed from 349665 (author trail v3@349655 -> v1@349665 -> v2@349824 at the natural boundary). Block rate 0.89/s over the hold, 1.00 after. No divergence, no per-node reorg on any connected node, no height backwards.

**Isolated producer.** Its last sealed block, 349664 (`a64b05..`), lost to v1's 349664 (`405be9..`): the analyzer's one cross-node hash change is el-3 still reporting its own 349664 after the heal, i.e. **a one-block private fork that only el-3 holds** (`bor_getAuthor(349664)` = v3 on el-3, v1 on el-8). It did **not** seal into span 2742 with its stale span: after the rotation its build loop logged `Possible producer stall: veblop fallback skipping while chain is stale currentBlock=349,663 chainAgeSec=4..124` every 30 s and produced nothing. It rejected the fallback chain (`Synchronisation failed, dropping peer ... Signer 0x11111f7e...` for el-1, el-2, el-9; `Sequencer ignoring a consensus-invalid store seal number=349,664 store=405be9..`), then livelocked on `whitelist-no-remote` against the witness peers (22 lines), the same wedge as h04. `Heimdall failover: switched to client index=4`, `index=5` (cascading through unreachable targets), 69x ERROR `Failed to fetch milestone end block ... context deadline exceeded`, 94x ERROR `chain out of sync`. Still at 349664 two minutes after the heal (network at 349909).

**Result.** D for the network, H for the producer, F limited to one private block on the isolated node. The span boundary itself changed nothing: the isolated node stopped sealing at the rotation, not at the boundary. Restarted in h05r.

### h06-pause-all-cl — all nine heimdalls frozen for 60 s

Record `records/h06-pause-all-cl.json`: started 22:45:55.672Z (head 350052, v1 in turn, span 350080-350207 registered for v2), applied 22:45:56.116Z, stopped 22:46:56.734Z; 9 instances, all recovered.

**Timeline (el-1 = in-turn producer, `records/h06-pause-all-cl-l2-el-1-*.log`; heimdall from `...-l2-cl-1-*.log`; el-2 from a docker-logs window).**

- 22:45:56-22:46:05Z: el-1 seals 350056..350063 normally (cached span; no mandatory heimdall call).
- 22:46:05.97Z: 350063 sealed; the build of 350064 (a sprint start, needs `clerk/time`) blocks. `Heimdall failover: primary failed, cascading ... bor/spans/latest context deadline exceeded` at +30 s, `... clerk/time ...` at +40 s; every other target is frozen too. **Followers are blocked as well:** el-2 and el-8 log `Failed to fetch milestone end block from Heimdall for header verification err="context deadline exceeded"` (29-30x) and stay at 350063; el-2's own sealing work for 350064 also shows `elapsed=50.260s`. Block rate during the hold: **5 blocks in 55 s**, stall 49-65 s on every node.
- 22:46:56.3Z (unpause): el-1's blocked call returns, it seals 350064 (`564e24`, `Commit new sealing work elapsed=50.245s`) and then 350065..350077 at 1/s (14 blocks). No follower imports them: el-2 stays at 350063 until 22:47:10Z (oracle), el-8 too.
- 22:46:58-22:47:00Z: heimdall (cl-1) commits the milestones it had missed, up to `endBlock=350063` (v1's blocks).
- 22:47:09.59Z: `Block finalization time is greater than the change producer threshold, creating a new veblop span ... lastMilestoneEndBlock=350063`, `Freezing new veBlop span id=2747 startBlock=350064 endBlock=350207 selectedProducers=[valID=2]`, `Span rotated due to the current producer's ineffectiveness currentProducerID=1`. Heimdall measured v1's "ineffectiveness" across its own frozen minute and rotated the producer **retroactively from 350064**, a height v1 had already sealed and propagated.
- 22:47:09.9Z: el-2 drops el-1 as `invalid-chain ... Signer 0x11111f7e... is not a part of ...`; 22:47:10.5Z el-2 seals its own 350064 (`f192fe`); 22:47:12.05Z milestone `endBlock=350064` by v2.
- 22:47:12.07Z el-1: `End block hash mismatch while whitelisting milestone expected=564e24... got=f192fe...`, `Rewinding chain due to milestone endblock hash mismatch number=350,063`, `Milestone mismatch: rewinding to attested canonical ancestor without local sidechain; canonical chain will resync from peers head=350,077 rewindTo=350,063`, `Invalid header detected ... number=350,065 ... Signer 0x11111f7e... is not a part o[f the producer set]`, `Rewinding chain due to an invalid header from=350,073 to=350,064 drop=9`, 6+ `Demoting invalidated transaction`. Oracle: el-1 350077 -> 350067 -> 350063, then back on the canonical chain at 350065 by 22:47:17Z. `analyze.py`: 11 per-node reorgs, all on el-1; none on any other node.
- Store side: el-1 had published 350064..350077; el-8 logged 16x `Preconf application skipped: open parent neither canonical nor speculative tip parent=<el-1 hashes>` and el-2 `Sequencer ignoring a consensus-invalid store seal number=350,065 store=e2be61..`. Consumers were not misled.
- Post-hold block rate 0.64/s over 90 s (rotation + rewind + el-1 resync).

**Result.** H for the network (effectively halted: the in-turn producer blocks on the first mandatory heimdall call, and every follower blocks on milestone-based header verification). F: a 14-block reorg confined to the in-turn producer, created by heimdall rotating the producer retroactively at recovery. Any client reading el-1 (an nginx upstream) saw 14 blocks appear and vanish; transactions were re-included by v2.

### h07-kill-all-cl — all nine heimdalls killed (connection refused) for 60 s

Record `records/h07-kill-all-cl.json`: started 22:50:25.828Z (head 350240, v2 in turn), applied 22:50:33.632Z (8 s to kill nine containers), stopped 22:51:38.171Z; `endpoint_changes` 110 (every heimdall port moved).

**Observations.** Block rate **0.14/s during** (10 blocks in 72 s), 86 s stall on every follower, 0.57/s over the 90 s after. el-2 (in-turn) sealed 350241..350264 (24 blocks) while followers stayed at 350240-350248; el-2 and el-8 cascaded through all nine `WS URL failed, switching to next endpoint` and `Failed to update latest span ... dial tcp: lookup l2-cl-9...` (connection refused / no DNS fails fast, but there is no healthy target). On recovery heimdall rotated to v1 from 350249 (author trail v2@350240 -> v1@350249); el-2: `Invalid header detected ... number=350,249 hash=43e2ce.. Signer 0x22222743... is not a part of`, `Rewinding chain due to an invalid header from=350,250 to=350,248`, oracle 350264 -> 350261 -> 350248 (**16-block producer-local reorg**), then 13x `Heimdall isn't synced, waiting for update` while the restarted heimdalls caught up: el-2 stalled a further 76 s after the hold. `analyze.py`: 9 per-node reorgs, all on el-2. Store consumers: `Preconf seal verification deferred` for 350249..350255, `preconf application requires canonical re-anchor`.

**Result.** H for the network, F for the in-turn producer (16 blocks). Same shape as h06; connection-refused does not help because there is nothing to fail over to, and recovery is slower because the heimdalls themselves must restart and resync before bor accepts their answers.

### h08-netem-own-cl — 2 s (+-200 ms) one-way latency on the in-turn producer's heimdall (cl-2)

Record `records/h08-netem-own-cl.json`: started 22:55:54.822Z (head 350469, v2 in turn), applied 22:55:54.855Z, stopped 22:57:24.924Z. Note: netem on the heimdall container also slows its CometBFT traffic (6 of 7 kept quorum).

**Observations.** 13 s network stall at 22:56:18Z, then rotation to v1 (author trail v2@350469 -> v1@350492). Block rate 0.83/s over the hold, 0.99 after. No divergence, no reorg, no height backwards. el-2 (in-turn) stalled 73 s: 45x ERROR `Failed to fetch milestone end block from Heimdall for header verification err="context deadline exceeded"` and 45x `an error while trying fetching from Heimdall path=/milestones/latest` (the milestone fetch has a tighter deadline than 4 s round trip), 20x `Heimdall isn't synced, waiting for update syncInfo=...` (the slow heimdall still answered `/status`, so bor kept waiting on it), 3x `Possible producer stall ... chainAgeSec=4..64`. **No `Heimdall failover` line at all**: a slow heimdall is not "failed" to the failover client (every call eventually returns within the 30 s attempt budget), so bor never leaves it. el-2 caught up on its own once the latency was removed (heads equal by the end of the post window).

**Result.** D for the network, H for the producer for the duration of the latency. A slow heimdall is worse than a dead one for the producer that owns it, because nothing triggers failover, but it is not worse than a partition because the node self-heals when the latency goes away.

### Side effect of h07: heimdall cl-8 did not survive its restart

`l2-cl-8-heimdall-v2-bor-rpc-archive` was killed and restarted by h07 and reported `recovery: recovered`, but was found `exited` at 22:59:16Z when h09 tried to partition against it (`APPLY_FAILED ... l2-cl-8-heimdall-v2-bor-rpc-archive has no IPv4 on kt-pos (status exited)`; tartarus rolled back cleanly, nothing held). The probe's milestone and checkpoint fields (read from cl-8's REST API) are empty from h08 onward for that reason. Diagnosis and restart are in the follow-up below; h09 was rerun as `h09-part-witness-all-cl-2`.

### h09-part-witness-all-cl-3 — witness-sync bor (el-4) partitioned from all running heimdalls, 120 s (control)

Record `records/h09-part-witness-all-cl-3.json`: started 23:05:46.813Z, applied 23:05:47.005Z, stopped 23:07:47.402Z. Group 2 = `l2-cl-*-heimdall-v2-bor-validator` (the 7 validator heimdalls; the two RPC heimdalls were already down, see the h07 side effect, so el-4 had no reachable heimdall at all). Attempts 1 and 2 (`h09-part-witness-all-cl`, `-2`) were rolled back by tartarus with `APPLY_FAILED ... l2-cl-8-heimdall-v2-bor-rpc-archive has no IPv4 on kt-pos (status exited)` before anything was held.

**Observations.** Network: block rate 1.01 throughout, 0 s stall on every other node, no divergence/reorg. el-4: **stalled 111 s** (from 23:05:56Z until shortly after the heal): 60x ERROR `Failed to fetch milestone end block from Heimdall for header verification err="context deadline exceeded"`, `Heimdall failover: primary failed, cascading` -> `switched to client index=3`, `index=4` (all unreachable), `Failed to fetch latest checkpointV2`, `Failed to whitelist checkpoint err="root hash calculation failed: unknown block"` (it cannot compute the root of checkpoint 9208-9247 because it never had those blocks, see the retention note under h04). No `invalid-chain` peer drops (no producer rotation concerned it), and it resumed importing on its own once the partition was lifted: heads equal at the end of the post window. cl-4 meanwhile: 97x `unable to connect to bor chain` / `Error occurred while generating milestone proposition` (symmetric cut; 6 of 7 validators kept milestones going).

**Result.** Confirms Jerry's "bor stops syncing when heimdall disconnects" for a follower: block import is gated on a milestone fetch for header verification, so a bor with no heimdall stops at its current head. It does not wedge, because nothing rotated against it while it was blind. H for the node, C for the network.

### Side effect of h07, root cause: the RPC heimdall containers are not restart-safe

`records/h07-kill-all-cl.json` reports all nine instances `recovered`, and docker did restart them, but `l2-cl-8-heimdall-v2-bor-rpc-archive` and `l2-cl-9-heimdall-v2-bor-rpc` exited with code 1 within 0.4 s (`FinishedAt 22:51:37.06Z`). Their container command (`src/cl/heimdall_v2/launcher.star:115-130`, rendered as `sh -c "cp ... && heimdalld init <name> --home /tmp/init-data && cp /tmp/init-data/config/node_key.json ... && heimdalld start ..."`) runs `heimdalld init` on **every** start; on a restart `/tmp/init-data` already exists inside the container and init refuses: `genesis.json file already exists: /tmp/init-data/config/genesis.json`, so the `&&` chain aborts before `heimdalld start`. The validator heimdalls copy pre-generated keys instead of running init and restart fine. `kurtosis service start` cannot recreate them either (`Conflict. The container name ... is already in use`), and `docker start` reproduces the exit. Effect: after any restart (crash, host reboot, `docker restart`, tartarus `kill`/`stop`), the two RPC heimdalls stay down; bor el-8/el-9 fail over to validator heimdalls, and anything that reads cl-8/cl-9's REST (the probe's milestone/checkpoint fields, dashboards) goes blank. Both were still down at the end of this session; a redeploy fixes them. Proposed package fix in `launcher.star`: guard the init, e.g. replace the `heimdalld init ...` step with `test -f {home}/config/node_key.json || (heimdalld init {name} --home /tmp/init-data && cp /tmp/init-data/config/node_key.json /tmp/init-data/config/priv_validator_key.json {home}/config/ && cp /tmp/init-data/data/priv_validator_state.json {home}/data/)` so keys are generated once and reused (keeping the node ID stable), rather than `init --overwrite` which would rotate the node key on every restart.

### h10-throttle-own-cl — in-turn producer's heimdall (cl-2) limited to 0.05 CPU cores, 90 s

Record `records/h10-throttle-own-cl.json`: started 23:11:27.106Z (head 351387, v2 in turn), applied 23:11:27.161Z, stopped 23:12:58.180Z; tartarus `throttle` (`docker update --cpus 0.05`, restored on stop). Block rate 1.00 -> **1.01** -> 1.01, 0 s stall everywhere, no divergence/reorg, milestone lag <= 2 s. el-2 sealed 128 blocks (max 42 ms) with **no** heimdall WARN or ERROR at all; cl-2 kept answering within bor's deadlines and kept its CometBFT peer alive. **Result.** C. A CPU-starved heimdall is not a slow heimdall in the sense that hurts (h08); at this load 5 % of a core is enough to answer `clerk/time`, `bor/spans/latest` and `/milestones/latest` in time.

## Results

| id                        | fault     | targets                                                                                                                                                       | hold s | blocks/s during | network stall s | worst node stall s | per-node reorgs | height backwards | milestone frozen s |
| ------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ | --------------- | --------------- | ------------------ | --------------- | ---------------- | ------------------ |
| h01-part-own-cl           | partition | 1 vs 1 nodes                                                                                                                                                  | 90     | 0.86            | 14              | 105                | 0               | 0                | 15                 |
| h02-pause-own-cl          | pause     | l2-cl-3-validator                                                                                                                                             | 90     | 1.00            | 0               | 0                  | 0               | 0                | 4                  |
| h03-stop-own-cl           | stop      | l2-cl-2-validator                                                                                                                                             | 61     | 1.02            | 0               | 0                  | 0               | 0                | 4                  |
| h04-part-all-cl-short     | partition | 1 vs 9 nodes                                                                                                                                                  | 60     | 0.80            | 14              | 146                | 0               | 0                | 14                 |
| h04r-restart-el1          | stop      | l2-el-1-validator                                                                                                                                             | 6      | 1.00            | 0               | 89                 | 0               | 0                | 2                  |
| h05-part-all-cl-span      | partition | 1 vs 9 nodes                                                                                                                                                  | 150    | 0.89            | 17              | 141                | 0               | 0                | 15                 |
| h05r-restart-el3          | stop      | l2-el-3-validator                                                                                                                                             | 6      | 1.33            | 0               | 58                 | 0               | 0                | 4                  |
| h06-pause-all-cl          | pause     | l2-cl-9-rpc,l2-cl-8-rpc-archive,l2-cl-7-validator,l2-cl-6-validator,l2-cl-5-validator,l2-cl-4-validator,l2-cl-3-validator,l2-cl-2-validator,l2-cl-1-validator | 61     | 0.09            | 65              | 70                 | 11              | 2                | 10                 |
| h07-kill-all-cl           | kill      | l2-cl-9-rpc,l2-cl-8-rpc-archive,l2-cl-7-validator,l2-cl-6-validator,l2-cl-5-validator,l2-cl-4-validator,l2-cl-3-validator,l2-cl-2-validator,l2-cl-1-validator | 72     | 0.14            | 86              | 86                 | 9               | 2                | 2                  |
| h08-netem-own-cl          | netem     | l2-cl-2-validator                                                                                                                                             | 90     | 0.83            | 13              | 73                 | 0               | 0                | 0                  |
| h09-part-witness-all-cl-2 | partition | 1 vs 9 nodes                                                                                                                                                  | 0      | -               | 0               | 0                  | 0               | 0                | 0                  |
| h09-part-witness-all-cl-3 | partition | 1 vs 7 nodes                                                                                                                                                  | 120    | 1.01            | 0               | 111                | 0               | 0                | 0                  |
| h09-part-witness-all-cl   | partition | 1 vs 9 nodes                                                                                                                                                  | 0      | -               | 0               | 1                  | 0               | 0                | 0                  |
| h10-throttle-own-cl       | throttle  | l2-cl-2-validator                                                                                                                                             | 91     | 1.01            | 0               | 0                  | 0               | 0                | 2                  |

("network stall" excludes the faulted node; "worst node stall" includes it; per-node reorgs and height-backwards are on the faulted producer in every case where they are non-zero; the milestone column is blank from h08 on because the probe read it from cl-8, which was down, until it was repointed to cl-1.)

## Conclusions

**Answer to the thread.** Jerry is right that heimdall is a hard dependency, but the dependency has two different shapes, and the failure *mode* matters more than the failure itself.

1. **Followers stop importing without heimdall, immediately.** Every block import runs a header verification that fetches the milestone end block from heimdall; with no reachable heimdall the fetch times out and the node sits at its head (h09: 111 s stall on el-4 with the network at 1.01 blocks/s; el-2 and el-8 frozen at 350063 in h06). "Bor will stop syncing" is exactly right.

2. **Producers stop sealing at the first mandatory heimdall call, not immediately.** A producer can seal on its cached span until it hits a call it cannot skip: the state-sync fetch (`clerk/time`) at every sprint start (every 16 blocks), the span fetch near a span boundary. That call blocks the block build for the full 30 s attempt timeout (`consensus/bor/heimdall/failover_client.go: defaultAttemptTimeout = 30s`); h01 blocked 30.85 s on block 348128, h06 blocked 50 s on 350064. Heimdall notices the missing blocks and rotates the producer after ~11 heimdall blocks (`Span rotated due to the current producer's ineffectiveness`), so the *network* sees a 13-17 s gap and moves on (h01, h04, h05, h08).

3. **Why the earlier campaign saw no effect (p08, p17).** Those were kills: connection refused fails in milliseconds and the failover client cascades to the next of the nine configured heimdalls (`[heimdall] url` lists all validators and both RPC heimdalls) before any mandatory call is due. Graceful stop behaves the same (h03: 1.02 blocks/s). A frozen heimdall (h02) *also* went unnoticed, but only because the health registry's proactive switch (~10 s) happened to land before the next sprint start; the same freeze one sprint earlier would have looked like h01.

4. **The dangerous modes are the ones that time out or answer slowly.** Partition (h01, h04, h05), and latency (h08: no failover at all, because every call eventually succeeds within 30 s while the milestone fetch's own deadline keeps failing). In all of these the in-turn producer lost its turn.

5. **Halt: only when *every* heimdall is unreachable to *everyone*** (h06 frozen, h07 killed): 0.09-0.14 blocks/s, 65-86 s stalls, because the producer blocks on its mandatory call and no follower can verify anything. Partial outages, including the producer's own heimdall and even all three producer heimdalls (p17), do not halt the chain thanks to the failover list.

6. **Fork: yes, but confined to the producer that was blind.** In h04/h05 the isolated producer's last block(s) (1 block) and in h06/h07 its whole outage-era chain (14 and 16 blocks) were orphaned when heimdall, on recovery, rotated the producer *retroactively* from the last milestone end block. The reorg happened on that node only (`per_node_reorgs` 11 and 9, zero on every other node), because followers could not import the blind producer's blocks (item 1) and the store consumers rejected them as consensus-invalid. Clients reading that producer's RPC, which is an nginx upstream in this package, saw 14-16 blocks disappear.

7. **Wedge: a producer that was partitioned from heimdall during its turn does not recover when the partition heals** (h04, h05: still stuck 8 min later; fixed only by restart, h04r/h05r). It dropped the producer peers as `invalid-chain` while blind, and its downloader then livelocks on the checkpoint whitelist against witness-sync peers that cannot serve the checkpoint block (`whitelist-no-remote`, `peer_response.go:117` maps it to "no peer action"). The dead-L1 checkpoint (block 9247) makes this worse here, but the peer-selection livelock is independent of that. A producer that lost heimdall by pause/latency (h02, h08) or that had heimdall back before the rotation (h06) did self-heal.

**Findings, ranked.**

- **H1 (bor).** Producer block building performs synchronous heimdall calls with a 30 s attempt timeout and no bound on the block cadence; a single timing-out heimdall costs the in-turn producer its turn and the network a ~15 s gap, even with eight healthy heimdalls configured. Suggested: shorter per-call deadline for calls on the sealing path, or issue mandatory calls against the health-registry's current best endpoint rather than the sticky primary (h01 vs h02 shows the registry knew after 10 s).
- **H2 (bor).** After losing heimdall during its turn, a producer can wedge permanently: `invalid-chain` drops of the good peers plus `whitelist-no-remote` against peers that cannot serve the whitelist block, with no peer rotation. Needs a restart. Suggested: rotate or drop the peer on `ErrNoRemote`, and re-admit peers dropped as invalid-chain once heimdall is reachable again.
- **H3 (heimdall/bor).** On recovery from a total heimdall outage, heimdall rotates the producer retroactively from the last milestone, orphaning every block the in-turn producer sealed during the outage (14-16 blocks here). Expected by the protocol, but it is a reorg visible to anyone reading that producer's RPC and it demotes the included transactions.
- **H4 (bor).** A slow heimdall (2 s one-way) is never failed over; the milestone fetch keeps timing out while the failover client considers the endpoint healthy. The producer stays stuck on it until the latency clears.
- **H5 (kurtosis-pos).** RPC heimdall containers ran `heimdalld init` on every start and died on restart; validator heimdalls did not. **Fixed** in `src/cl/heimdall_v2/launcher.star` (init guarded by `test -f .../node_key.json ||`) and verified on a fresh `robust-seqstore.yml` deploy on 2026-09-14: `kill --for 5s` on cl-8 and cl-9 brought both back within 25 s with unchanged node ids (`9cbe3739...` and `eb79b22a...`).
- **H6 (bor, stateless).** Witness-sync nodes serve no headers below their fast-forward start (el-5: nothing below 99466) although they advertise `earliestBlock: 0`, so they cannot answer whitelist checks for old checkpoints and appear as `whitelist-no-remote` peers; combined with H2 this is what wedged el-1 and el-3.

**Operational takeaways.** Keep the multi-heimdall list (it is what saved p08/p17/h03). Alert on `Heimdall failover` and `Failed to fetch milestone end block` on producers, not just on heimdall health. Treat a producer that logs `whitelist-no-remote` for more than a minute after connectivity returns as wedged and restart it. Any total heimdall outage should be assumed to cost the in-turn producer every block it sealed after the outage began.

## Close-out

`tartarus fault list` -> `[]`; `list --done` holds h01..h10 plus h04r/h05r and the two rolled-back h09 attempts, all `completed` or `rolled_back`; `cleanup --all` -> no records, no orphan chains; no `tartarus` iptables chains, no netem qdiscs, no CPU quota left on any container. Probe and load generator stopped. Enclave state at close: all nine bor heads equal and advancing at 1 block/s, milestones advancing, checkpoints still frozen at 218 (dead L1 since the first campaign), **heimdall cl-8 and cl-9 down since h07 (finding H5)**, el-1 and el-3 restarted once each (h04r, h05r). Evidence: `records/h*.json`, `records/h*-<service>.log`, `records/h04-el-1-wedged.log`, `probes/oracle.log` (continuous from 22:11Z), `heimdall-summary-table.md`.
