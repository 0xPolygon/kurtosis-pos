# CI perf monitoring

Per-phase wall-clock measurements emitted by `deploy.yaml` and `snapshot.yaml`,
fanned in by `perf-report.yaml` to compare against the last 10 successful main
runs and post a sticky comment on the PR.

## Coverage

Perf phases are emitted only by jobs that exercise representative code
paths. Each added job multiplies the rows in the PR comment and contributes
runner-variance to the rolling baseline, so this list is intentionally
small:

| Workflow   | Jobs                                                                          |
| ---------- | ----------------------------------------------------------------------------- |
| `deploy`   | `run-without-args`, `heimdall-v2-bor`, `heimdall-v2-mix`, `l1-backends-anvil` |
| `snapshot` | `small`, `large`                                                              |

To add a job, append its config name to `PERF_CONFIGS` in `deploy.yaml`'s
`run-with-args` matrix (or wire `perf/collect` into a new workflow).

## Phases

| Phase                 | Where measured       | Notes                                                                                    |
| --------------------- | -------------------- | ---------------------------------------------------------------------------------------- |
| `deploy`              | `kurtosis run` step  | Wall-clock around the whole `kurtosis run`.                                              |
| `snapshot-build`      | `snapshot.yaml` only | `scripts/snapshot/snapshot.sh`.                                                          |
| `snapshot-image-size` | `snapshot.yaml` only | `docker image inspect pos-devnet --format '{{.Size}}'`. Not a duration; reported in MiB. |
| `restore`             | `snapshot.yaml` only | `scripts/snapshot/restore.sh`.                                                           |

The existing devnet-monitor probes (`bor`, `heimdall`, `spans`,
`milestones`, `checkpoints`) cover correctness of chain bring-up. A
separate "time-to-block-N" perf metric would mostly duplicate that signal
without adding anything the `deploy` wall-clock doesn't already capture,
so it's intentionally absent.

## Artifact schema

Each job uploads a single `perf-<job>.json`:

```json
{
  "schema": "kurtosis-pos.perf.v1",
  "metadata": {
    "job": "snapshot-small",
    "flavour": "small",
    "workflow": "snapshot",
    "run_id": "12345",
    "sha": "deadbeef…",
    "runner": {"os": "Linux", "arch": "X64", "name": "GitHub Actions 3"},
    "…": "…"
  },
  "phases": [
    {
      "phase": "deploy",
      "started_at": "2026-05-22T08:00:01Z",
      "ended_at":   "2026-05-22T08:00:43Z",
      "duration_s": 42.512,
      "extras": {"flavour": "small"}
    }
  ]
}
```

- `duration_s == 0` indicates a non-timing metric; the relevant value lives
  in `extras` (e.g. `bytes` for image size).
- `extras.bytes`, `extras.size_bytes`, `extras.block_height`, `extras.blocks`
  are coerced to numbers by `aggregate.sh`; everything else stays a string.

## Components

```text
scripts/perf/
├── measure.sh         # start <phase> / end <phase> / emit <phase> --extra k=v
├── aggregate.sh       # roll tmp/perf/results.jsonl + env metadata into perf-<job>.json
├── report.py          # render Markdown table (current vs baseline)
└── README.md          # this file

.github/actions/perf/collect/   # composite: aggregate + upload artifact
.github/actions/monitor/        # extended with target_block / emit_timing_path
.github/workflows/perf-report.yaml  # fan-in workflow, posts the PR comment
```

## Adding a new phase

1. In the workflow step that runs the work, call
   `./scripts/perf/measure.sh start <phase-name>` before the command and
   `./scripts/perf/measure.sh end <phase-name> --extra <k>=<v>` after.
   `--extra` pairs go into the `extras` object and surface in the report.
2. For non-timing metrics (sizes, counts), use `emit` instead of
   `start/end`, e.g.
   `./scripts/perf/measure.sh emit snapshot-image-size --extra bytes=$size`.
3. If the phase's extras include a numeric value the report should show,
   add the key to `NUMERIC_EXTRA_KEYS` in `report.py`.

## Baseline semantics

`perf-report.yaml` lists the last 10 successful main-branch runs of the
upstream workflow (`deploy` or `snapshot`), excluding the triggering run.
For each `(job, phase)` pair, the report shows:

- **Current**: this run's value.
- **Baseline**: `min / avg / max` across the baselines.
- **Δ vs avg**: percentage delta from the baseline average. Flagged 🔺 above
  +10%, 🟢 below −10%.
- **Samples**: how many baselines actually contributed a value.

Sample count is shown so a new phase or a fresh repo (few main runs) is
visibly under-baselined rather than silently noisy.

## Why not Datadog?

The artifact-based path is self-contained: no secret rotation, no API key,
PR feedback lives in GitHub. If we later want long-term trend graphs, the
artifacts can be tee'd to Datadog without changing the producer side.
