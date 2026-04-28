---
name: kurtosis-pos-intro
description: Onboarding guide for kurtosis-pos contributors. Use when setting up the dev environment, exploring the repo layout, or understanding common starting points and the PR checklist.
allowed-tools: Bash, Read, Glob, Grep
compatibility: Requires kurtosis CLI with a running engine and Go 1.23+.
---

## Related skills

- **kurtosis-pos-deploy** — deploy and configure enclaves
- **kurtosis-pos-interact** — inspect services, read chain state, run monitors
- **kurtosis-pos-test** — unit tests, bats e2e tests, bridge and chaos flows
- **kurtosis-pos-quality** — CI checks, formatting, typos, docs, publish-images
- **kurtosis-starlark** — Starlark coding rules for .star files

---

## Prerequisites

| Tool             | Purpose                             | Install                                                           |
| ---------------- | ----------------------------------- | ----------------------------------------------------------------- |
| `kurtosis`       | Run and manage enclaves             | [docs.kurtosis.com/install](https://docs.kurtosis.com/install)    |
| `docker`         | Container runtime                   | [docs.docker.com/get-docker](https://docs.docker.com/get-docker/) |
| `go` 1.23+       | Build `kurtosis-test`               | `brew install go`                                                 |
| `kurtosis-test`  | Run `*_test.star` unit tests        | see install below                                                 |
| `cast` (Foundry) | Send transactions, read chain state | `curl -L https://foundry.paradigm.xyz \| bash`                    |
| `typos-cli`      | Check for typos                     | `cargo install typos-cli`                                         |
| `rumdl`          | Lint markdown                       | `cargo install rumdl`                                             |

```bash
# Install kurtosis-test (requires Go 1.23+)
git clone --branch v0.0.6 https://github.com/ethereum-optimism/kurtosis-test.git /tmp/kurtosis-test
cd /tmp/kurtosis-test && go build -o kurtosis-test cli/main.go
sudo cp kurtosis-test /usr/local/bin

# Start the Kurtosis engine — required before any kurtosis run, once per session
kurtosis engine start
```

---

## Repo map

```text
main.star                        # Entry point — start here to trace any deployment flow
src/
  config/
    constants.star               # All image tags, chain IDs, enums — edit when bumping images
    input_parser.star            # All config defaults and parsing — edit when adding params
    sanity_check.star            # Validation — edit alongside input_parser.star
  l1/                            # L1 launchers (anvil, ethereum-package)
  contracts/                     # MATIC contract deployment (L1 + L2)
  cl/                            # Consensus layer: Heimdall-v2
  el/                            # Execution layer: Bor, Erigon
  el_cl_launcher.star            # Launches all L2 participants — edit when changing node startup
  additional_services/           # Optional services (observability, spammers, etc.)
  wait/wait.star                 # Polling helpers for startup conditions
  prefunded_accounts/accounts.star  # 1500 pre-generated funded validator accounts
  account/account.star           # Account struct constructors
  wallet/wallet.star             # cast wrappers (fund, send, derive address)
  hex/hex.star                   # Hex utilities (no hex() builtin in Starlark)
  math/math.star                 # Math utilities (no ** or sum() in Starlark)
static_files/                    # Templates, genesis configs, CL validator keys
  scripts/container-proc-manager.sh  # Process wrapper for graceful node shutdown
docker/                          # Dockerfiles for the three setup images
scripts/snapshot/                # Snapshot / restore devnets
docs/                            # Docusaurus documentation site
.github/
  configs/                       # Ready-made YAML args files for CI and manual runs
  actions/monitor/               # Health-check scripts (blocks, checkpoints, milestones, spans)
  workflows/                     # CI: checks, deploy, stability, snapshot, publish-images
```

---

## Common starting points

| Task                       | Files to touch                                                                                                      |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| Add a new config parameter | `input_parser.star` (default + parsing) → `sanity_check.star` (validation) → `docs/docs/configuration/reference.md` |
| Add a new optional service | `additional_services/<name>.star` → `additional_services/launcher.star` → `constants.star` (`ADDITIONAL_SERVICES`)  |
| Change a client image tag  | `constants.star` (`IMAGES`) → `publish-images.yaml` (if it's a setup image)                                         |
| Add a new EL/CL client     | `src/el/<client>/launcher.star` + `context.star` → `el/launcher.star` (`LAUNCHERS` dict + `EL_TYPE` enum)           |
| Add a new hard fork        | `constants.star` (`EL_HARD_FORK_BLOCKS`) → `input_parser.star` → `sanity_check.star`                                |
| Update docs                | `docs/docs/configuration/reference.md` (params), `docs/docs/guides/` (workflows)                                    |

---

## Dev workflow

```bash
# 1. Format and lint Starlark
kurtosis lint --format .
kurtosis lint .
kurtosis lint -c .            # validate run() docstring

# 2. Check for typos
typos .

# 3. Lint markdown
rumdl .

# 4. Run unit tests
kurtosis-test .

# 5. Deploy and verify devnet health
kurtosis run --enclave pos .
kurtosis enclave inspect pos
.github/actions/monitor/blocks-bor.sh pos first       # EL blocks progressing
.github/actions/monitor/blocks-heimdall.sh pos        # CL blocks progressing
.github/actions/monitor/spans.sh pos                  # span production
.github/actions/monitor/milestones.sh pos             # milestone production
.github/actions/monitor/checkpoints.sh pos            # checkpoint committed

# 6. Tear down
kurtosis enclave rm --force pos
```

---

## Debugging a failed deploy

```bash
# See all services and their status (look for STOPPED)
kurtosis enclave inspect pos

# Stream logs from a specific service
kurtosis service logs pos l2-el-0-bor-heimdall-v2-validator --follow

# Shell into a running container
kurtosis service shell pos l2-el-0-bor-heimdall-v2-validator

# Dump all logs and artifacts to disk
kurtosis enclave dump pos ./enclave-dump
```

---

## PR checklist

- [ ] `kurtosis lint --format .` — no formatting changes left uncommitted
- [ ] `kurtosis lint .` — no lint errors
- [ ] `kurtosis lint -c .` — `run()` docstring valid
- [ ] `typos .` — no typos
- [ ] `rumdl .` — no markdown warnings
- [ ] `kurtosis-test .` — all unit tests pass
- [ ] Deployed locally and all monitor scripts passed
- [ ] Docs updated in the same PR if params, services, or workflows changed
