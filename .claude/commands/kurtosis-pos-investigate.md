## Related skills

- **kurtosis-pos-deploy** — snapshot create/restore, full deploy
- **kurtosis-pos-interact** — service inspection, logs, shells, cast
- **kurtosis-pos-test** — chaos testing, spammers, bridge flows

---

## Goal

Run autonomous investigations to find bugs in bor and heimdall-v2. Each agent spins up an isolated devnet, probes a scenario, collects evidence, and documents any finding — then tears down.

---

## Components

### Bor — L2 execution layer

Bor is the EVM-compatible execution client for Polygon PoS. It produces blocks in fixed-length **sprints** (16 blocks), where a single validator is the designated producer per sprint. Validator assignment rotates every **span** (128 blocks). Bor peers with Heimdall to receive span and checkpoint information.

- Repo: https://github.com/0xPolygon/bor
- In kurtosis-pos: `l2-el-<n>-bor-heimdall-v2-*` services

```bash
# Clone if needed
git clone https://github.com/0xPolygon/bor
```

### Heimdall-v2 — L2 consensus layer

Heimdall-v2 is the CometBFT-based consensus layer. It manages the validator set, submits checkpoints to L1, and coordinates span/sprint assignments for Bor. It communicates with Bor via RabbitMQ.

- Repo: https://github.com/0xPolygon/heimdall-v2
- In kurtosis-pos: `l2-cl-<n>-heimdall-v2-bor-*` services

```bash
# Clone if needed
git clone https://github.com/0xPolygon/heimdall-v2
```

---

## Protocol mechanisms

Understanding these four mechanisms is essential for knowing what to probe and what to look for.

### 1. Spans and block producers

A **span** is a range of Bor blocks during which a fixed, stake-weighted selection of validators takes turns producing blocks. Within a span, validators rotate as block producer every **sprint**.

- **Devnet values**: sprint = 16 blocks, span = 128 blocks (8 sprints). These differ from mainnet — always read from `src/config/constants.star` (`EL_SPRINT_DURATION`, `EL_SPAN_DURATION`).
- Heimdall proposes the next span and validators vote on it via CometBFT consensus.
- Bor fetches the current span from Heimdall's REST API at each span boundary.
- If the scheduled producer misses its sprint, the next validator in the rotation takes over after a timeout.

**What to watch**: span transitions (every 128 blocks), producer misses, Bor failing to fetch the new span from Heimdall.

### 2. Milestones — soft finality

A **milestone** is a Heimdall-internal finality marker for a range of Bor blocks. Heimdall validators periodically propose and vote on milestones (2/3+ threshold). Once agreed, Bor will not reorg past that point.

- Milestones are **not submitted to L1** — they are internal to Heimdall.
- They provide fast soft finality without waiting for an L1 checkpoint.
- If Heimdall consensus is lost, milestone progression stalls, but Bor can still produce blocks.

**What to watch**: milestone height stalling while Bor advances, Heimdall disagreement on milestone proposals, reorgs past a milestone after a validator failure.

### 3. Checkpoints — hard finality

A **checkpoint** is a Merkle root of a range of Bor block headers, submitted by Heimdall to the L1 RootChain contract. Once on L1, those Bor blocks are irreversibly finalised.

- Heimdall submits checkpoints periodically (roughly every N Bor blocks, configurable).
- Validators reach CometBFT consensus on the checkpoint before any one submits it.
- The L1 contract validates the checkpoint and emits an event.
- Checkpoint submission requires L1 gas — if L1 is unreachable, checkpoints queue up in Heimdall.

**What to watch**: checkpoint interval growing, submission failures logged by Heimdall, checkpoint gaps on L1, Bor advancing far ahead of the last checkpoint.

### 4. State syncs — L1→L2 bridging

**State sync** is the mechanism by which L1 deposit events reach Bor.

1. A deposit is made on L1 (e.g. `depositERC20` on the DepositManager contract) — an event is emitted.
2. Heimdall watches L1 for these events and records them as state sync entries.
3. Heimdall sends the state sync data to Bor via **RabbitMQ**.
4. Bor processes the state sync in the **first block of the next sprint** after Heimdall delivers the data via RabbitMQ.
5. The StateReceiver precompile on Bor executes the sync and updates L2 balances.

**What to watch**: state syncs queued in Heimdall but not delivered to Bor (RabbitMQ failure), duplicate or replayed state syncs, state sync events dropped after a Heimdall restart, L2 balance not updated after a confirmed L1 deposit.

