#!/usr/bin/env bash
# Download the kurtosis-pos-perf-* artifacts of a workflow run, flattened into
# a directory, for scripts/perf/report.py.
#
# Usage:
#   fetch-reports.sh run <run_id> <dest>
#       Artifacts of one run. Exits 0 with no files when the run has none.
#   fetch-reports.sh baseline <workflow_name> <current_sha> <dest>
#       Artifacts of the last 10 successful main runs of the workflow, one
#       <dest>/<run_id>/ directory each. The run with <current_sha> is skipped.
#
# Requires GH_TOKEN and GITHUB_REPOSITORY.
set -euo pipefail

fetch_run() {
  local run_id=$1 dest=$2 listing id name
  mkdir -p "$dest"
  # Capture first so set -e catches gh api failures: mapfile alone would hide
  # a network blip / 5xx / rate-limit behind its own exit code.
  listing=$(gh api "repos/${GITHUB_REPOSITORY}/actions/runs/${run_id}/artifacts" \
    --paginate \
    --jq '.artifacts[] | select(.name | startswith("kurtosis-pos-perf-")) | "\(.id) \(.name)"')
  # Job reruns upload a same-named artifact once per attempt: keep the newest
  # (highest id) per name so a failed attempt's partial upload can't shadow
  # the rerun's complete one.
  listing=$(sort -rn <<< "$listing" | awk 'NF && !seen[$2]++')
  while read -r id name; do
    [[ -z "$id" ]] && continue
    gh api "repos/${GITHUB_REPOSITORY}/actions/artifacts/${id}/zip" > "${dest}/${name}.zip" || continue
    unzip -j -o "${dest}/${name}.zip" -d "${dest}/" > /dev/null || true
    rm -f "${dest}/${name}.zip"
  done <<< "$listing"
}

case "${1:-}" in
  run)
    fetch_run "$2" "$3"
    ls -la "$3"
    ;;
  baseline)
    workflow_name=$2
    current_sha=$3
    dest=$4
    mkdir -p "$dest"
    # /actions/runs spans all workflows; widen the page so the post-filter by
    # name still leaves enough samples. -X GET: gh api defaults to POST when
    # -f is used, which 404s here.
    run_ids=$(gh api -X GET "repos/${GITHUB_REPOSITORY}/actions/runs" \
      -f branch=main -f status=success -f per_page=100 \
      --jq ".workflow_runs[] | select(.name == \"${workflow_name}\" and .head_sha != \"${current_sha}\") | .id" |
      head -n 10)
    echo "Baseline run IDs: ${run_ids:-<none>}" >&2
    for id in $run_ids; do
      fetch_run "$id" "${dest}/${id}"
    done
    ;;
  *)
    echo "usage: fetch-reports.sh run <run_id> <dest> | baseline <workflow_name> <current_sha> <dest>" >&2
    exit 2
    ;;
esac
