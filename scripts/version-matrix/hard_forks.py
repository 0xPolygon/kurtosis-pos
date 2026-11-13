"""
Hard fork tracking for the version matrix.

For each fork domain, compares what the devnet activates with what the pinned
clients support. Upstream sources are read at the exact refs this repo pins
(image tags, `kurtosis.yml` replace pins), never at upstream HEAD, so these
tables only change when a pin or the package config changes: a fork that is
merely announced upstream never shows up as weekly drift.

Everything above the repo-specific section at the bottom is shared by
kurtosis-pos and kurtosis-cdk: keep both copies in sync.
"""

import os
import re
from dataclasses import asdict, dataclass, field
from pathlib import Path
from typing import Dict, List, Optional, Tuple

import requests
import yaml

# The epoch ethereum-package and the consensus clients use for "never".
FAR_FUTURE_EPOCH = 2**64 - 1

STATUS_ENABLED = "enabled"
STATUS_NOT_ENABLED = "not enabled"
STATUS_NOT_SUPPORTED_YET = "not supported yet"
STATUS_UNSUPPORTED = "enabled but unsupported"

# L1 consensus-layer fork -> the execution-layer fork it ships with. Altair and
# Bellatrix have no timestamp-activated EL fork, so there is nothing to check in
# geth for them.
L1_EL_FORKS = {
    "altair": None,
    "bellatrix": None,
    "capella": "shanghai",
    "deneb": "cancun",
    "electra": "prague",
    "fulu": "osaka",
    "gloas": "amsterdam",
    "heze": "bogota",
}

LIGHTHOUSE_NETWORK_CONFIG = (
    "common/eth2_network_config/built_in_network_configs/{}/config.yaml")
LIGHTHOUSE_MAINNET_CONFIG = LIGHTHOUSE_NETWORK_CONFIG.format("mainnet")


@dataclass
class HardFork:
    """A fork, when the devnet and mainnet activate it, and who supports it."""
    name: str
    # Activation in the devnet (epoch, block, height or offset); None if never.
    devnet: Optional[int]
    # Activation on mainnet; None if unscheduled or not applicable.
    mainnet: Optional[int] = None
    # Activation on the public testnet (Sepolia for L1, Amoy for Bor and Heimdall-v2).
    testnet: Optional[int] = None
    # Whether each pinned client knows the fork; None when not applicable.
    support: Dict[str, Optional[bool]] = field(default_factory=dict)
    status: Optional[str] = None
    note: Optional[str] = None
    # The execution-layer name of an L1 fork.
    el_name: Optional[str] = None


def fork_status(active: bool, support: Dict[str, Optional[bool]]) -> str:
    supported = all(known is not False for known in support.values())
    if active:
        return STATUS_ENABLED if supported else STATUS_UNSUPPORTED
    return STATUS_NOT_ENABLED if supported else STATUS_NOT_SUPPORTED_YET


def fetch(repo: str, ref: str, path: str) -> str:
    """Read a file from a GitHub repo at a ref.

    Raises rather than returning None: a failed request rendered as an
    unsupported fork would look like drift and trigger a bump.
    """
    response = requests.get(
        f"https://api.github.com/repos/{repo}/contents/{path}",
        params={"ref": ref}, timeout=10,
        headers={"Accept": "application/vnd.github.raw",
                 "Authorization": f'token {os.getenv("GITHUB_TOKEN")}'})
    if response.status_code != 200:
        raise RuntimeError(
            f"Could not fetch {path} from {repo}@{ref}: HTTP {response.status_code}")
    return response.text


def source(name: str, repo: str, ref: str, path: str) -> Dict[str, str]:
    return {"name": name, "ref": ref,
            "url": f"https://github.com/{repo}/blob/{ref}/{path}"}


def image_tag(constants: str, key: str) -> str:
    """The tag of an image in a constants.star images dict."""
    match = re.search(rf'"{key}":\s*"[^"]*:([^":]+)"', constants)
    if not match:
        raise ValueError(f"No tagged image {key} in constants.star")
    return match.group(1)


def package_pin(repo_root: Path, locator: str) -> Tuple[str, str]:
    """(org/repo, ref) a package is pinned to in the kurtosis.yml replace block."""
    replace = yaml.safe_load((repo_root / "kurtosis.yml").read_text())["replace"]
    target, _, ref = replace[locator].partition("@")
    return target.removeprefix("github.com/"), ref


def starlark_block(text: str, name: str) -> str:
    """The body of a top-level Starlark dict assignment or function."""
    match = re.search(rf"^(?:{name} = \{{|def {name}\(\):)\n(.*?)^\S", text,
                      re.DOTALL | re.MULTILINE)
    if not match:
        raise ValueError(f"{name} not found")
    return match.group(1)


