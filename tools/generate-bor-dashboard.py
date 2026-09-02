#!/usr/bin/env python3
"""Regenerate the Bor (EL) Grafana dashboard from a live node.

Scrapes /debug/metrics/prometheus from a running bor node and rebuilds
static_files/additional_services/grafana/dashboards/bor.json: a hand-picked
Overview row followed by one collapsed row per metric prefix (chain/*,
txpool/*, ...) containing one panel per metric family.

Panel style per exposition type:
  gauge    -> plain query, unit "short" ("bytes" if the name looks size-like)
  counter  -> rate(<name>[1m]), unit "ops"
  summary  -> quantile series, unit "s" (bor timers report seconds)

Usage:
  tools/generate-bor-dashboard.py --enclave pos                 # auto-discover a bor node
  tools/generate-bor-dashboard.py --enclave pos --service l2-el-1-bor-heimdall-v2-validator
  tools/generate-bor-dashboard.py --url http://127.0.0.1:34263  # explicit metrics endpoint
  tools/generate-bor-dashboard.py --url ... --output /tmp/bor.json

Requires only the Python standard library (plus the kurtosis CLI when using
--enclave discovery).
"""

import argparse
import json
import re
import subprocess
import sys
import urllib.request
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
DEFAULT_OUTPUT = (
    REPO_ROOT / "static_files/additional_services/grafana/dashboards/bor.json"
)

# Well-known UID of the Prometheus datasource provisioned by grafana.star.
DATASOURCE = {"type": "prometheus", "uid": "PBFA97CFB590B2093"}

METRICS_PATH = "/debug/metrics/prometheus"

# Keep prefix rows in the order the dashboard has historically used; prefixes
# not listed here (new metric groups) are appended alphabetically.
PREFERRED_PREFIX_ORDER = [
    "chain",
    "block",
    "blockstm",
    "downloader",
    "worker",
    "txpool",
    "p2p",
    "discover",
    "relay",
    "rpc",
    "eth",
    "filtermaps",
    "client",
    "state",
    "trie",
    "hashdb",
    "pathdb",
    "db",
    "witness",
    "bor",
    "sequencer",
    "system",
]

# Hand-picked Overview panels: (title, expr, legend, unit).
OVERVIEW_PANELS = [
    ("Head block", 'chain_head_block{job=~"$node"}', "{{job}}", "short"),
    ("Head header", 'chain_head_header{job=~"$node"}', "{{job}}", "short"),
    ("Reorg rate", 'rate(chain_reorg_executes{job=~"$node"}[5m])', "{{job}}", "ops"),
    (
        "Block insert qps",
        'rate(chain_inserts_count{job=~"$node"}[1m])',
        "{{job}}",
        "ops",
    ),
    ("Peers", 'p2p_peers{job=~"$node"}', "{{job}}", "short"),
    ("Txpool pending", 'txpool_pending{job=~"$node"}', "{{job}}", "short"),
    ("Goroutines", 'system_cpu_goroutines{job=~"$node"}', "{{job}}", "short"),
    ("Heap used", 'system_memory_used{job=~"$node"}', "{{job}}", "bytes"),
    (
        "Disk write Bps",
        'rate(system_disk_writebytes{job=~"$node"}[1m])',
        "{{job}}",
        "Bps",
    ),
]

PANEL_W = 8  # 3 panels per 24-unit grid row
PANEL_H = 7

BYTES_NAME_RE = re.compile(r"(^|_)(size|bytes|memory|mem|alloc|allocs)($|_)")


