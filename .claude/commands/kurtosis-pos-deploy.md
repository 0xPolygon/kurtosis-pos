---
name: kurtosis-pos-deploy
description: Deploy and configure Polygon PoS devnets with Kurtosis. Covers kurtosis run (local and published), L1 backends, config options, partial redeploy, hot-swap images, and snapshot restore.
allowed-tools: Bash, Read, Glob, Grep
compatibility: Requires kurtosis CLI with a running engine.
---

## Related skills

- **kurtosis-pos-intro** — prerequisites, repo map, dev workflow
- **kurtosis-pos-interact** — inspect services, monitoring, observability
- **kurtosis-pos-test** — unit tests, e2e tests, bridge flows, chaos

---

## Quick start

```bash
# From the published package (no local checkout needed)
kurtosis run --enclave pos github.com/0xPolygon/kurtosis-pos

# From a local checkout (picks up uncommitted changes)
kurtosis run --enclave pos .

# With a config file
kurtosis run --enclave pos --args-file .github/configs/heimdall-v2-bor.yml .

# Fastest: anvil L1 backend (~3–4 min)
kurtosis run --enclave pos --args-file .github/configs/l1-backends/anvil.yml .

# Fastest of all: restore from snapshot (~20 sec)
./scripts/snapshot/extract.sh <docker-image>
./scripts/snapshot/restore.sh [snapshot_folder]

# Tear down
kurtosis enclave rm --force pos
```

---

## Config structure

Only specify fields that differ from defaults — the minimal config is just `polygon_pos_package.participants`.

```yaml
dev:
  l1_backend: ethereum-package    # "anvil" (fast/lightweight) or "ethereum-package" (full)
  should_deploy_l1: true          # false = reuse existing L1 (partial redeploy)
  should_deploy_matic_contracts: true  # false = skip contract redeployment
  # Required when should_deploy_l1: false
  l1_rpc_url: http://el-1-geth-lighthouse:8545
  # Required when should_deploy_matic_contracts: false
  l2_el_genesis_filepath: .github/configs/nightly/cl-el-genesis/l2-el-genesis.json
  l2_cl_genesis_filepath: .github/configs/nightly/cl-el-genesis/l2-cl-genesis.json
  matic_contract_addresses_filepath: .github/configs/nightly/cl-el-genesis/matic-contract-addresses.json

polygon_pos_package:
  log_level: info                 # error | warn | info | debug | trace
  log_format: text                # text | json
  participants:
    - kind: validator             # validator | rpc | archive
      el_type: bor                # bor | erigon
      cl_type: heimdall-v2        # only option currently
      el_image: 0xpolygon/bor:2.7.1
      cl_image: 0xpolygon/heimdall-v2:0.6.0
      count: 1
  additional_services:
    - observability               # prometheus + grafana + panoptichain
    - bridge_spammer              # L1→L2 bridge load generator
    - tx_spammer                  # L2 transaction load generator (uses polycli loadtest)
    - status_checker              # network health monitor
    - ethstats_server             # ethstats dashboard
    # blockscout is defined in constants but not yet available as a working service
```

### Key defaults

| Parameter | Value |
|---|---|
| L1 chain ID | `3151908` |
| L2 EL chain ID | `4927` |
| L2 CL chain ID | `heimdall-4927` |
| Bor image | `0xpolygon/bor:2.7.1` |
| Heimdall-v2 image | `0xpolygon/heimdall-v2:0.6.0` |
| Sprint duration | 16 blocks |
| Rio HF activation | block 256 |
| Admin address | `0x74Ed6F462Ef4638dc10FFb05af285e8976Fb8DC9` |
| Admin private key | `0xd40311b5a5ca5eaeb48dfba5403bde4993ece8eccf4190e98e19fcd4754260ea` |

All image tags and chain constants: `src/config/constants.star`.
Pre-funded accounts: `src/prefunded_accounts/accounts.star`.

---

## Ready-made configs (`.github/configs/`)