def _epoch(value) -> Optional[int]:
    if value is None or value == "constants.FAR_FUTURE_EPOCH":
        return None
    epoch = int(value)
    return None if epoch == FAR_FUTURE_EPOCH else epoch


def l1_forks(overrides: str, ethereum_package: Tuple[str, str],
             geth_tag: str, lighthouse_tag: str) -> Dict:
    """L1 forks: the ethereum-package knobs at the pinned commit, the values the
    package overrides them with, and whether the pinned geth and lighthouse know
    each fork."""
    eth_repo, eth_ref = ethereum_package
    eth_path = "src/package_io/input_parser.star"
    geth_path = "params/config.go"
    geth_config = fetch("ethereum/go-ethereum", geth_tag, geth_path)
    mainnet = yaml.safe_load(
        fetch("sigp/lighthouse", lighthouse_tag, LIGHTHOUSE_MAINNET_CONFIG))
    blob_schedule = mainnet.get("BLOB_SCHEDULE") or []
    sepolia = yaml.safe_load(fetch("sigp/lighthouse", lighthouse_tag,
                                   LIGHTHOUSE_NETWORK_CONFIG.format("sepolia")))
    sepolia_blob_schedule = sepolia.get("BLOB_SCHEDULE") or []

    # The package runs the "minimal" preset, so these are the defaults of every
    # knob it does not override.
    defaults = starlark_block(fetch(eth_repo, eth_ref, eth_path),
                              "default_minimal_network_params")
    knob_pattern = r'"(\w+_fork_epoch|bpo_\d+_epoch)":\s*'
    knobs = re.findall(knob_pattern + r"([\w.]+)", defaults)
    configured = dict(re.findall(knob_pattern + r"(\d+)", overrides))

    forks = []
    for knob, default in knobs:
        name = knob.removesuffix("_epoch").removesuffix("_fork")
        bpo = re.fullmatch(r"bpo_(\d+)", name)
        if bpo:
            index = int(bpo.group(1))
            el_name = f"bpo{index}"
            cl_known = "BLOB_SCHEDULE" in mainnet
            mainnet_epoch = (blob_schedule[index - 1]["EPOCH"]
                             if index <= len(blob_schedule) else None)
            testnet_epoch = (sepolia_blob_schedule[index - 1]["EPOCH"]
                             if index <= len(sepolia_blob_schedule) else None)
        else:
            if name not in L1_EL_FORKS:
                print(f"Warning: no EL fork known for L1 fork {name}, "
                      f"add it to L1_EL_FORKS in hard_forks.py.")
            el_name = L1_EL_FORKS.get(name)
            cl_key = f"{name.upper()}_FORK_EPOCH"
            cl_known = cl_key in mainnet
            mainnet_epoch = _epoch(mainnet.get(cl_key))
            testnet_epoch = _epoch(sepolia.get(cl_key))

        support = {
            "geth": f'json:"{el_name}Time' in geth_config if el_name else None,
            "lighthouse": cl_known,
        }
        devnet = _epoch(configured.get(knob, default))
        forks.append(HardFork(
            name=name, el_name=el_name, devnet=devnet, mainnet=mainnet_epoch,
            testnet=testnet_epoch,
            support=support, status=fork_status(devnet is not None, support)))

    return {
        "sources": [
            source("ethereum-package", eth_repo, eth_ref, eth_path),
            source("geth", "ethereum/go-ethereum", geth_tag, geth_path),
            source("lighthouse", "sigp/lighthouse", lighthouse_tag,
                   LIGHTHOUSE_MAINNET_CONFIG),
        ],
        "forks": [asdict(fork) for fork in forks],
    }


# --- kurtosis-pos -----------------------------------------------------------

STATUS_OUT_OF_SYNC = "out of sync"

BOR_REPO = "0xPolygon/bor"
HEIMDALL_REPO = "0xPolygon/heimdall-v2"


