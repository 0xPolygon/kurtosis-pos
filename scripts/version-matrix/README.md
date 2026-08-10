# Version matrix system

Tracks whether the versions this package deploys are still current, and surfaces
the answer as documentation instead of a thing someone has to remember to check.

Two kinds of dependency are covered:

- **Container images** — the `IMAGES` dict in `src/config/constants.star`.
- **External Kurtosis packages** — the `replace` block of `kurtosis.yml`.

Both are compared against their upstream GitHub releases and annotated with a
status. The output lands in [`docs/docs/version-matrix.md`](../../docs/docs/version-matrix.md).

## Components

| Script                   | Role                                                                                    | Needs a token |
| ------------------------ | --------------------------------------------------------------------------------------- | ------------- |
| `extract-versions.py`    | Reads `constants.star` and `kurtosis.yml`, queries the GitHub API, writes `matrix.json` | yes           |
| `generate-markdown.py`   | Renders `matrix.json` into the docs page                                                | no            |
| `verify-package-pins.py` | Checks the `replace` block is the single source of truth for package versions           | no            |

```text
constants.star ──┐
                 ├─► extract-versions.py ──► matrix.json ──► generate-markdown.py ──► version-matrix.md
kurtosis.yml ────┤
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

| Status            | Icon | Description                                                    |
| ----------------- | ---- | -------------------------------------------------------------- |
| matches stable    | ✅   | Running the latest upstream release                            |
| newer than stable | ⚡️   | Ahead of the latest release — a prerelease or a patched build  |
| behind stable     | 🚨   | An upstream release is available and should be picked up       |
| pinned            | 📌   | Deliberately held back — see the reason in the matrix          |
| tracking head     | ⚠️   | Head-tracked package drifting from upstream, but not yet stale |

## Adding an image

Every key in `IMAGES` must be listed in exactly one of two tables in
`extract-versions.py`, otherwise the script exits non-zero and names it. That is
deliberate: a new image should not be able to slip in untracked.

- `COMPONENT_REPOS` — the image has an upstream GitHub repo that cuts releases.
  Maps the `IMAGES` key to `(display name, org/repo)`.
- `SKIPPED_IMAGES` — there is nothing upstream to compare against, with the
  reason. Two cases apply today: the `pos-*` images are built from `docker/` in
  this repo and published by `publish-images.yaml`, so their tag is whatever we
  last published; `toolbox` and `ethstats-server` live on Artifact Registry with
  commit-sha tags and no public release stream.

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

The pin only ever downgrades a `behind stable` result. Once the pinned component
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

Not every package releases often enough for "latest release" to mean anything.
`ethereum-package` keeps shipping daily well after its last tag, so comparing
our pin against that tag reports `⚡️ newer than stable` permanently — true,
useless, and hiding months of real drift.

`PACKAGE_TRACKING_MODE` sets what "latest" means per package:

```python
PACKAGE_TRACKING_MODE = {
    "github.com/ethpandaops/ethereum-package": "head",
}
```

- `release` (the default) compares the pin against the latest release or tag.
- `head` compares it against the default branch tip, and the matrix labels the
  column `HEAD (<sha>)` so a sha is never presented as a stable version.

Two kinds of package belong in `head`: those that ship faster than they tag, and
those that have never tagged at all. Without an entry, the latter falls back to
comparing a repo against its own branch tip and always looks up to date; the
extractor prints a hint when it finds a package with no releases *and* no tags.

For a head-tracked package, being behind HEAD is the normal steady state, so
distance alone cannot be the alarm. Age is: the pin reports `⚠️ tracking head`
with its commit distance until the pinned commit is older than
`HEAD_TRACKING_STALE_AFTER_DAYS` (14 days — these packages ship most days, so
two weeks is already a meaningful gap), at which point it escalates to
`🚨 behind stable`. If the compare API is unavailable, the age check still
applies on its own rather than reporting nothing.

Age is only consulted when the pin has actually fallen behind: a pin that still
equals HEAD reports `✅ matches stable` however old it is, so a dormant upstream
never raises a false alarm.
