# Version matrix system

Tracks whether the versions this package deploys are still current, and surfaces
the answer as documentation instead of a thing someone has to remember to check.

Three kinds of dependency are covered:

- **Container images** — the `IMAGES` dict in `src/config/constants.star`.
- **CI tools** — the input defaults of `.github/actions/kurtosis/setup/action.yml`
  listed in `CI_TOOL_REPOS` (kurtosis, foundry).
- **External Kurtosis packages** — the `replace` block of `kurtosis.yml`.

All are compared against their upstream GitHub releases and annotated with a
status. The output lands in [`docs/docs/version-matrix.md`](../../docs/docs/version-matrix.md).
The [hard forks](#hard-forks) the devnet activates get their own page,
[`docs/docs/hard-forks.md`](../../docs/docs/hard-forks.md).

## Components

| Script                   | Role                                                                                                      | Needs a token |
| ------------------------ | --------------------------------------------------------------------------------------------------------- | ------------- |
| `extract-versions.py`    | Reads `constants.star`, `kurtosis.yml` and the setup action, queries the GitHub API, writes `matrix.json` | yes           |
| `hard_forks.py`          | Imported by `extract-versions.py`: reads fork schedules and pinned client sources                         | yes           |
| `generate-markdown.py`   | Renders `matrix.json` into the docs page                                                                  | no            |
| `verify-package-pins.py` | Checks the `replace` block is the single source of truth for package versions                             | no            |

```text
constants.star ──┐
                 ├─► extract-versions.py ──► matrix.json ──► generate-markdown.py ──► version-matrix.md + hard-forks.md
kurtosis.yml ────┤
action.yml ──────┤
                 │
GitHub API ──────┘
```

## Usage

```bash
pip install -r scripts/version-matrix/requirements.txt
export GITHUB_TOKEN="..."   # or: export GITHUB_TOKEN="$(gh auth token)"

python3 scripts/version-matrix/extract-versions.py    # writes matrix.json
python3 scripts/version-matrix/generate-markdown.py   # writes the docs page
```

`generate-markdown.py` shells out to `rumdl fmt` to align the tables it writes,
because the repo lints markdown with MD060 (aligned tables) and the status
emojis do not all have the same display width. `rumdl` is pinned in
`requirements.txt` to the version `checks.yaml` lints with; if it is missing the
script still writes the page, warns, and leaves the tables unaligned.

`verify-package-pins.py` runs offline and needs no token:

```bash
python3 scripts/version-matrix/verify-package-pins.py
```

## CI

- `checks.yaml` runs `verify-package-pins.py` on every push.
- `deploy.yaml` runs the full matrix nightly in the `check-version-matrix` job.
  It regenerates the matrix and fails if the committed version is out of date,
  which is the signal that a dependency has moved. The job is
  `continue-on-error`, so an upstream release never fails the nightly.

Regenerate and commit both `matrix.json` and the docs page when bumping a
dependency, so the nightly diff stays empty.

## Status system

| Status     | Icon | Description                                                   |
| ---------- | ---- | ------------------------------------------------------------- |
| up to date | ✅   | Running the latest upstream release                           |
| ahead      | ⚡️   | Ahead of the latest release — a prerelease or a patched build |
| behind     | 🚨   | An upstream release is available and should be picked up      |
| pinned     | 📌   | Deliberately held back — see the reason in the matrix         |

## Hard forks

`hard_forks.py` compares what the devnet activates with what the pinned clients
support, for three domains:

| Domain      | Devnet schedule                                                                                | Checked against                                                     |
| ----------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| L1          | ethereum-package `minimal` preset defaults, overridden in `src/config/input_parser.star`       | geth `params/config.go`, lighthouse built-in mainnet `config.yaml`  |
| Bor         | `EL_HARD_FORK_BLOCKS` in `src/config/constants.star`                                           | the `BorConfig` fork fields in bor `params/config.go`               |
| Heimdall-v2 | hardcoded per chain in heimdall-v2 `helper/config.go` (the devnet takes the `default` heights) | the same file; a fork bor also has must activate at the same height |

Upstream files are read at the refs this repo pins (image tags, the `kurtosis.yml`
ethereum-package commit), never at upstream HEAD. The tables therefore only
change when a pin or the package config changes: a fork that is merely announced
or scheduled upstream never makes the nightly diff non-empty. A failed fetch
fails the script instead of rendering a fork as unsupported.

| Status                  | Icon | Description                                                       |
| ----------------------- | ---- | ----------------------------------------------------------------- |
| enabled                 | ✅   | Activated by the devnet and known to the pinned clients           |
| not enabled             | 💤   | Known to the pinned clients, but the devnet leaves it off         |
| not supported yet       | ⏳   | Exposed by the package, but not known to a pinned client yet      |
| enabled but unsupported | ❌   | Configured by the devnet, but a pinned client ignores the setting |
| out of sync             | ❌   | Heimdall-v2 and bor activate the fork at different heights        |

Fork rows never use 🚨, so the bump workflow leaves them alone: enabling a fork
is a decision, not a version bump. The L1 table also checks that `L1_HARDFORK`
(the fork anvil and forge simulate) is the latest enabled EL fork. The L1 code
is shared with kurtosis-cdk's copy of `hard_forks.py`: keep both in sync. A new L1 fork needs its
EL name in `L1_EL_FORKS`, or its geth column reads `—`.

## Adding an image

Every key in `IMAGES` must be listed in exactly one of two tables in
`extract-versions.py`, otherwise the script exits non-zero and names it. That is
deliberate: a new image should not be able to slip in untracked.

- `COMPONENT_REPOS` — the image has an upstream GitHub repo that cuts releases.
  Maps the `IMAGES` key to `(display name, org/repo)`. If the repo tags its
  releases with a prefix other than `v` (nginx tags `release-1.31.6`), also add
  the key to `RELEASE_TAG_PREFIXES` so the prefix is stripped for the comparison
  and re-added when linking the release.
- `BUILT_IMAGES` — images with no GitHub release, published to a registry: the
  `pos-*` images (built from `docker/` here, published to GHCR by
  `publish-images.yaml`) and `toolbox` and `ethstats-server` (Artifact Registry). Maps the `IMAGES` key
  to `(display name, tag pattern)`; the latest version is the highest tag of the
  registry matching the pattern, read anonymously.
- `SKIPPED_IMAGES` — images deliberately left out, with the reason. Empty today.

## Pinned versions

Some components cannot track the latest release yet. Without a rule for this,
those rows show 🚨 permanently, which trains everyone to ignore the alarm and
hides real regressions.

Declare such cases in `PINNED_VERSIONS`, keyed by the `IMAGES` key, with a short
reason:

```python
PINNED_VERSIONS = {
    "l2_el_bor_image": "Only supports bor 2.9.x so far.",
}
```

Keep every reason in the same short form — `Only supports <component> <line> so
far.` — so the status column reads consistently and stays narrow.

The pin only ever downgrades a `behind` result. Once the pinned component
catches up with (or overtakes) stable, its real status is reported again — that
is the signal to delete the entry.

## External Kurtosis packages

Package versions live in exactly one place: the `replace` block of
`kurtosis.yml`. `replace` overrides the version of every matching reference in
the repo — including transitive dependencies — so the `.star` files reference
packages *without* an `@<version>` suffix and a bump only happens once.

```yaml
replace:
  github.com/ethpandaops/ethereum-package: github.com/ethpandaops/ethereum-package@<commit> # <date>
```

`verify-package-pins.py` fails if:

- a `.star` file pins a version inline — `replace` silently overrides it, so the
  inline version is misleading rather than effective;
- a referenced package has no `replace` entry, or an entry without a version —
  both resolve at upstream HEAD;
- a `replace` entry is no longer referenced anywhere — stale config.

Status is computed the same way as for images, except commit pins are compared
by *ancestry* rather than by date: the script asks the GitHub compare API
whether the pinned commit is ahead of or behind the latest release, because a
commit can be authored after a release was published while still being an
ancestor of it. The resulting distance (e.g. `14 commits behind 1.0.0`) is shown
in the matrix. Packages deliberately held back go in `PINNED_PACKAGES`, keyed by
package locator, using the same short reason form as `PINNED_VERSIONS`.

### Release-tracked vs head-tracked packages

What "latest" means follows from how a package is pinned in `kurtosis.yml`:

- A **tag** pin (`@v2.0.0`) is release-tracked: compared against the latest
  release or tag.
- A **commit** pin (`@6dd3f26…`) is head-tracked: compared against the default
  branch tip, and the matrix labels the column `HEAD (<sha>)` so a sha is never
  presented as a stable version. We pin commits when upstream ships faster than
  it tags, so the latest tag would report `⚡️ ahead` forever.

A head-tracked pin reports `🚨 behind` with its commit distance as soon as
HEAD moves past it, so the nightly bump PR follows the branch tip: one refreshed
PR per upstream change rather than a pin drifting unnoticed. A pin ahead of HEAD
(an unmerged or rewritten commit) reports `⚡️ ahead`.