---

## Environment setup

### Preferred: full deploy (use this for now)

The snapshotting process may be broken in recent versions of kurtosis-pos. Use a normal deploy as the starting point until snapshots are confirmed working:

```bash
kurtosis run --enclave $ENCLAVE --args-file .github/configs/heimdall-v2-bor.yml .
```

This takes ~10–15 min but is reliable. See `/kurtosis-pos-deploy` for config options.

### Future: snapshot restore (~20s)

Once snapshots are fixed, create a shared base snapshot once and have all agents restore from it:

```bash
# Create (one-time)
kurtosis run --enclave pos-base .
./scripts/snapshot/snapshot.sh pos-base
kurtosis enclave rm --force pos-base

# Restore (per agent)
./scripts/snapshot/restore.sh ./snapshots/<folder>
```

The snapshot must match the current image versions in `src/config/constants.star`.

---

## Enclave naming

Each agent needs a unique enclave name to run in parallel:

```bash
ENCLAVE="pos-agent-$(date +%s)-$$"
```

Or use a sequential ID when orchestrating a batch: `pos-agent-1`, `pos-agent-2`, etc.

---

## Investigation loop

```
deploy → health check → probe scenario → observe → document finding → create POC → tear down
```

```bash
# 1. Deploy (~10–15 min)
kurtosis run --enclave $ENCLAVE --args-file .github/configs/heimdall-v2-bor.yml .

# 2. Health check — verify devnet is ready before probing
.github/actions/monitor/blocks-bor.sh $ENCLAVE first
.github/actions/monitor/checkpoints.sh $ENCLAVE

# 3. Probe — run chosen scenario (see categories below)

# 4. Observe — collect evidence (see evidence section below)

# 5. Document — write finding if anomaly detected (see anomaly signals and report format below)

# 6. Create POC — reduce the reproduction to the minimal set of commands that reliably
#    triggers the issue from a clean deploy; verify it reproduces before tearing down

# 7. Tear down
kurtosis enclave rm --force $ENCLAVE
```

---

## Scenario categories

Iterate on this list as new scenarios are discovered. For each scenario: trigger the condition, then watch the anomaly signals section for signs of failure.

### Service throttling (Docker resource limits)

Apply resource pressure to a running service without stopping it:

```bash
# Find the container ID for a kurtosis service
CONTAINER=$(docker ps --format "{{.ID}}\t{{.Names}}" | grep "<service-name>" | awk '{print $1}')

# Throttle CPU (e.g. limit to 0.2 cores)
docker update --cpus 0.2 $CONTAINER

# Throttle memory
docker update --memory 256m --memory-swap 256m $CONTAINER

# Throttle IO — relative weight 10–1000, default 500 (cgroup v1 only; may not work on all systems)
docker update --blkio-weight 10 $CONTAINER

# Remove limits
docker update --cpus 0 --memory 0 $CONTAINER
```

### Network degradation (tc / iptables)

Inject network faults into a running container using `tc` (traffic control) or `iptables`. Run these inside the container via `kurtosis service shell` or `docker exec`.

```bash
# Shell into a service container
kurtosis service shell $ENCLAVE <service-name>

# Add 200ms latency to all outbound traffic (requires iproute2 in the container)
tc qdisc add dev eth0 root netem delay 200ms

# Add latency + jitter (200ms ± 50ms)
tc qdisc add dev eth0 root netem delay 200ms 50ms

# Random packet loss (10%)
tc qdisc add dev eth0 root netem loss 10%

# Corrupt packets (1%)
tc qdisc add dev eth0 root netem corrupt 1%

# Remove all tc rules
tc qdisc del dev eth0 root

# Drop all traffic to a specific peer IP (iptables)
iptables -A OUTPUT -d <peer-ip> -j DROP

# Remove the drop rule
iptables -D OUTPUT -d <peer-ip> -j DROP
```

Note: `tc netem` requires the `iproute2` package and kernel `netem` module. `iptables` requires `NET_ADMIN` capability. Both may or may not be available depending on the container image and Docker configuration. Verify with `tc qdisc show` and `iptables -L` before relying on these.

### Reliability

Focus: state consistency, liveness, and recovery under stress.

