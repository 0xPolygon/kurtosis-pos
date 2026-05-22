#!/usr/bin/env python3
"""Render a Markdown perf-comparison table.

Inputs:
  --current DIR    directory containing perf-*.json artifacts from the current run
  --baseline DIR   directory containing baselines/<run_id>/perf-*.json
  --output FILE    where to write the Markdown report

Baseline contract:
  baselines are flat per-run directories produced by perf-report.yaml when it
  fetches the last 10 successful main-branch runs of the upstream workflow.
  Each baseline run contributes a set of perf-<job>.json files.

Comparison semantics:
  for each (job, phase) pair seen in the current run, compute baseline
  min/avg/max and sample count across whatever baselines have a matching
  record. Phases not present in baselines (e.g. a newly added phase) report
  "n/a" with sample count 0 — they're still listed.

Numeric extras:
  for non-timing phases (duration_s == 0), the table shows the first known
  numeric extra (e.g. "bytes" for snapshot-image-size) instead of a duration.
"""

from __future__ import annotations

import argparse
import json
import sys
from dataclasses import dataclass, field
from pathlib import Path

# Known numeric extras and their display unit. Order matters: the first key
# present in a phase's extras is the one shown in the table.
NUMERIC_EXTRA_KEYS = [
    ("bytes", "MiB", lambda v: v / (1024 * 1024)),
    ("size_bytes", "MiB", lambda v: v / (1024 * 1024)),
    ("block_height", "blocks", lambda v: v),
    ("blocks", "blocks", lambda v: v),
]


@dataclass
class PhaseRecord:
    phase: str
    duration_s: float
    extras: dict

    @property
    def numeric_value(self) -> tuple[str, str, float] | None:
        for key, unit, fn in NUMERIC_EXTRA_KEYS:
            if key in self.extras:
                try:
                    return key, unit, fn(float(self.extras[key]))
                except (TypeError, ValueError):
                    return None
        return None


@dataclass
class JobReport:
    job: str
    flavour: str | None
    phases: list[PhaseRecord]


@dataclass
class BaselineStats:
    samples: list[float] = field(default_factory=list)

    @property
    def count(self) -> int:
        return len(self.samples)

    @property
    def min(self) -> float | None:
        return min(self.samples) if self.samples else None

    @property
    def max(self) -> float | None:
        return max(self.samples) if self.samples else None

    @property
    def avg(self) -> float | None:
        return sum(self.samples) / len(self.samples) if self.samples else None


def load_run(run_dir: Path) -> list[JobReport]:
    """Load every perf-*.json under run_dir and return one JobReport per file."""
    out = []
    for f in sorted(run_dir.rglob("perf-*.json")):
        try:
            with f.open() as fh:
                data = json.load(fh)
        except (OSError, json.JSONDecodeError) as e:
            print(f"warning: skipping {f}: {e}", file=sys.stderr)
            continue
        meta = data.get("metadata", {})
        phases = [
            PhaseRecord(
                phase=p["phase"],
                duration_s=float(p.get("duration_s", 0)),
                extras=p.get("extras", {}),
            )
            for p in data.get("phases", [])
        ]
        out.append(JobReport(job=meta.get("job", "unknown"), flavour=meta.get("flavour"), phases=phases))
    return out


def collect_baselines(baseline_root: Path) -> dict[tuple[str, str], BaselineStats]:
    """Walk baseline_root for per-run subdirs and aggregate values per (job, phase).

    For timing phases, the sample is duration_s. For phases with a known
    numeric extra, the sample is that extra's value (post-conversion).
    """
    stats: dict[tuple[str, str], BaselineStats] = {}
    if not baseline_root.exists():
        return stats
    for run_dir in sorted(baseline_root.iterdir()):
        if not run_dir.is_dir():
            continue
        for jr in load_run(run_dir):
            for p in jr.phases:
                key = (jr.job, p.phase)
                bucket = stats.setdefault(key, BaselineStats())
                sample = _sample_for(p)
                if sample is not None:
                    bucket.samples.append(sample)
    return stats


def _sample_for(p: PhaseRecord) -> float | None:
    if p.duration_s > 0:
        return p.duration_s
    nv = p.numeric_value
    return nv[2] if nv else None


def fmt_value(p: PhaseRecord) -> str:
    if p.duration_s > 0:
        return f"{p.duration_s:.2f} s"
    nv = p.numeric_value
    if nv is None:
        return "n/a"
    _, unit, val = nv
    if unit == "MiB":
        return f"{val:.1f} {unit}"
    return f"{val:g} {unit}"


def fmt_baseline(stats: BaselineStats, unit_hint: str) -> str:
    if stats.count == 0:
        return "n/a"

    def f(v: float) -> str:
        if unit_hint == "MiB":
            return f"{v:.1f}"
        if unit_hint == "s":
            return f"{v:.2f}"
        return f"{v:g}"

    return f"{f(stats.min)} / {f(stats.avg)} / {f(stats.max)}"


def fmt_delta(current: PhaseRecord, stats: BaselineStats) -> str:
    if stats.count == 0:
        return "—"
    cur = _sample_for(current)
    if cur is None or stats.avg in (None, 0):
        return "—"
    pct = (cur - stats.avg) / stats.avg * 100
    sign = "+" if pct >= 0 else ""
    arrow = ""
    if pct > 10:
        arrow = " 🔺"
    elif pct < -10:
        arrow = " 🟢"
    return f"{sign}{pct:.1f}%{arrow}"


def unit_hint(p: PhaseRecord) -> str:
    if p.duration_s > 0:
        return "s"
    nv = p.numeric_value
    return nv[1] if nv else ""


def render(current_jobs: list[JobReport], baselines: dict[tuple[str, str], BaselineStats]) -> str:
    if not current_jobs:
        return "_No perf artifacts found in this run._\n"

    lines = [
        "## ⏱ CI perf report",
        "",
        "Per-phase wall-clock from this run vs the rolling stats of the last successful main runs.",
        "",
    ]
    for jr in sorted(current_jobs, key=lambda j: j.job):
        title = jr.job
        if jr.flavour and jr.flavour != jr.job:
            title = f"{jr.job} (`{jr.flavour}`)"
        lines.append(f"### `{title}`")
        lines.append("")
        lines.append("| Phase | Current | Baseline (min / avg / max) | Δ vs avg | Samples |")
        lines.append("|---|---|---|---|---|")
        for p in jr.phases:
            stats = baselines.get((jr.job, p.phase), BaselineStats())
            uh = unit_hint(p)
            lines.append(
                f"| `{p.phase}` | {fmt_value(p)} | {fmt_baseline(stats, uh)} | {fmt_delta(p, stats)} | {stats.count} |"
            )
        lines.append("")
    lines.append("_Baseline is the last 10 successful main runs (or fewer if not yet available). Δ flags ±10%._")
    lines.append("")
    return "\n".join(lines)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--current", required=True, type=Path)
    ap.add_argument("--baseline", required=True, type=Path)
    ap.add_argument("--output", required=True, type=Path)
    args = ap.parse_args()

    current_jobs = load_run(args.current)
    baselines = collect_baselines(args.baseline)
    md = render(current_jobs, baselines)
    args.output.write_text(md)
    print(md)
    return 0


if __name__ == "__main__":
    sys.exit(main())
