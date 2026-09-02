#!/usr/bin/env python3
"""
Automated version matrix extraction tool for Kurtosis PoS.

Extracts version information from:
1. `IMAGES` in src/config/constants.star — the container images we deploy.
2. The `replace` block of kurtosis.yml — the external Kurtosis packages we pin.

Both are compared against their upstream GitHub releases (or branch HEAD, for
packages that ship faster than they tag) and annotated with a status. The result
is written to matrix.json, which generate-markdown.py renders into the docs.
"""

import os
import re
import json
from dataclasses import dataclass, asdict
from datetime import datetime
from pathlib import Path
from typing import Dict, Optional, Tuple

import requests
import yaml


@dataclass
class ComponentVersion:
    """A container image version we deploy, and how it compares to upstream."""
    version: str
    image: str
    latest_version: Optional[str] = None
    version_source_url: Optional[str] = None
    latest_version_source_url: Optional[str] = None
    status: Optional[str] = None
    pin_reason: Optional[str] = None


@dataclass
class PackageVersion:
    """A pinned external Kurtosis package dependency."""
    pin: str
    pin_date: Optional[str] = None
    pin_source_url: Optional[str] = None
    latest_version: Optional[str] = None
    latest_version_date: Optional[str] = None
    latest_version_source_url: Optional[str] = None
    status: Optional[str] = None
    commit_distance: Optional[str] = None
    tracking_mode: str = "release"
    pin_reason: Optional[str] = None


# Images from `IMAGES` mapped to the GitHub repo that releases them.
#
# Keys are the `IMAGES` keys in src/config/constants.star, values are the
# component name shown in the matrix plus its upstream repo. An image absent
# from this table is skipped — see SKIPPED_IMAGES for why that is deliberate.
COMPONENT_REPOS = {
    # layer 1
    "l1_el_image": ("geth", "ethereum/go-ethereum"),
    "l1_cl_image": ("lighthouse", "sigp/lighthouse"),
    "l1_anvil_image": ("foundry", "foundry-rs/foundry"),
    # layer 2
    "l2_cl_heimdall_v2_image": ("heimdall-v2", "0xPolygon/heimdall-v2"),
    "l2_el_bor_image": ("bor", "0xPolygon/bor"),
    "l2_cl_queue_image": ("rabbitmq", "rabbitmq/rabbitmq-server"),
    # additional services
    "erpc_image": ("erpc", "erpc/erpc"),
    "status_checker_image": ("status-checker", "0xPolygon/status-checker"),
    # observability
    "prometheus_image": ("prometheus", "prometheus/prometheus"),
    "grafana_image": ("grafana", "grafana/grafana"),
    "panoptichain_image": ("panoptichain", "0xPolygon/panoptichain"),
    # sequence store (preconfirmation experiment)
    "seqstore_redpanda_image": ("redpanda", "redpanda-data/redpanda"),
    "seqstore_envoy_image": ("envoy", "envoyproxy/envoy"),
}

# Images intentionally left out of the matrix, with the reason. Keeping this
# explicit means a newly added image that lands in neither table is a visible
# gap rather than a silent omission — main() prints a warning for those.
SKIPPED_IMAGES = {
    # Built from docker/*.Dockerfile in this repo and published by
    # publish-images.yaml, so there is no upstream release to track: the tag is
    # whatever we last published.
    "pos_contract_deployer_image": "built in this repo (docker/)",
    "pos_el_genesis_builder_image": "built in this repo (docker/)",
    "pos_validator_config_generator_image": "built in this repo (docker/)",
    # Hosted on Google Artifact Registry with commit-sha tags and no public
    # GitHub release stream to compare against.
    "toolbox_image": "internal image on Artifact Registry",
    "ethstats_server_image": "internal image on Artifact Registry",
}

# Components deliberately held back from the latest stable release, keyed by
# component name. These render as "pinned" instead of "behind stable" so that
# genuine regressions stay visible in the matrix.
#
# Keep every reason in the same short form: "Only supports <component> <line> so far."
PINNED_VERSIONS: Dict[str, str] = {}

# External Kurtosis packages deliberately held back, keyed by package locator.
# Same convention as PINNED_VERSIONS.
PINNED_PACKAGES: Dict[str, str] = {}