| Scenario | How to trigger |
|---|---|
| Validator restart mid-sprint | Stop both EL and CL: `kurtosis service stop $ENCLAVE l2-el-0-bor-heimdall-v2-validator` + `kurtosis service stop $ENCLAVE l2-cl-0-heimdall-v2-bor-validator`, then restart both |
| Rolling restart (one at a time) | Stop/start each validator pair in sequence, waiting for recovery between each |
| All validators restart simultaneously | Stop all `l2-el-*` and `l2-cl-*` services at once, then restart all |
| Validator rejoin after extended downtime | Stop a validator for several spans (>128 blocks), then restart and observe resync |
| L1 EL (geth) unreachable | `kurtosis service stop $ENCLAVE el-1-geth-lighthouse` |
| L1 CL (lighthouse) unreachable | `kurtosis service stop $ENCLAVE cl-1-lighthouse-geth` |
| RabbitMQ crash | `kurtosis service stop $ENCLAVE l2-cl-0-rabbitmq` — observe bor/heimdall coordination breakdown |
| Steady tx load (L1+L2) | Deploy with `tx_spammer` at startup — sends 100 requests at 50 req/s every 10s on both L1 and L2 |
| Steady bridge load | Deploy with `bridge_spammer` at startup — bridges 1 MATIC/POL + 1 ERC20 from L1 to L2 every ~5s |
| Checkpoint timeout | Stop all heimdall validators, observe bor behavior |
| High latency between validators | Inject 500ms+ latency on validator containers via `tc netem delay` (see network degradation note above) |
| Packet loss between validators | Inject 10–30% packet loss on validator containers via `tc netem loss` |
| Network partition (drop peer traffic) | Drop traffic to a specific peer IP via `iptables -A OUTPUT -d <peer-ip> -j DROP` inside a validator container |
| CPU-starved heimdall | `docker update --cpus 0.1` on heimdall containers; observe checkpoint and milestone delays |
| Memory-pressured bor | `docker update --memory 256m` on a bor container; observe mempool and block production under pressure |
| Sprint boundary behavior | Monitor block production at every multiple of 16 blocks (devnet sprint; mainnet is also 16 but verify via `EL_SPRINT_DURATION` in `src/config/constants.star`) |
| Span transition | Monitor validator producer rotation at every multiple of 128 blocks (devnet span = 8 sprints × 16; mainnet span is much larger — always use devnet values from `src/config/constants.star`) |
| Rio hard fork transition | Observe block production and state around block 256 |
| Heimdall state divergence | Compare `/status` across multiple heimdall validators |

### Consensus & Finality

Focus: block production correctness, validator coordination, and finality guarantees.

| Scenario | How to trigger |
|---|---|
| Missed block (producer skip) | Stop only the scheduled bor producer for one sprint; observe if next producer takes over |
| Checkpoint submission delay | Throttle heimdall via Docker CPU/memory limits (see throttling note above); observe how far bor continues without checkpoints |
| Validator set change propagation | Add or remove a validator via contracts; observe how quickly bor picks up the new span |
| Finality regression after L1 issue | Restart L1 mid-checkpoint; observe if heimdall resubmits or skips |
| Mixed client consensus | Use `heimdall-v2-mix.yml` (bor + erigon validators); check state root agreement |
| CometBFT consensus under validator loss | Stop validators one by one until below 2/3 threshold; observe halt behaviour |
| Milestone stall under validator loss | Stop enough validators to break 2/3 threshold; observe milestone height freeze while Bor continues producing blocks |
| Reorg past a milestone | Force a local reorg on a bor node (via `debug_setHead`) past a milestoned block; observe whether it is rejected |

### High Availability

Focus: behaviour when redundancy is reduced or lost entirely.

| Scenario | How to trigger |
|---|---|
| Majority validator loss | Stop >50% of validators; observe whether block production halts or degrades |
| All heimdall nodes down, bor running | Stop all `l2-cl-*` services; observe bor behaviour without consensus layer |
| RPC node crash | Stop `l2-el-0-bor-heimdall-v2-rpc`; verify validator nodes are unaffected |
| Heimdall API unresponsive | Stop heimdall on one node; observe whether bor falls back or stalls |
| Full sequential restart | Stop all services top-down, restart bottom-up; verify full recovery |

### EVM & Blockchain

Focus: correct EVM execution, state consistency, and edge cases in block/transaction handling.

