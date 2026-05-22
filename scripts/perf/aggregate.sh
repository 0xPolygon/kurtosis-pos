#!/usr/bin/env bash
# Aggregate $PERF_DIR/results.jsonl into a single JSON artifact with run
# metadata. Output path defaults to $PERF_DIR/perf-$JOB.json; pass --output
# to override.
#
# Run metadata is read from the environment (GitHub Actions populates these).
# Missing values are emitted as null so the consumer (perf-report.yaml) can
# decide what to do.
set -euo pipefail

PERF_DIR="${PERF_DIR:-tmp/perf}"
JOB="${PERF_JOB:-${GITHUB_JOB:-unknown}}"
OUTPUT="$PERF_DIR/perf-$JOB.json"

while [[ $# -gt 0 ]]; do
  case $1 in
    --output)
      OUTPUT=$2
      shift 2
      ;;
    --job)
      JOB=$2
      shift 2
      ;;
    *)
      echo "aggregate.sh: unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

results_file="$PERF_DIR/results.jsonl"
if [[ ! -f $results_file ]]; then
  echo "aggregate.sh: no results at $results_file" >&2
  exit 1
fi

# Pull run metadata from the environment. GITHUB_* vars are set by the
# Actions runner; PERF_FLAVOUR is set explicitly in the workflow when a
# matrix dimension is meaningful (small vs large, args-file name, etc.).
metadata=$(
  jq --null-input \
    --arg job "$JOB" \
    --arg flavour "${PERF_FLAVOUR:-}" \
    --arg workflow "${GITHUB_WORKFLOW:-}" \
    --arg run_id "${GITHUB_RUN_ID:-}" \
    --arg run_attempt "${GITHUB_RUN_ATTEMPT:-}" \
    --arg ref "${GITHUB_REF:-}" \
    --arg ref_name "${GITHUB_REF_NAME:-}" \
    --arg event "${GITHUB_EVENT_NAME:-}" \
    --arg sha "${GITHUB_SHA:-}" \
    --arg actor "${GITHUB_ACTOR:-}" \
    --arg runner_os "${RUNNER_OS:-}" \
    --arg runner_arch "${RUNNER_ARCH:-}" \
    --arg runner_name "${RUNNER_NAME:-}" \
    '{
      job: $job,
      flavour: (if $flavour == "" then null else $flavour end),
      workflow: $workflow,
      run_id: $run_id,
      run_attempt: $run_attempt,
      ref: $ref,
      ref_name: $ref_name,
      event: $event,
      sha: $sha,
      actor: $actor,
      runner: {os: $runner_os, arch: $runner_arch, name: $runner_name}
    }'
)

# Coerce known numeric extras to numbers so consumers don't have to. Unknown
# keys stay as strings.
phases=$(
  jq --slurp '
    map(
      .extras |= with_entries(
        if (.key | IN("bytes", "blocks", "block_height", "size_bytes")) then
          .value |= tonumber
        else . end
      )
    )
  ' "$results_file"
)

jq --null-input \
  --argjson metadata "$metadata" \
  --argjson phases "$phases" \
  '{schema: "kurtosis-pos.perf.v1", metadata: $metadata, phases: $phases}' \
  > "$OUTPUT"

echo "Wrote $OUTPUT"
