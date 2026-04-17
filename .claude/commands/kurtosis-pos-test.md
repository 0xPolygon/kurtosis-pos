---
name: kurtosis-pos-test
description: Test a Polygon PoS devnet. Covers unit tests (kurtosis-test), e2e bats tests (plasma-bridge and validator flows), bridge operations, and chaos testing (spammers, SIGTRAP, service restarts).
allowed-tools: Bash, Read, Glob, Grep
compatibility: Requires a running kurtosis-pos enclave for e2e and chaos tests.
---

## Related skills

- **kurtosis-pos-deploy** — deploy a devnet before running e2e or chaos tests
- **kurtosis-pos-interact** — monitor scripts, chain interaction
- **kurtosis-pos-intro** — kurtosis-test install, dev workflow

---

## Unit tests

Unit tests live in `*_test.star` files co-located with the module under test (e.g. `src/config/input_parser_test.star`). They test config parsing and validation — no enclave needed.

```bash
# Install kurtosis-test (requires Go 1.23+)
git clone --branch v0.0.6 https://github.com/ethereum-optimism/kurtosis-test.git /tmp/kurtosis-test
cd /tmp/kurtosis-test && go build -o kurtosis-test cli/main.go
sudo cp kurtosis-test /usr/local/bin

# Run all unit tests from the repo root
kurtosis-test .
```

---

## E2e tests (bats)

E2e tests live in the external `agglayer/e2e` repo. They require a running devnet. The CI action clones it to `agglayer-e2e/` using a pinned commit (see `.github/actions/test-state-sync/action.yml`).

```bash
# Clone the e2e repo locally (match the pinned commit from the action)
git clone https://github.com/agglayer/e2e agglayer-e2e
cd agglayer-e2e
```

### Plasma bridge tests

Each test in `plasma-bridge.bats` is independently safe — it snapshots balances before acting and asserts relative changes. Running all at once consumes funds and takes too long.

**Exception**: test 9 (withdraw ERC721) requires an ERC721 token on L2. Run test 8 first, or pre-seed.

```bash
bats --filter "bridge POL from L1 to L2"           tests/pos/plasma-bridge.bats
bats --filter "bridge MATIC from L1 to L2"         tests/pos/plasma-bridge.bats
bats --filter "withdraw native tokens from L2"     tests/pos/plasma-bridge.bats
bats --filter "bridge ETH from L1 to L2"           tests/pos/plasma-bridge.bats
bats --filter "withdraw MaticWeth from L2"         tests/pos/plasma-bridge.bats
bats --filter "bridge ERC20 tokens from L1 to L2"  tests/pos/plasma-bridge.bats
bats --filter "withdraw ERC20 tokens from L2"      tests/pos/plasma-bridge.bats
bats --filter "bridge ERC721 token from L1 to L2"  tests/pos/plasma-bridge.bats  # run before ERC721 withdraw
bats --filter "withdraw ERC721 token from L2"      tests/pos/plasma-bridge.bats  # requires ERC721 on L2
```

### Validator tests (strictly ordered — test 8 is DESTRUCTIVE)

**Never run `validator.bats` in full in a random order** — test 8 removes the genesis validator from consensus, permanently degrading the devnet.

| #   | Test                          | Safety                                                          |
| --- | ----------------------------- | --------------------------------------------------------------- |
| 1   | `add new validator`           | Safe — uses a fresh generated keypair                           |
| 2   | `update validator stake`      | Safe — increases validator 1 stake                              |
| 3   | `update validator top-up fee` | Safe                                                            |
| 4   | `update signer`               | Permanent signer change on validator 1                          |
| 5   | `delegate to a validator`     | Safe — must run before test 6                                   |
| 6   | `undelegate from a validator` | Requires test 5 to have run first                               |
| 7   | `withdraw validator rewards`  | Safe                                                            |
| 8   | `remove validator`            | **DESTRUCTIVE** — removes genesis validator 1. Always run last. |

```bash
# Run individual safe tests
bats --filter "add new validator"          tests/pos/validator.bats
bats --filter "update validator stake"     tests/pos/validator.bats
bats --filter "withdraw validator rewards" tests/pos/validator.bats

# Delegation pair — must run in order
bats --filter "delegate to a validator"     tests/pos/validator.bats
bats --filter "undelegate from a validator" tests/pos/validator.bats

# Full run — only in file order (1→8); test 8 is always last
bats tests/pos/validator.bats
```

---

## State-sync test

A dedicated GitHub Actions action tests state sync end-to-end (`.github/actions/test-state-sync/action.yml`). It clones `agglayer/e2e`, runs the bridge POL test, and confirms the native token balance increased on L2.

```bash
# Run manually against a local enclave
L1_RPC=$(kurtosis port print pos el-1-geth-lighthouse rpc)
cd agglayer-e2e
bats --filter "bridge POL from L1 to L2" tests/pos/plasma-bridge.bats
```

---

## Bridge workflow (Plasma bridge)

Requires a devnet with contracts deployed. The admin private key is `0xd40311b5a5ca5eaeb48dfba5403bde4993ece8eccf4190e98e19fcd4754260ea`.

```bash
L1_RPC=$(kurtosis port print pos el-1-geth-lighthouse rpc)
L2_RPC=$(kurtosis port print pos l2-el-0-bor-heimdall-v2-validator rpc)

# Bridge ETH from L1 to L2
cast send \
  --private-key $PRIVATE_KEY \
  --rpc-url $L1_RPC \
  <bridge_contract> \
  "depositEther(address,uint256,bool)" \
  <recipient> 1000000000000000000 false \
  --value 1ether

# Monitor L2 for the deposit arriving (bridge delivers after next checkpoint)
cast balance <recipient> --rpc-url $L2_RPC

# State sync test — trigger a state sync event and verify it appears on L2
#   (via Heimdall REST API /clerk/event-record/list)
```

---

## Chaos testing

### Transaction and bridge load

```yaml
# Enable load generators in config
polygon_pos_package:
  additional_services:
    - tx_spammer       # runs polycli loadtest against the L2 RPC
    - bridge_spammer   # sends L1→L2 bridge transactions continuously
```

`tx_spammer` invokes `polycli loadtest` under the hood (`static_files/additional_services/tx-spammer/loadtest.sh`). The load parameters (rate, duration, contract type) are hardcoded in that script and not configurable via YAML.

### Stop a node without killing its container (SIGTRAP)

The `container-proc-manager.sh` wrapper traps `kill -5` (SIGTRAP) to stop the node process while keeping the container alive for debugging or restart testing.

```bash
# Get the PID of the main process inside the container
kurtosis service shell pos l2-el-0-bor-heimdall-v2-validator
# Inside the container:
ps aux | grep bor

# From outside — send SIGTRAP to stop bor without killing the container
docker exec <container_id> kill -5 <bor_pid>

# Restart the node by re-starting the container process
kurtosis service start pos l2-el-0-bor-heimdall-v2-validator
```

### Stop and start a service

```bash
# Stop a service (container stays registered; useful for testing peer recovery)
kurtosis service stop pos l2-el-0-bor-heimdall-v2-validator

# Start it back
kurtosis service start pos l2-el-0-bor-heimdall-v2-validator

# Verify recovery by watching block production
.github/actions/monitor/blocks-bor.sh pos all
```

### Hot-swap image (test a different build)

```bash
kurtosis service update --image 0xpolygon/bor:my-branch pos l2-el-0-bor-heimdall-v2-validator
```