| Scenario | How to trigger |
|---|---|
| Max gas transaction | Send a transaction consuming the full block gas limit |
| Large calldata transaction | Send a transaction with ~128KB calldata |
| Nonce gap | Submit a transaction with nonce+2 (skipping nonce+1); observe mempool behaviour |
| Zero-value transaction | Send a tx with 0 value and empty calldata |
| Contract deployment near sprint boundary | Deploy a contract in the last few blocks of a sprint |
| State root consistency | Compare `eth_getBlockByNumber` state root across all bor nodes after same block |
| EIP-2935 block hash history | Query `blockhash(N)` for recent blocks; verify against on-chain history contract |
| Gas price edge cases | Submit txs with 0 gas price, max uint256 gas price, and exactly the minimum |
| Large contract deployment | Deploy a contract near the bytecode size limit (24KB) |
| Reorg handling | Use `debug_setHead` on one bor node to force a local reorg; observe peer reconciliation |

### Security

Focus: invariant violations, unauthorised state changes, and protocol abuse via exposed endpoints.

The primary attack surface is the set of **exposed HTTP/WebSocket endpoints**. For each service, enumerate available endpoints, then probe with unexpected inputs, boundary values, unauthorised calls, and replayed requests.

**Reaching service endpoints:**

```bash
# Bor JSON-RPC
BOR_RPC=$(kurtosis port print $ENCLAVE l2-el-0-bor-heimdall-v2-validator rpc)

# Heimdall REST API (port id: http, default: 1317)
HEIMDALL_REST=$(kurtosis port print $ENCLAVE l2-cl-0-heimdall-v2-bor-validator http)
curl http://$HEIMDALL_REST/heimdall/v1/...   # enumerate routes from heimdall-v2 repo

# Heimdall gRPC (port id: grpc, default: 3132)
HEIMDALL_GRPC=$(kurtosis port print $ENCLAVE l2-cl-0-heimdall-v2-bor-validator grpc)

# Heimdall CometBFT RPC (port id: rpc, default: 26657)
HEIMDALL_COMET=$(kurtosis port print $ENCLAVE l2-cl-0-heimdall-v2-bor-validator rpc)

# RabbitMQ management UI (port id: management, default: 15672) — if exposed
RABBITMQ_MGMT=$(kurtosis port print $ENCLAVE l2-cl-0-rabbitmq management 2>/dev/null)
```

| Scenario | How to trigger |
|---|---|
| Bor JSON-RPC abuse | Probe `admin_*`, `debug_*`, `txpool_*`, `personal_*` methods — check which are exposed and whether they accept unauthenticated calls |
| Heimdall REST API abuse | Enumerate all REST endpoints (see heimdall-v2 repo); call write/state-change endpoints without auth; send malformed or oversized payloads |
| Heimdall gRPC endpoint abuse | Probe gRPC endpoints exposed by heimdall-v2 with unexpected or replayed messages |
| RabbitMQ management API | Check if the RabbitMQ management UI/API is exposed; attempt to publish or consume messages directly |
| L1 reorg | Use `anvil_mine` or `debug_setHead` on geth to force a reorg; observe heimdall/bor reaction |
| Bridge replay | Replay an already-processed L1→L2 bridge deposit transaction |
| Bridge amount boundary | Submit bridge deposits with amount=0, amount=max uint256, and amount=uint256 overflow |
| ERC20 approval front-running | Race an `approve` + `depositERC20` pair to observe ordering vulnerabilities |
| Validator set manipulation | Deploy contracts with unexpected validator configuration (zero stake, duplicate address) |
| Zero-stake validator registration | Attempt to register a validator with 0 stake via matic contracts |
| Heimdall validator equivocation | Configure two heimdall nodes with the same validator key; observe double-sign detection |
| Bor producer manipulation | Attempt to produce a block from a non-scheduled producer address |
| Signer key rotation timing | Trigger a signer update during an active sprint; observe whether old or new signer is accepted |
| Admin key operations post-deploy | Call matic contract admin functions (ownership transfer, emergency stop) after contracts are live |
| Contract state corruption | Call matic contract functions in unexpected order or with boundary values (max validators, zero amounts) |
| Checkpoint replay | Replay a previously submitted checkpoint to L1; observe contract handling |
| Unauthorised stake withdrawal | Attempt to withdraw stake before unbonding period or from a non-owner address |

---

## Chaos testing frameworks

Manual scenarios cover known failure modes. These two frameworks go further — Jepsen finds consistency violations systematically, Antithesis finds them deterministically.

### Jepsen

Jepsen is a fault injection and consistency verification framework for distributed systems. It is famous for uncovering consensus and safety bugs in databases, queues, and blockchain nodes. It works by:

1. Deploying a cluster of nodes
2. Running concurrent client workloads (reads, writes, transactions)
3. Injecting faults (network partitions, node kills, clock skew) during the workload
4. Checking a consistency model (linearizability, sequential consistency, etc.) against the observed history

Jepsen tests are written in Clojure and operate over SSH. Since kurtosis-pos services are reachable via exposed ports, a Jepsen test could target the Bor JSON-RPC and Heimdall REST API directly.

- Repo: https://github.com/jepsen-io/jepsen
- Particularly relevant for: checkpoint safety, milestone finality, validator set consistency, bridge replay

### Antithesis

Antithesis is a deterministic simulation testing platform. Unlike Jepsen (which injects faults probabilistically), Antithesis runs software in a fully deterministic, instrumented environment where every source of non-determinism (network, disk, time) is controlled. This allows it to reliably reproduce rare bugs and systematically explore all reachable states.

- Website: https://antithesis.com
- Requires deeper instrumentation of bor and heimdall-v2 binaries
- Particularly relevant for: race conditions, consensus edge cases, state machine correctness

### Pumba (Docker-native, lower barrier)

Pumba is a Docker chaos tool that wraps `tc netem` and container lifecycle operations. It requires no cluster setup or instrumentation — it runs directly against the Docker containers kurtosis creates.

```bash
# Install
go install github.com/alexei-led/pumba@latest

# Add 200ms latency to all traffic on a bor container
pumba netem --duration 60s delay --time 200 $(docker ps --filter "label=com.kurtosistech.enclave-id=$ENCLAVE" --format "{{.Names}}" | grep "bor-heimdall-v2-validator")

# Random packet loss (15%) on a heimdall container
pumba netem --duration 60s loss --percent 15 $(docker ps --filter "label=com.kurtosistech.enclave-id=$ENCLAVE" --format "{{.Names}}" | grep "heimdall-v2-bor-validator")

# Kill and restart a container on a schedule
pumba --random kill --signal SIGKILL $(docker ps --filter "label=com.kurtosistech.enclave-id=$ENCLAVE" --format "{{.Names}}" | grep "l2-el")
```

- Repo: https://github.com/alexei-led/pumba
- Lower barrier than Jepsen/Antithesis — works immediately against a running kurtosis enclave

---

## Anomaly signals

Any `ERROR` log line is worth investigating — treat all errors as potential findings until proven benign.
`WARN` log lines are sometimes significant; flag them when they correlate with observable degradation.

### What degradation looks like

The network is degraded when any of the following stops working:

- Blocks are not produced
- Milestones are not progressing
- Checkpoints are not submitted to L1
- Transactions are submitted but never included in a block
- Bridge deposits on L1 are not reflected on L2

### Timing reference (devnet)

Devnet block time is ~2 seconds. Use these thresholds to decide when to stop waiting and document a finding:

| Signal | Wait before flagging |
|---|---|
| Blocks stall | 2 sprints — ~64 seconds (32 blocks) |
| Milestone stall | 3 milestone intervals — ~90 seconds (default interval: 30s) |
| Checkpoint stall | 1 span — ~4 minutes (128 blocks) |
| Transaction not included | 3 blocks — ~6 seconds |
| State sync not processed | 2 sprints after confirmed L1 deposit — ~64 seconds |
| Validator not recovered after restart | 1 span — ~4 minutes |

### Signal checklist

Stop and document when any of these occur:

- **Blocks stall** — L2 block number not advancing for >2 sprints (~64 seconds)
- **Service crash** — any `l2-el-*` or `l2-cl-*` container exits unexpectedly
- **Checkpoint failure** — no new checkpoint on L1 for >1 span (~4 minutes)
- **Milestone stall** — milestone height not advancing for >90 seconds
- **State sync not processed** — L2 balance unchanged >2 sprints after a confirmed L1 deposit
- **Transaction not included** — submitted tx absent from all blocks for >3 blocks (~6 seconds)
- **State divergence** — two validators report different block hash or heimdall height for the same block number
- **Consensus error** — log lines containing `consensus failure`, `double sign`, `equivocation`, or `panic`
- **Unexpected revert** — a transaction reverts that should succeed (or succeeds that should revert)
- **Any ERROR log** — treat as a finding; investigate before dismissing
- **WARN log correlated with degradation** — flag if a WARN appears at the same time as any signal above

---

## Evidence collection

Save everything to `findings/<slug>/` under the repo root. Set `SLUG` to a short identifier (e.g. `bor-stall-sprint-boundary`) and `N_VALIDATORS` to the number of validators in your config (2 for `heimdall-v2-bor.yml`).