def discover_metrics_url(enclave, service):
    """Resolve a bor node's public metrics URL via the kurtosis CLI."""
    if not service:
        out = subprocess.run(
            ["kurtosis", "enclave", "inspect", enclave],
            check=True,
            capture_output=True,
            text=True,
        ).stdout
        services = re.findall(r"\b(l2-el-\d+-bor-\S+)", out)
        services = [
            s for s in services if not s.endswith("-config") and not s.endswith("-keys")
        ]
        if not services:
            sys.exit(f"error: no bor services found in enclave {enclave!r}")
        service = services[0]
        print(f"using service: {service}", file=sys.stderr)
    url = subprocess.run(
        ["kurtosis", "port", "print", enclave, service, "metrics"],
        check=True,
        capture_output=True,
        text=True,
    ).stdout.strip()
    if not url:
        sys.exit(f"error: no 'metrics' port on service {service!r}")
    return url


def scrape_families(url):
    """Return [(name, type), ...] in exposition order from # TYPE lines."""
    if not url.endswith(METRICS_PATH):
        url = url.rstrip("/") + METRICS_PATH
    print(f"scraping {url}", file=sys.stderr)
    with urllib.request.urlopen(url, timeout=30) as resp:
        text = resp.read().decode()
    families = []
    for line in text.splitlines():
        if line.startswith("# TYPE "):
            _, _, name, mtype = line.split()
            families.append((name, mtype))
    if not families:
        sys.exit("error: no '# TYPE' lines in metrics response; wrong endpoint?")
    return families


def gauge_unit(name):
    return "bytes" if BYTES_NAME_RE.search(name) else "short"


def make_panel(panel_id, title, targets, unit, grid_pos):
    return {
        "type": "timeseries",
        "title": title,
        "datasource": DATASOURCE,
        "gridPos": grid_pos,
        "id": panel_id,
        "targets": [
            {
                "refId": chr(ord("A") + i),
                "expr": expr,
                "legendFormat": legend,
                "datasource": DATASOURCE,
            }
            for i, (expr, legend) in enumerate(targets)
        ],
        "fieldConfig": {
            "defaults": {
                "unit": unit,
                "custom": {
                    "drawStyle": "line",
                    "lineWidth": 1,
                    "fillOpacity": 8,
                    "spanNulls": True,
                    "showPoints": "never",
                },
            },
            "overrides": [],
        },
        "options": {
            "legend": {"displayMode": "list", "placement": "bottom", "calcs": []},
            "tooltip": {"mode": "multi", "sort": "desc"},
        },
    }


def metric_panel_spec(name, mtype):
    """Map one metric family to (title, targets, unit)."""
    selector = f'{name}{{job=~"$node"}}'
    if mtype == "counter":
        return (
            f"{name} (counter, 1m rate)",
            [(f"rate({selector}[1m])", "{{job}}")],
            "ops",
        )
    if mtype in ("summary", "histogram"):
        return (
            f"{name} ({mtype})",
            [(selector, "{{job}} {{quantile}}")],
            "s",
        )
    return (f"{name} ({mtype})", [(selector, "{{job}}")], gauge_unit(name))