# What "latest" means for each package, keyed by package locator.
#
# - "release" (default): compare the pin against the latest release/tag. Right
#   for packages that tag every change worth consuming.
# - "head": compare the pin against the default branch HEAD. Right for packages
#   that release rarely and expect consumers to pin commits — ethereum-package
#   keeps shipping daily well after its last tag, so measuring against that tag
#   reports "newer than stable" forever and hides real drift.
PACKAGE_TRACKING_MODE = {
    "github.com/ethpandaops/ethereum-package": "head",
}

# A head-tracked pin is always behind HEAD on an active upstream, so distance
# alone is not a signal. Alarm once the pin is old enough that we are plausibly
# missing fixes: these packages ship most days, so two weeks is already a
# meaningful gap.
HEAD_TRACKING_STALE_AFTER_DAYS = 14

STATUS_MATCHES = "matches stable"
STATUS_BEHIND = "behind stable"
STATUS_NEWER = "newer than stable"
STATUS_PINNED = "pinned"
STATUS_TRACKING_HEAD = "tracking head"


class VersionMatrixExtractor:
    """Extracts and manages version matrix information."""

    def __init__(self, repo_root: Path):
        self.repo_root = repo_root
        self.constants_path = repo_root / "src" / "config" / "constants.star"
        self.kurtosis_yaml_path = repo_root / "kurtosis.yml"

    # --- images ------------------------------------------------------------

    def extract_images(self) -> Tuple[Dict[str, ComponentVersion], list]:
        """Extract image versions from the `IMAGES` dict in constants.star.

        Returns (components, unknown_keys) where unknown_keys lists image keys
        that are in neither COMPONENT_REPOS nor SKIPPED_IMAGES.
        """
        components: Dict[str, ComponentVersion] = {}
        unknown_keys = []

        content = self.constants_path.read_text()
        match = re.search(r"^IMAGES\s*=\s*\{(.*?)^\}", content,
                          re.DOTALL | re.MULTILINE)
        if not match:
            raise ValueError(f"IMAGES not found in {self.constants_path}")

        for line in match.group(1).split("\n"):
            line = line.strip()
            if not line or line.startswith("#"):
                continue

            entry = re.search(r'"([^"]+)":\s*"([^"]+)"', line)
            if not entry:
                continue

            key, image = entry.groups()
            if key in SKIPPED_IMAGES:
                continue
            if key not in COMPONENT_REPOS:
                unknown_keys.append(key)
                continue

            name, repo = COMPONENT_REPOS[key]
            version = self._version_from_image(image)
            latest_version = self._get_latest_version(repo)
            status = self._determine_status(version, latest_version)

            pin_reason = None
            # A pin only ever downgrades a "behind stable" result: once the
            # component catches up, its real status is reported again, which is
            # the signal to delete the entry.
            if status == STATUS_BEHIND and key in PINNED_VERSIONS:
                pin_reason = PINNED_VERSIONS[key]
                status = STATUS_PINNED

            components[name] = ComponentVersion(
                version=version,
                image=image,
                latest_version=latest_version,
                version_source_url=self._release_url(repo, version),
                latest_version_source_url=self._release_url(repo, latest_version),
                status=status,
                pin_reason=pin_reason,
            )

        return components, unknown_keys

    @staticmethod
    def _version_from_image(image: str) -> str:
        """Extract the version from a Docker image reference."""
        if ":" not in image:
            return "latest"
        tag = image.rsplit(":", 1)[-1]
        if tag in ("latest", "main", "master"):
            return tag
        return tag.lstrip("v")

    @staticmethod
    def _release_url(repo: str, version: Optional[str]) -> Optional[str]:
        """Build a browsable release URL for a component version."""
        if not version:
            return None
        if version in ("latest", "main", "master"):
            return f"https://github.com/{repo}/releases/latest"
        return f"https://github.com/{repo}/releases/tag/v{version.lstrip('v')}"

    @staticmethod
    def _is_prerelease(tag_name: str) -> bool:
        """Whether a tag looks like a prerelease rather than a stable version."""
        return re.search(r"-(alpha|beta|rc|test)", tag_name, re.IGNORECASE) is not None

    def _get_latest_version(self, repo: str) -> Optional[str]:
        """Fetch the latest stable release version for a repo."""
        release = self._github_get(f"repos/{repo}/releases/latest",
                                   allow_missing=True)
        if release and release.get("tag_name"):
            tag = release["tag_name"]
            if not self._is_prerelease(tag):
                return tag.lstrip("v")

        # Some repos publish prereleases as "latest", or never cut releases at
        # all; fall back to the newest stable tag.
        tags = self._github_get(f"repos/{repo}/tags?per_page=100")
        if isinstance(tags, list):
            for tag in tags:
                name = tag.get("name", "")
                if name and not self._is_prerelease(name):
                    return name.lstrip("v")

        print(f"No stable release or tag found for {repo}.")
        return None

    def _determine_status(self, version: Optional[str],
                          latest_version: Optional[str]) -> Optional[str]:
        """Compare a deployed version against the latest stable release."""
        if not version or not latest_version:
            return None

        ours = self._version_key(version)
        theirs = self._version_key(latest_version)
        if ours is None or theirs is None:
            return None

        if ours > theirs:
            return STATUS_NEWER
        if ours < theirs:
            return STATUS_BEHIND

        # Same numeric version: a suffix on one side but not the other means we
        # run a patched build of the release rather than the release itself.
        our_suffix = version.partition("-")[2]
        their_suffix = latest_version.partition("-")[2]
        if our_suffix == their_suffix:
            return STATUS_MATCHES
        return STATUS_NEWER

    @staticmethod
    def _version_key(version: str) -> Optional[tuple]:
        """Turn a semver-ish string into a comparable tuple, ignoring suffixes."""
        core = version.lstrip("v").partition("-")[0]
        parts = core.split(".")
        try:
            numbers = [int(part) for part in parts]
        except ValueError:
            return None
        # Pad so that "2.9" and "2.9.0" compare equal.
        while len(numbers) < 3:
            numbers.append(0)
        return tuple(numbers)

    # --- packages ----------------------------------------------------------

    def extract_packages(self) -> Dict[str, PackageVersion]:
        """Extract external Kurtosis package pins from the kurtosis.yml replace block."""
        packages: Dict[str, PackageVersion] = {}

        try:
            kurtosis_yaml = yaml.safe_load(self.kurtosis_yaml_path.read_text())
        except Exception as e:
            print(f"Error reading {self.kurtosis_yaml_path}: {e}")
            return packages

        replace_options = (kurtosis_yaml or {}).get("replace") or {}
        if not replace_options:
            print("No `replace` block found in kurtosis.yml, skipping packages.")
            return packages

        for package_locator, replacement in replace_options.items():
            # A replacement may redirect to a different repo (e.g. a fork) and
            # optionally append `@<tag|branch|commit>`. The pin is what actually
            # gets resolved, so report against the replacement target.
            target, _, pin = replacement.partition("@")
            repo = self._repo_from_locator(target)
            if not repo:
                print(f"Could not derive a GitHub repo from '{target}', skipping.")
                continue

            pin = pin or "HEAD"
            pin_date = self._get_ref_date(repo, pin)
            tracking_mode = PACKAGE_TRACKING_MODE.get(package_locator, "release")

            if tracking_mode == "head":
                latest_version, latest_version_date = self._get_head_version(repo)
                status, commit_distance = self._determine_head_tracked_status(
                    repo, pin, pin_date, latest_version)
            else:
                latest_version, latest_version_date = self._get_latest_package_version(repo)
                status, commit_distance = self._determine_package_status(
                    repo, pin, pin_date, latest_version, latest_version_date)

            pin_reason = None
            if status == STATUS_BEHIND and package_locator in PINNED_PACKAGES:
                pin_reason = PINNED_PACKAGES[package_locator]
                status = STATUS_PINNED

            packages[package_locator] = PackageVersion(
                pin=pin,
                pin_date=pin_date,
                pin_source_url=self._package_source_url(repo, pin),
                latest_version=latest_version,
                latest_version_date=latest_version_date,
                latest_version_source_url=(
                    self._package_source_url(repo, latest_version)
                    if latest_version else None
                ),
                status=status,
                commit_distance=commit_distance,
                tracking_mode=tracking_mode,
                pin_reason=pin_reason,
            )

        return packages

    @staticmethod
    def _repo_from_locator(locator: str) -> Optional[str]:
        """Turn a github.com/org/repo[/sub/path] locator into 'org/repo'."""
        match = re.match(r"(?:https?://)?github\.com/([^/]+)/([^/@]+)", locator)
        return f"{match.group(1)}/{match.group(2)}" if match else None

    @staticmethod
    def _is_commit_sha(ref: str) -> bool:
        return bool(re.fullmatch(r"[0-9a-f]{7,40}", ref or "", re.IGNORECASE))

    def _get_ref_date(self, repo: str, ref: str) -> Optional[str]:
        """Resolve the commit date (YYYY-MM-DD) of a tag, branch or commit."""
        if not ref:
            return None

        candidates = [ref]
        # Kurtosis pins are often written `@v1.1.0` while the upstream tag is
        # `1.1.0` (or the reverse), so try both spellings before giving up.
        if not self._is_commit_sha(ref):
            stripped = ref.lstrip("v")
            candidates += [stripped, f"v{stripped}"]

        for candidate in dict.fromkeys(candidates):
            data = self._github_get(f"repos/{repo}/commits/{candidate}",
                                    allow_missing=True)
            if data:
                date = data.get("commit", {}).get("committer", {}).get("date")
                return date[:10] if date else None
        return None

    def _get_latest_package_version(self, repo: str) -> tuple:
        """Return (version, date) of the newest release, falling back to tags.

        A repo with neither is not release-tracked at all; add it to
        PACKAGE_TRACKING_MODE as "head" rather than silently comparing it
        against its own branch tip, which would always look up to date.
        """
        # A 404 here just means the repo has never published a release.
        release = self._github_get(f"repos/{repo}/releases/latest",
                                   allow_missing=True)
        if release and release.get("tag_name"):
            return release["tag_name"], (release.get("published_at") or "")[:10] or None

        tags = self._github_get(f"repos/{repo}/tags?per_page=1")
        if isinstance(tags, list) and tags:
            tag_name = tags[0].get("name")
            if tag_name:
                return tag_name, self._get_ref_date(repo, tag_name)

        print(f"No releases or tags found for {repo}; consider tracking it by "
              f"head in PACKAGE_TRACKING_MODE.")
        return None, None

    def _get_head_version(self, repo: str) -> tuple:
        """Return (short_sha, date) of the default branch HEAD."""
        commits = self._github_get(f"repos/{repo}/commits?per_page=1")
        if isinstance(commits, list) and commits:
            sha = commits[0].get("sha", "")
            date = commits[0].get("commit", {}).get("committer", {}).get("date")
            return sha[:12] if sha else None, date[:10] if date else None
        return None, None

    def _determine_head_tracked_status(self, repo: str, pin: str,
                                       pin_date: Optional[str],
                                       head_version: Optional[str]) -> tuple:
        """Judge a pin that tracks HEAD rather than releases.

        Being behind HEAD is the normal steady state for these packages, so
        distance alone is not a signal. What matters is age: a pin only becomes
        a problem once it is old enough that we are plausibly missing fixes.
        """
        if not head_version:
            return None, None

        if pin[:12] == head_version[:12]:
            return STATUS_MATCHES, None

        comparison = self._github_get(f"repos/{repo}/compare/{head_version}...{pin}")
        distance = None
        if comparison:
            behind_by = comparison.get("behind_by", 0)
            if behind_by > 0:
                distance = f"{behind_by} commits behind HEAD"
            elif comparison.get("ahead_by", 0) > 0:
                # Pinned to an unmerged or since-rewritten commit.
                return STATUS_NEWER, (
                    f"{comparison['ahead_by']} commits ahead of HEAD")

        age_days = self._days_since(pin_date)
        if age_days is not None and age_days > HEAD_TRACKING_STALE_AFTER_DAYS:
            age_note = f"pinned commit is {age_days} days old"
            return STATUS_BEHIND, (
                f"{distance}, {age_note}" if distance else age_note)

        # Recent enough to be deliberate: report the drift without alarming.
        return STATUS_TRACKING_HEAD, distance

    @staticmethod
    def _days_since(date: Optional[str]) -> Optional[int]:
        """Whole days between an ISO date (YYYY-MM-DD) and today."""
        if not date:
            return None
        try:
            return (datetime.now() - datetime.strptime(date, "%Y-%m-%d")).days
        except ValueError:
            return None

    def _package_source_url(self, repo: str, ref: str) -> Optional[str]:
        """Build a browsable URL for a package ref."""
        if not ref:
            return None
        if self._is_commit_sha(ref):
            return f"https://github.com/{repo}/tree/{ref}"
        return f"https://github.com/{repo}/releases/tag/{ref}"

    def _determine_package_status(self, repo: str, pin: str,
                                  pin_date: Optional[str],
                                  latest_version: Optional[str],
                                  latest_version_date: Optional[str]) -> tuple:
        """Determine whether a package pin is up to date, and how far it drifted.

        Returns (status, commit_distance) where commit_distance is a short
        human-readable summary like "14 commits behind 1.0.0", or None.
        """
        if not latest_version:
            return None, None

        # A tag pin can be compared directly against the latest release tag.
        if not self._is_commit_sha(pin) and not self._is_commit_sha(latest_version):
            if pin.lstrip("v") == latest_version.lstrip("v"):
                return STATUS_MATCHES, None
            return self._determine_status(
                pin.lstrip("v"), latest_version.lstrip("v")), None

        # A commit pin equal to the latest ref is up to date.
        if pin[:12] == (latest_version or "")[:12]:
            return STATUS_MATCHES, None

        # For a commit pin, ask GitHub where it sits relative to the latest
        # release. Comparing raw dates would be wrong: a commit can be authored
        # after a release was published while still being an ancestor of it.
        comparison = self._github_get(f"repos/{repo}/compare/{latest_version}...{pin}")
        if comparison:
            behind_by = comparison.get("behind_by", 0)
            ahead_by = comparison.get("ahead_by", 0)
            if behind_by > 0:
                return STATUS_BEHIND, f"{behind_by} commits behind {latest_version}"
            if ahead_by > 0:
                return STATUS_NEWER, f"{ahead_by} commits ahead of {latest_version}"
            return STATUS_MATCHES, None

        # Fall back to dates only when the comparison is unavailable.
        if pin_date and latest_version_date:
            if pin_date > latest_version_date:
                return STATUS_NEWER, None
            if pin_date < latest_version_date:
                return STATUS_BEHIND, None
            return STATUS_MATCHES, None

        return None, None

    # --- github ------------------------------------------------------------

    @staticmethod
    def _github_get(path: str, allow_missing: bool = False):
        """GET a GitHub API path, returning parsed JSON or None.

        Set allow_missing for endpoints where a 404 is a legitimate answer
        rather than a failure — a repo that has never cut a release returns 404
        from /releases/latest, and logging that as an error is just noise.
        """
        try:
            response = requests.get(
                f"https://api.github.com/{path}", timeout=10,
                headers={"Authorization": f'token {os.getenv("GITHUB_TOKEN")}'})
            if response.status_code == 200:
                return response.json()
            if response.status_code == 404 and allow_missing:
                return None
            print(f"Error fetching {path}: {response.status_code}")
        except Exception as e:
            print(f"Error fetching {path}: {e}")
        return None

    # --- matrix ------------------------------------------------------------

    def generate_version_matrix(self) -> Tuple[Dict, list]:
        """Build the full version matrix."""
        print("Extracting images...")
        images, unknown_keys = self.extract_images()

        print("Extracting external Kurtosis packages...")
        packages = self.extract_packages()

        matrix = {
            "generated_at": datetime.now().isoformat(),
            "images": {name: asdict(component) for name, component in images.items()},
            "packages": {name: asdict(package) for name, package in packages.items()},
            "summary": {
                "total_images": len(images),
                "total_packages": len(packages),
                "skipped_images": len(SKIPPED_IMAGES),
            },
        }
        return matrix, unknown_keys

    def save_matrix_json(self, matrix: Dict, output_path: Optional[Path] = None):
        """Save the matrix as a JSON file."""
        if output_path is None:
            output_path = self.repo_root / "scripts" / "version-matrix" / "matrix.json"

        # The nightly job diffs this file, so keep the output stable: sorted
        # keys, and no volatile timestamp.
        stable = {key: value for key, value in matrix.items()
                  if key != "generated_at"}
        output_path.write_text(json.dumps(stable, indent=2, sort_keys=True) + "\n")
        print(f"Version matrix saved to {output_path}")


def main():
    if not os.getenv("GITHUB_TOKEN"):
        print("Error: GITHUB_TOKEN environment variable is not set.")
        print("Please set it to access GitHub API for version information.")
        exit(1)

    repo_root = Path(__file__).parent.parent.parent
    extractor = VersionMatrixExtractor(repo_root)

    print("Starting version matrix extraction...")
    matrix, unknown_keys = extractor.generate_version_matrix()
    extractor.save_matrix_json(matrix)

    summary = matrix["summary"]
    print("\n=== Version Matrix Summary ===")
    print(f"Images tracked: {summary['total_images']}")
    print(f"Images skipped: {summary['skipped_images']}")
    print(f"Packages tracked: {summary['total_packages']}")

    # An image in neither COMPONENT_REPOS nor SKIPPED_IMAGES is a gap: it was
    # added to constants.star without deciding how to track it.
    if unknown_keys:
        print("\nUntracked images found in constants.star. Add them to "
              "COMPONENT_REPOS or SKIPPED_IMAGES in this script:")
        for key in unknown_keys:
            print(f"  - {key}")
        exit(1)


if __name__ == "__main__":
    main()