```bash
SLUG="<short-description>"
N_VALIDATORS=2
mkdir -p findings/$SLUG

# Collect logs from all validators
for n in $(seq 0 $((N_VALIDATORS - 1))); do
  kurtosis service logs $ENCLAVE l2-el-$n-bor-heimdall-v2-validator > findings/$SLUG/bor-$n.log
  kurtosis service logs $ENCLAVE l2-cl-$n-heimdall-v2-bor-validator > findings/$SLUG/heimdall-$n.log
done

# Current L2 block
cast block-number --rpc-url http://$(kurtosis port print $ENCLAVE l2-el-0-bor-heimdall-v2-validator rpc)

# Latest L2 block details
cast block latest --rpc-url http://$(kurtosis port print $ENCLAVE l2-el-0-bor-heimdall-v2-validator rpc)

# Latest milestone (soft finality)
curl -s http://$(kurtosis port print $ENCLAVE l2-cl-0-heimdall-v2-bor-validator http)/milestone/latest | tee findings/$SLUG/milestone-latest.json

# Latest checkpoint on L1 (hard finality)
curl -s http://$(kurtosis port print $ENCLAVE l2-cl-0-heimdall-v2-bor-validator http)/checkpoints/latest | tee findings/$SLUG/checkpoint-latest.json

# Heimdall node status (all validators)
for n in $(seq 0 $((N_VALIDATORS - 1))); do
  kurtosis service exec $ENCLAVE l2-cl-$n-heimdall-v2-bor-validator -- heimdalld status > findings/$SLUG/heimdall-status-$n.json
done

# RabbitMQ logs (relevant for state sync and coordination scenarios)
for n in $(seq 0 $((N_VALIDATORS - 1))); do
  kurtosis service logs $ENCLAVE l2-cl-$n-rabbitmq > findings/$SLUG/rabbitmq-$n.log
done

# L1 logs (relevant for checkpoint submission and bridge deposit scenarios)
kurtosis service logs $ENCLAVE el-1-geth-lighthouse > findings/$SLUG/l1-el.log
kurtosis service logs $ENCLAVE cl-1-lighthouse-geth > findings/$SLUG/l1-cl.log
```

---

## Bug report format

One file per finding at `findings/<YYYY-MM-DD>-<slug>.md` (repo root):

```markdown
# [BOR|HEIMDALL] Short title

## Summary
One paragraph describing the issue and why it matters.

## Environment
- Bor image: `0xpolygon/bor:X.Y.Z`  ← get from `src/config/constants.star` key `l2_el_bor_image`
- Heimdall-v2 image: `0xpolygon/heimdall-v2:X.Y.Z`  ← get from `src/config/constants.star` key `l2_cl_heimdall_v2_image`
- Config: `<args-file used>`
- Enclave: `<enclave name>`

## Steps to reproduce
1. Deploy devnet: `kurtosis run --enclave <name> --args-file .github/configs/heimdall-v2-bor.yml .`
2. ...

## POC

    ```bash
    # Minimal commands to reproduce
    ```

## Expected behavior
...

## Actual behavior
...

## Evidence
- Attach or inline relevant log snippets
- Include block numbers, tx hashes, timestamps
```

---

## Parallel agent guidance

### Local (current)

Docker and Kurtosis have resource limits. The default config (`heimdall-v2-bor.yml`) deploys 2 validators + 2 RPCs and uses ~6–8 GB RAM. Full deploys take ~10–15 min, so true parallelism is limited — stagger agent starts or run sequentially.

- **Recommended concurrency**: 2–3 enclaves on a dev machine
- Monitor resource usage: `docker stats`

```bash
for i in $(seq 1 3); do
  (
    ENCLAVE="pos-agent-$i"
    kurtosis run --enclave $ENCLAVE --args-file .github/configs/heimdall-v2-bor.yml .
    .github/actions/monitor/blocks-bor.sh $ENCLAVE first
    # ... probe, observe, document ...
    kurtosis enclave rm --force $ENCLAVE
  ) &
done
wait
```

### Scale-up path (once snapshots are fixed)

- **CI**: run agents as parallel GitHub Actions jobs, each restoring from a snapshot Docker image (~20s startup)
- **Cloud**: spin up VMs per agent, pull snapshot image, run, push findings to shared storage

With snapshots, hundreds of agents become practical. Until then, parallelism is constrained by deploy time and local resources.
