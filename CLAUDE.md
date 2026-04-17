# kurtosis-pos

Kurtosis package for Polygon PoS devnets. Source: `main.star`. Docs: `docs/`.

## Quick start

```bash
kurtosis engine start
kurtosis run --enclave pos .                                    # deploy from local checkout
kurtosis run --enclave pos --args-file .github/configs/heimdall-v2-bor.yml .  # 2 validators + 2 RPCs
kurtosis enclave inspect pos                                    # list all services and ports
kurtosis enclave rm --force pos                                 # tear down
```

## Dev loop

```bash
kurtosis lint --format . && kurtosis lint . && kurtosis lint -c .  # format + lint
typos .                                                            # check typos
rumdl .                                                            # lint markdown
kurtosis-test .                                                    # unit tests
kurtosis run --enclave pos .                                       # deploy
.github/actions/monitor/blocks-bor.sh pos first                   # verify EL blocks
.github/actions/monitor/checkpoints.sh pos                        # verify checkpoints
```

## Service naming (0-indexed)

| Role                  | Service name                            |
| --------------------- | --------------------------------------- |
| L2 EL validator (bor) | `l2-el-<n>-bor-heimdall-v2-validator`   |
| L2 CL validator       | `l2-cl-<n>-heimdall-v2-bor-validator`   |
| L2 EL RPC (bor)       | `l2-el-<n>-bor-heimdall-v2-rpc`         |
| L2 CL RPC             | `l2-cl-<n>-heimdall-v2-bor-rpc`         |
| L1 EL (geth)          | `el-1-geth-lighthouse`                  |
| L1 CL (lighthouse)    | `cl-1-lighthouse-geth`                  |
| Observability         | `prometheus`, `grafana`, `panoptichain` |

## Quick reference

|                               |                                                                      |
| ----------------------------- | -------------------------------------------------------------------- |
| L1 chain ID                   | `3151908`                                                            |
| L2 EL chain ID                | `4927`                                                               |
| L2 CL chain ID                | `heimdall-4927`                                                      |
| Bor image                     | `0xpolygon/bor:2.7.1`                                                |
| Heimdall-v2 image             | `0xpolygon/heimdall-v2:0.6.0`                                        |
| Sprint duration               | 16 blocks                                                            |
| Rio hard fork                 | block 256 (required by Heimdall-v2)                                  |
| Admin address                 | `0x74Ed6F462Ef4638dc10FFb05af285e8976Fb8DC9`                         |
| Admin private key (L1 and L2) | `0xd40311b5a5ca5eaeb48dfba5403bde4993ece8eccf4190e98e19fcd4754260ea` |

All image tags and chain constants: `src/config/constants.star`.
All config defaults and params: `src/config/input_parser.star`.
Pre-funded accounts: `src/prefunded_accounts/accounts.star`.

## Key files

| Task                      | File                                                                                                     |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| Add/change a config param | `src/config/input_parser.star` → `src/config/sanity_check.star` → `docs/docs/configuration/reference.md` |
| Bump an image tag         | `src/config/constants.star` → `publish-images.yaml` (setup images only)                                  |
| Add an optional service   | `src/additional_services/<name>.star` → `src/additional_services/launcher.star`                          |
| Change node startup       | `src/el_cl_launcher.star`                                                                                |

## Skills

Type `/kurtosis-pos` for the full index. Quick links:

- `/kurtosis-pos-intro` — setup, repo map, dev workflow, PR checklist
- `/kurtosis-pos-deploy` — `kurtosis run`, configs, snapshots
- `/kurtosis-pos-interact` — inspect services, monitor health, read chain state
- `/kurtosis-pos-test` — unit tests, e2e bats tests, bridge flows, chaos
- `/kurtosis-pos-quality` — CI, formatting, typos, docs, publish-images
- `/kurtosis-starlark` — writing or reviewing `.star` files
- `/kurtosis-pos-investigate` — autonomous bug finding in bor and heimdall-v2
