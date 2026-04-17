---
name: kurtosis-pos-quality
description: Quality and CI for kurtosis-pos. Covers CI workflows (checks, deploy, stability, snapshot, publish-images), Starlark formatting, typos, markdown linting, documentation sync, and Docker image publishing.
allowed-tools: Bash, Read, Glob, Grep
compatibility: Requires kurtosis CLI 1.15.2+, cargo (typos-cli, rumdl), and gh CLI for workflow dispatch.
---

## Related skills

- **kurtosis-pos-intro** — PR checklist, dev workflow
- **kurtosis-starlark** — Starlark coding rules (fmt-, typos-, docs-, docker- rules)

---

## CI workflows

| Workflow | Trigger | What it does |
|---|---|---|
| `checks.yaml` | PR / push to main | Lint (kurtosis + rumdl), typos, unit tests. Pins `KURTOSIS_VERSION: 1.15.2`. |
| `deploy.yaml` | PR / push / daily | Deploys configs in `.github/configs/` (excludes `.norun`). On schedule/`workflow_dispatch` only, also runs `nightly/` configs. PR merges skip nightly configs. |
| `stability.yaml` | Daily / `workflow_dispatch` | 30 parallel deploys per config; measures failure rate |
| `snapshot.yaml` | `workflow_dispatch` | Deploys a devnet, takes a snapshot, publishes it as a Docker image |
| `publish-images.yaml` | `workflow_dispatch` | Builds and pushes the three setup Docker images |
| `docs.yaml` | PR / push to main | Builds the Docusaurus site; fails on broken links |

---

## Starlark formatting and lint

```bash
# Auto-format all .star files in place (run locally before committing)
kurtosis lint --format .

# Lint without auto-format (same check as CI — fails on unformatted files)
kurtosis lint .

# Validate the run() docstring in main.star
kurtosis lint -c .
```

CI runs `kurtosis lint .` (no `--format`); it fails if any file is unformatted. Always run `kurtosis lint --format .` locally first.

---

## Typos

```bash
# Install
cargo install typos-cli

# Check (same as CI)
typos .

# Fix automatically
typos --write-changes .
```

Runs on every PR and push to `main`. Fix all typos before opening a PR — the check is fast (<5 s) and blocks merge.

### Ignoring legitimate false positives

Use `typos.toml` with `extend-ignore-re` — never suppress whole files or disable the check.

```toml
# typos.toml
[default]
extend-ignore-re = [
  "\".*=\",",  # base64 CometBFT private keys (e.g. "abc123=",)
]
```

---

## Markdown linting

```bash
# Install rumdl
cargo install rumdl

# Run locally (same rules as CI)
rumdl .
```

CI uses the `rvben/rumdl` GitHub Action. Fix all warnings before opening a PR — `rumdl` is strict about heading levels, trailing spaces, and blank lines around fenced code blocks.

---

## Documentation (Docusaurus)

The docs site lives in `docs/`. It must stay in sync with code changes.

```bash
cd docs
npm run build   # build — catches broken links and MDX errors
npm run serve   # preview at http://localhost:3000
```

### What to update and when

| Code change | Doc file to update |
|---|---|
| New or renamed config param | `docs/docs/configuration/reference.md` |
| New or renamed service / port | `docs/docs/introduction/` + `docs/docs/guides/interact-with-the-devnet.md` |
| New additional service | `docs/docs/guides/` |
| New script or changed script interface | Relevant guide under `docs/docs/guides/` |
| Hard fork block change | Any guide that references activation blocks |

Always update docs **in the same PR** as the code change — never in a follow-up.

### Sidebar ordering

```markdown
---
sidebar_position: 2
---
```

Category order and landing pages are defined in `_category_.json`:

```json
{
  "position": 3,
  "link": { "type": "generated-index" }
}
```

---

## Docker images (setup images)

Three images are maintained in this repo and hosted on `ghcr.io/0xPolygon/`:

| Image | Dockerfile | Purpose |
|---|---|---|
| `ghcr.io/0xpolygon/pos-contract-deployer:<sha>` | `docker/pos-contract-deployer.Dockerfile` | Deploy MATIC contracts to L1 and L2 |
| `ghcr.io/0xpolygon/pos-el-genesis-builder:<sha>` | `docker/pos-el-genesis-builder.Dockerfile` | Generate EL genesis |
| `ghcr.io/0xpolygon/pos-validator-config-generator:<ver>` | `docker/pos-validator-config-generator.Dockerfile` | Generate CL validator config |

Built manually via `workflow_dispatch` — not on every push.

### Build and publish

```bash
# Build a specific image
gh workflow run publish-images.yaml --field image=pos-contract-deployer

# Build all three
gh workflow run publish-images.yaml --field image=all
```

Images are tagged with upstream commit SHA or version string — never `latest`. Platforms: `linux/amd64` and `linux/arm64`.

### Bumping a setup image tag

1. Update the tag in `constants.star` (`IMAGES` dict)
2. Update the corresponding env var in `publish-images.yaml` (`POS_CONTRACTS_COMMIT_SHA`, `GENESIS_CONTRACTS_COMMIT_SHA`, or `HEIMDALL_V2_VERSION`)
3. Trigger `publish-images.yaml` to build and push the new image

### Excluding configs from the CI matrix

Suffix a config file with `.norun` to keep it valid but skip it in `deploy.yaml`:

```
.github/configs/large.yml.norun   ← valid YAML, excluded from CI matrix
```

Use this for configs that are too large or slow for regular PR CI (e.g., the 7-validator snapshot base).

---

## Stability workflow

The `stability.yaml` workflow runs 30 parallel deploys per config daily and measures the startup failure rate. To trigger manually:

```bash
gh workflow run stability.yaml
```

Results are posted as a GitHub job summary and as a Slack alert. The goal is a consistent failure rate near 0%; if failures increase, investigate recent changes to L1 startup timing or contract deployment.
