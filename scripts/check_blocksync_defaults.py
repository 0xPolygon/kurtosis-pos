#!/usr/bin/env python3
"""Fail if the shared heimdall config.toml disables v0.12.1 block-sync serving.

Absent keys keep CometBFT DefaultBlockSyncConfig (non-zero budgets). An
explicit 0 disables the layer for every peer. Older heimdall images share
this template and ignore keys they do not know, so the keys must stay absent
rather than be pinned to one release's defaults: an explicit value here would
freeze a serving policy that should track each binary's own defaults.
"""

from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
CONFIG = ROOT / "static_files/cl/heimdall_v2/config.toml"
SERVING_KEYS = (
    "serving_rate",
    "serving_burst",
    "serving_subnet_rate",
    "peer_byte_quota",
    "peer_byte_quota_period",
    "exempt_peer_ids",
)


def blocksync_section(text: str) -> str:
    start = text.find("[blocksync]")
    if start < 0:
        raise SystemExit("config.toml has no [blocksync] section")
    rest = text[start + len("[blocksync]") :]
    end = rest.find("\n[")
    return rest if end < 0 else rest[:end]


def main() -> int:
    text = CONFIG.read_text()
    section = blocksync_section(text)
    failures = []
    if 'version = "v0"' not in section:
        failures.append("[blocksync] version is not v0")
    for key in SERVING_KEYS:
        for line in section.splitlines():
            stripped = line.split("#", 1)[0].strip()
            if stripped.startswith(key + " ") or stripped.startswith(key + "="):
                failures.append(
                    f"{key} is set in the shared template ({stripped!r}); "
                    "absent keeps the v0.12.1 default, 0 disables the layer"
                )
    if failures:
        print("\n".join(failures), file=sys.stderr)
        return 1
    print("blocksync serving keys absent; v0.12.1 defaults stay in force")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