| File | Setup |
|---|---|
| `heimdall-v2-bor.yml` | 2 validators + 2 bor RPCs |
| `heimdall-v2-mix.yml` | 2 validators + 2 erigon RPCs |
| `all.yml` | 1 validator + 1 bor RPC (different chain IDs) |
| `additional-services.yml` | All optional services enabled |
| `l1-backends/anvil.yml` | Lightweight Anvil L1 |
| `l1-backends/ethereum-package.yml` | Full ethereum-package L1 |

Files with a `.norun` suffix (e.g. `large.yml.norun`) are valid configs excluded from the CI matrix — too large for regular PRs but usable via `workflow_dispatch`.

**Nightly-only configs** live under `.github/configs/nightly/` and are only included in the CI matrix on scheduled runs and `workflow_dispatch` — not on PR merges:

| Config | Purpose |
|---|---|
| `nightly/external-l1/polygon-pos-with-external-l1.yml` | Connect to an already-running L1 via `l1_rpc_url` |
| `nightly/cl-el-genesis/polygon-pos-with-cl-el-genesis.yml` | Supply pre-built genesis files and contract addresses |
| `nightly/additional-services/` | One config per optional service for isolated testing |

---

## Service naming (0-indexed)

| Role | Service name |
|---|---|
| L2 EL validator (bor) | `l2-el-<n>-bor-heimdall-v2-validator` |
| L2 CL validator | `l2-cl-<n>-heimdall-v2-bor-validator` |
| L2 EL RPC (bor) | `l2-el-<n>-bor-heimdall-v2-rpc` |
| L2 CL RPC | `l2-cl-<n>-heimdall-v2-bor-rpc` |
| L2 EL archive (bor) | `l2-el-<n>-bor-heimdall-v2-archive` |
| RabbitMQ (per-node) | `l2-cl-<n>-rabbitmq` |
| L1 EL (geth) | `el-1-geth-lighthouse` |
| L1 CL (lighthouse) | `cl-1-lighthouse-geth` |
| Observability | `prometheus`, `grafana`, `panoptichain` |
| Extras | `status-checker`, `bridge-spammer`, `tx-spammer` |

---

## Partial redeploy (L2 only)

Reuse a running L1 to iterate on L2 changes faster — skips L1 startup and contract deployment (~10 min saved).

```yaml
dev:
  should_deploy_l1: false
  should_deploy_matic_contracts: false
polygon_pos_package:
  participants:
    - kind: validator
      el_type: bor
      el_image: 0xpolygon/bor:my-branch    # override image
      cl_type: heimdall-v2
      count: 1
```

The original enclave must still be running before re-deploying with `should_deploy_l1: false`.

---

## Hot-swap a service image (no redeploy)

```bash
# Update the image of a running service without tearing down the enclave
kurtosis service update --image 0xpolygon/bor:my-branch pos l2-el-0-bor-heimdall-v2-validator
```

---

## Snapshots

```bash
# Take a snapshot of a running enclave
./scripts/snapshot/snapshot.sh [enclave_name]

# Restore from a snapshot folder
./scripts/snapshot/restore.sh [snapshot_folder]

# Extract snapshot data from a published Docker image (then restore)
./scripts/snapshot/extract.sh <docker-image>
./scripts/snapshot/restore.sh [snapshot_folder]
```

Snapshots are Docker-compose based (not `kurtosis run`) and restore in ~20 seconds.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| Deploy hangs at L1 startup | `ethereum-package` slow to finalize | Switch to `l1_backend: anvil` |
| Service not found | Typo in service name | Run `kurtosis enclave inspect pos` to see exact names |
| Bor not producing blocks | Rio HF not reached yet | Wait for block 256; use monitor scripts |
| Contract deploy fails | Admin account not funded | Ensure `should_deploy_l1: true` and L1 completed first |
| Image not found | Local image tag mismatch | Set `--image-download always` or push image first |
| Port conflict | Another enclave running | Run `kurtosis enclave ls` and remove stale enclaves |
| Partial redeploy fails | L1 services stopped | Ensure original enclave is still running |