def grid_pos(index, y_offset):
    return {
        "x": (index % 3) * PANEL_W,
        "y": y_offset + (index // 3) * PANEL_H,
        "w": PANEL_W,
        "h": PANEL_H,
    }


def build_dashboard(families):
    next_id = [1000]

    def take_id():
        next_id[0] += 1
        return next_id[0] - 1

    panels = [
        {
            "type": "row",
            "title": "Overview",
            "id": take_id(),
            "collapsed": False,
            "gridPos": {"x": 0, "y": 0, "w": 24, "h": 1},
            "panels": [],
        }
    ]
    for i, (title, expr, legend, unit) in enumerate(OVERVIEW_PANELS):
        panels.append(make_panel(take_id(), title, [(expr, legend)], unit, grid_pos(i, 1)))
    overview_rows = (len(OVERVIEW_PANELS) + 2) // 3
    y = 1 + overview_rows * PANEL_H

    # Group families by prefix, preserving exposition order within a prefix.
    by_prefix = {}
    for name, mtype in families:
        by_prefix.setdefault(name.split("_", 1)[0], []).append((name, mtype))
    known = [p for p in PREFERRED_PREFIX_ORDER if p in by_prefix]
    extra = sorted(p for p in by_prefix if p not in PREFERRED_PREFIX_ORDER)
    if extra:
        print(f"new metric prefixes: {', '.join(extra)}", file=sys.stderr)

    for prefix in known + extra:
        members = by_prefix[prefix]
        row = {
            "type": "row",
            "title": f"{prefix}/* ({len(members)} metrics)",
            "id": take_id(),
            "collapsed": True,
            "gridPos": {"x": 0, "y": y, "w": 24, "h": 1},
            "panels": [],
        }
        y += 1
        for i, (name, mtype) in enumerate(members):
            title, targets, unit = metric_panel_spec(name, mtype)
            row["panels"].append(
                make_panel(take_id(), title, targets, unit, grid_pos(i, 1))
            )
        panels.append(row)

    return {
        "annotations": {
            "list": [
                {
                    "builtIn": 1,
                    "datasource": {"type": "grafana", "uid": "-- Grafana --"},
                    "enable": True,
                    "hide": True,
                    "iconColor": "rgba(0, 211, 255, 1)",
                    "name": "Annotations & Alerts",
                    "type": "dashboard",
                }
            ]
        },
        "description": (
            "Every metric family Bor exposes at /debug/metrics/prometheus, with one"
            " panel per family. Prefix rows are collapsed by default, click to"
            " expand. Generated by tools/generate-bor-dashboard.py."
        ),
        "editable": True,
        "fiscalYearStartMonth": 0,
        "graphTooltip": 1,
        "id": None,
        "links": [],
        "liveNow": True,
        "panels": panels,
        "refresh": "1s",
        "schemaVersion": 39,
        "tags": ["EL", "kurtosis-pos"],
        "templating": {
            "list": [
                {
                    "name": "node",
                    "label": "Node",
                    "type": "query",
                    "datasource": DATASOURCE,
                    "query": {
                        "query": "label_values(chain_head_block, job)",
                        "refId": "Prometheus-job-query",
                    },
                    "refresh": 2,
                    "multi": True,
                    "includeAll": True,
                    "allValue": "l2-el-.*-bor-.*",
                    "current": {"selected": True, "text": "All", "value": "$__all"},
                }
            ]
        },
        "time": {"from": "now-15m", "to": "now"},
        "timepicker": {"refresh_intervals": ["1s", "5s", "10s", "30s", "1m", "5m"]},
        "timezone": "",
        "title": "Bor (EL) Dashboard",
        "uid": "kurtosis-pos-bor",
        "version": 1,
        "weekStart": "",
    }


def main():
    parser = argparse.ArgumentParser(
        description="Regenerate the Bor (EL) Grafana dashboard from a live node."
    )
    source = parser.add_mutually_exclusive_group(required=True)
    source.add_argument(
        "--url",
        help="bor metrics endpoint, e.g. http://127.0.0.1:34263"
        f" ({METRICS_PATH} is appended if missing)",
    )
    source.add_argument(
        "--enclave", help="kurtosis enclave to auto-discover a bor node in"
    )
    parser.add_argument(
        "--service",
        help="bor service name within --enclave (default: first bor service found)",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=DEFAULT_OUTPUT,
        help=f"output path (default: {DEFAULT_OUTPUT.relative_to(REPO_ROOT)})",
    )
    args = parser.parse_args()
    if args.service and not args.enclave:
        parser.error("--service requires --enclave")

    url = args.url or discover_metrics_url(args.enclave, args.service)
    families = scrape_families(url)
    dashboard = build_dashboard(families)

    args.output.write_text(json.dumps(dashboard, indent=1) + "\n")
    n_rows = sum(1 for p in dashboard["panels"] if p["type"] == "row") - 1
    print(
        f"wrote {args.output}: {len(families)} metric families"
        f" in {n_rows} prefix rows + Overview",
        file=sys.stderr,
    )


if __name__ == "__main__":
    main()
