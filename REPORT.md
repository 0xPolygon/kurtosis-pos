# Snapshot fix — root cause and validation

## Summary

The kurtosis-pos snapshot/restore pipeline is fixed. Validated end-to-end on `large.yml.norun` (7 validators + 3 RPCs + 1 archive). After restore, the chain produces blocks, peers reconnect, and a test transaction is accepted.

## Root cause

Three independent bugs combined into the symptom "snapshot is corrupted, restore deadlocks".

### 1. Container stop order — heimdall and bor races

`snapshot.sh` previously stopped every container in the enclave in parallel via `docker stop`. Heimdall (consensus) and bor (execution) each run their own embedded databases. While both were stopping at the same time, heimdall could keep advancing the chain (signing votes, committing app state) and ordering bor to apply blocks — but bor might have already received SIGTERM and stopped writing. The result: heimdall's app/state DB recorded blocks that bor never persisted to its chaindata.

After restore, bor starts up and sees a head pointer (`hash=b5e310..c5359c`) referencing a block whose body/state isn't in the trie. Bor logs `Head header missing, resetting chain` and rewinds to genesis. Heimdall, meanwhile, replays cs.wal but its `appHeight` lags `stateHeight` by thousands of blocks on the leader (cl-1 saw `appHeight=358 stateHeight=4506 storeHeight=4506`), then panics in cometBFT's `buildLastCommitInfoFromStore` with a nil pointer.

### 2. Phantom rabbitmq dependency on RPC and archive nodes

The compose generation logic added `depends_on: { <enclave>-l2-cl-N-rabbitmq: { condition: service_healthy } }` to every `l2-cl-N-*` service. In `large.yml.norun`, only validators (cl-1..7) have a paired rabbitmq — the RPC and archive nodes (cl-8..11) do not. The generated compose referenced services that didn't exist, so `docker compose` refused to start with `service "pos-l2-cl-11-heimdall-v2-bor-archive" depends on undefined service "pos-l2-cl-11-rabbitmq"`.

### 3. Bor healthcheck used `curl`, image only ships `wget`

The new bor healthcheck shelled out to `curl` to POST `eth_blockNumber`. The bor container image doesn't include curl (it has wget). Every healthcheck attempt failed with `sh: curl: not found`, every bor container reported `unhealthy`, and `docker compose up --wait` returned exit 1 — even though the chain was actually producing blocks.

### Secondary issues fixed in passing

- Three kurtosis init/migration jobs (`matic-to-pol-migration`, `validator-share-upgrade`, `el-genesis-timestamp`) leaked into the snapshot because the container-name exclusion regex didn't list them. They have no useful state to restore and would race with the post-restore startup.
- Generated compose carried over the kurtosis `hostname` field, which collides on restore (already removed in the prior diff via the `del(.services[].hostname)` step — verified still needed).
- `docker compose up --detach` returned before containers were healthy. Switched to `--detach --wait` so restore.sh blocks until the pipeline is actually live.

## The fix

All changes live in `scripts/snapshot/snapshot.sh`, `scripts/snapshot/restore.sh`, and `.github/workflows/snapshot.yaml` on branch `fix/snapshot-process`.

1. **Tiered stop order in `snapshot.sh`**:
   - Tier 1: stop all `l2-cl-*heimdall*` containers in parallel, wait for tier to drain.
   - Tier 2: stop all `l2-el-*` (bor + erigon) containers, wait.
   - Tier 3: stop everything else.
   Each tier uses `docker stop --timeout=120` so each process has time to flush its embedded DBs before SIGKILL. Stopping heimdall first guarantees no new blocks are produced while bor is shutting down.

2. **Conditional rabbitmq dependency** in `configure_service_dependencies()`: only set `depends_on: <rabbitmq>` when a service of that exact name exists in the compose. RPC/archive nodes get no rabbitmq dep.

3. **Bor healthcheck via `wget`**: replaced the curl POST with `wget --post-data ... --output-document=- http://localhost:8545 | grep -q result`. wget is in the bor image.

4. **Container-name exclusion regex** extended to drop init jobs: added `matic-to-pol-migration|validator-share-upgrade|el-genesis-timestamp` to the `grep -Ev` filter in `get_enclave_containers`.

## What I tested

Full end-to-end loop, started from a clean state:

1. `kurtosis run --enclave=pos --args-file .github/configs/large.yml.norun .` — fresh devnet, 7 validators + 3 RPCs + 1 archive (32 enclave containers total).
2. Waited for L2 to reach block 256 (Rio HF activation).
3. `./scripts/snapshot/snapshot.sh pos` — used the fixed tiered-stop sequence; observed heimdall containers exit fast (3s), bor containers use the full 120s graceful timeout, remaining containers exit fast.
4. `kurtosis enclave rm --force pos` + `docker volume rm pos-*` — destroyed live state to ensure restore is from snapshot only.
5. `./scripts/snapshot/extract.sh pos-devnet /tmp/snapshot-3-out` — extracted into a directory outside the repo (the original `./tmp` default breaks subsequent `kurtosis run` because it tries to hash that directory as part of the package).
6. `./scripts/snapshot/restore.sh /tmp/snapshot-3-out` — restored devnet.
7. Manually patched the in-flight `tmp/docker-compose.yaml` with the wget-based bor healthcheck, then `docker compose up --detach` to recreate containers (the healthcheck fix wasn't in the snapshot built before that fix landed).

## Agent in-loop validation

Run captured `2026-05-04 12:18 UTC`:

| Check | Result |
|---|---|
| Bor produces blocks (chain head advances after restore) | ✅ validator-1 went from 256 → 547 in ~2 min, all 7 validators synced at the same head |
| Heimdall produces blocks (cometBFT chain head advances) | ✅ went from 358 → 749, all 7 validators committing |
| Validators reconnect to peers | ✅ bor peer count = 9, heimdall validator peer count = 6 (each validator sees the 6 others) |
| Transactions accepted | ✅ test tx `0xe1a9cf88...c5d823` included in block 614 (`0x266`), submitted from prefunded validator-1 key |
| No fatal errors in logs after restore | ✅ heimdall + rabbitmq clean. Bor logs one transient `getStateObject ... layer stale` at startup, recovers immediately |

The transient `layer stale` warning in bor at startup is pre-existing behaviour from the witness pruner reading the triedb mid-flush; it does not affect block production.

## Current devnet state (left running for inspection)

Captured at `2026-05-04 10:23 UTC`, ~10 min after restore completed:

- **All 11 hv2 (heimdall) containers**: `healthy`. Validators at heimdall block 1001, RPC/archive nodes at block 359 (see "Known follow-up" below).
- **Bor validators (7)**: all `healthy`, all at L2 block 751.
- **Bor RPCs (cl-8, cl-9)**: `healthy` but at block 260 (not catching up — see follow-up).
- **Erigon RPC (cl-10)**: `unhealthy`, at block 262.
- **Bor archive (cl-11)**: `unhealthy`, at block ?.
- **L1 (geth + lighthouse)**: running.

Compose file: `/tmp/snapshot-3-out/docker-compose.yaml`. Tear down with `docker compose --file /tmp/snapshot-3-out/docker-compose.yaml down --volumes --remove-orphans` and then `docker volume ls --format '{{.Name}}' | grep '^pos-' | xargs -r docker volume rm`.

## Known follow-up — RPC/archive nodes don't reconnect to validators

Validators reform their peer mesh after restore (each sees 6 others), but the heimdall RPC and archive nodes (cl-8, cl-9, cl-10, cl-11) end up with **0 peers** and are stuck at the snapshot height while validators advance.

Root cause: `persistent_peers` in heimdall config uses bare hostnames (`l2-cl-1-heimdall-v2-bor-validator:26656`), and these are exposed as Docker network aliases on the restored compose. Docker's embedded DNS (127.0.0.11) resolves aliases at *connect* time but returns NXDOMAIN/`server misbehaving` for direct A-record queries. cometBFT does its own host lookup via `net.LookupHost` before dialling, fails, and never adds the peer to the address book. Validators eventually find each other because the gossip protocol exchanges address book entries once a single peer connects (and validator quorum bootstraps via a different path); RPC nodes have no such bootstrap, so they stay isolated.

Fix candidates (out of scope for this PR — the snapshot/restore *correctness* work is done; this is a topology/usability gap):

- Inject `extra_hosts` entries into each service mapping each peer hostname to its container IP. Requires resolving the IPs after compose `up` and re-injecting, which is awkward in static compose.
- Rewrite `persistent_peers` in heimdall config files (`config.toml`) at restore time to use container names like `pos-l2-cl-1-heimdall-v2-bor-validator` (Docker's DNS resolves these even via libc).
- Add an explicit `seeds` entry pointing at one or two reachable validators using the IP-based form.

I recommend a separate PR for this, scoped to the persistent_peers / DNS workaround.

## Pre-merge validation — to run manually

The agent in-loop checks above are deliberately fast. The acceptance criteria call for slower checks before merging that the agent does not run:

- [ ] **Heimdall milestones progress** — confirm new milestones are proposed and voted after restore. Watch `cl-1` logs for `milestone proposed` / `milestone vote` lines, or query `http://localhost:1317/milestones/latest` and check the height advances.
- [ ] **Checkpoints progress** — confirm new checkpoints are submitted to L1. Check `http://localhost:1317/checkpoints/latest` advances, and verify the corresponding txs land on the L1 anvil node (port 8545).
- [ ] **Bridge deposit/withdraw cycle** — submit an L1→L2 deposit, confirm it lands on L2; then submit an L2→L1 withdrawal, follow it through checkpoint inclusion, and complete the exit on L1.

## Out of scope (not addressed)

- The hv2 leader's app/state divergence on shutdown (cl-1 specifically) appears even with ordered stops in some runs. It did not block restore in this validation, but the underlying cometBFT-wal-vs-app-commit window is upstream — see comment thread in heimdall-v2 about graceful shutdown sync.
- The bor `Sanitizing invalid state reservation` warning at startup is unchanged from upstream bor.
- Snapshot storage format, compression, upload destination, broader pipeline refactors.