def bor_forks(constants: str, bor_tag: str) -> Dict:
    """Bor forks: EL_HARD_FORK_BLOCKS against the BorConfig fields of the pinned
    bor. A configured fork bor does not know is ignored by its genesis parser."""
    config_path = "params/config.go"
    mainnet_path = "internal/cli/server/chains/mainnet.go"
    amoy_path = "internal/cli/server/chains/amoy.go"
    struct = re.search(r"^type BorConfig struct \{(.*?)^\}",
                       fetch(BOR_REPO, bor_tag, config_path),
                       re.DOTALL | re.MULTILINE)
    if not struct:
        raise ValueError(f"BorConfig not found in bor {bor_tag}")
    known = re.findall(r'\*big\.Int\s+`json:"(\w+)Block"`', struct.group(1))
    def chain_blocks(path: str) -> Dict[str, Optional[int]]:
        return {
            name[0].lower() + name[1:]: int(block) if block else None
            for name, block in re.findall(
                r"(\w+)Block:\s+(?:big\.NewInt\((\d+)\)|nil)",
                fetch(BOR_REPO, bor_tag, path))
        }

    mainnet = chain_blocks(mainnet_path)
    amoy = chain_blocks(amoy_path)
    configured = {
        name: int(block) for name, block in re.findall(
            r'"(\w+)":\s*(\d+)', starlark_block(constants, "EL_HARD_FORK_BLOCKS"))
    }

    forks = []
    for name in list(configured) + [n for n in known if n not in configured]:
        devnet = configured.get(name)
        support = {"bor": name in known}
        forks.append(HardFork(
            name=name, devnet=devnet, mainnet=mainnet.get(name),
            testnet=amoy.get(name), support=support,
            status=fork_status(devnet is not None, support)))

    return {
        "sources": [source("bor", BOR_REPO, bor_tag, config_path)],
        "forks": [asdict(fork) for fork in forks],
    }


def heimdall_forks(heimdall_tag: str, bor: Dict) -> Dict:
    """Heimdall-v2 forks. Heights are hardcoded per chain in helper/config.go and
    the devnet chain falls in the `default` case, so the package cannot change
    them; a fork bor also has must activate at the same height on both sides."""
    config_path = "helper/config.go"
    config = fetch(HEIMDALL_REPO, heimdall_tag, config_path)
    heights = {
        label: dict(re.findall(r"(\w+) = (-?\d+)", body))
        for label, body in re.findall(
            r"^[ \t]*(case MainChain|case AmoyChain|default):\n((?:[ \t]+\w+ = -?\d+\n)+)",
            config, re.MULTILINE)
        if "rioHeight" in body
    }
    if set(heights) != {"case MainChain", "case AmoyChain", "default"}:
        raise ValueError(f"Fork heights not found in heimdall-v2 {heimdall_tag}")

    bor_blocks = {fork["name"]: fork["devnet"] for fork in bor["forks"]}
    forks = []
    for variable, value in heights["default"].items():
        # Named forks only (`rioHeight`, `phuketHardforkHeight`), not the
        # multi-word fix heights (`tallyFixHeight`) nor `initialHeight`.
        match = re.fullmatch(r"([a-z]+)(?:Hardfork)?Height", variable)
        if not match or match.group(1) == "initial":
            continue
        name = match.group(1)
        # Zero disables a fork.
        devnet = int(value) or None
        mainnet = int(heights["case MainChain"].get(variable, 0)) or None
        testnet = int(heights["case AmoyChain"].get(variable, 0)) or None
        status = fork_status(devnet is not None, {})
        note = None
        if name in bor_blocks and bor_blocks[name] != devnet:
            status = STATUS_OUT_OF_SYNC
            note = f"bor activates it at block {bor_blocks[name]}"
        forks.append(HardFork(name=name, devnet=devnet, mainnet=mainnet,
                              testnet=testnet, status=status, note=note))

    return {
        "sources": [source("heimdall-v2", HEIMDALL_REPO, heimdall_tag, config_path)],
        "forks": [asdict(fork) for fork in forks],
    }


def extract(repo_root: Path) -> Dict:
    constants = (repo_root / "src" / "config" / "constants.star").read_text()

    l1 = l1_forks(
        (repo_root / "src" / "config" / "input_parser.star").read_text(),
        package_pin(repo_root, "github.com/ethpandaops/ethereum-package"),
        image_tag(constants, "l1_el_image"),
        image_tag(constants, "l1_cl_image"),
    )
    # Anvil and forge simulate a single named hard fork, which should be the
    # latest one the L1 devnet runs.
    l1_hardfork = re.search(r'^L1_HARDFORK = "(\w+)"', constants, re.MULTILINE)
    enabled = [fork["el_name"] for fork in l1["forks"]
               if fork["devnet"] is not None and fork["el_name"]
               and not fork["name"].startswith("bpo_")]
    l1["l1_hardfork"] = {
        "value": l1_hardfork.group(1) if l1_hardfork else None,
        "latest_enabled": enabled[-1] if enabled else None,
    }

    bor = bor_forks(constants, image_tag(constants, "l2_el_bor_image"))
    heimdall = heimdall_forks(image_tag(constants, "l2_cl_heimdall_v2_image"), bor)
    return {"l1": l1, "bor": bor, "heimdall_v2": heimdall}
