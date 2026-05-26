#!/usr/bin/env bash
# Time individual CI phases and emit a JSONL stream of per-phase results.
#
# Usage:
#   measure.sh start <phase>
#   measure.sh end   <phase> [--extra key=value ...]
#   measure.sh emit  <phase> --extra key=value ...   # zero-duration record
#
# Output dir is $PERF_DIR (default: tmp/perf). `end` reads the matching
# start file (<phase>.start), computes the wall-clock duration, and appends
# one JSON line to $PERF_DIR/results.jsonl with the schema:
#
#   {"phase": "...", "started_at": "<RFC3339>", "ended_at": "<RFC3339>",
#    "duration_s": <float>, "extras": {<k>: <v>, ...}}
#
# `emit` is for metrics that aren't time deltas (e.g. snapshot image size).
# Extras are captured as strings; the aggregator coerces known numeric keys.
set -euo pipefail

PERF_DIR="${PERF_DIR:-tmp/perf}"
mkdir -p "$PERF_DIR"

# Returns epoch nanoseconds. GNU date supports %N; macOS does not but CI
# runs on ubuntu-latest, so this is fine.
now_ns() { date +%s%N; }
now_rfc3339() { date -u +"%Y-%m-%dT%H:%M:%SZ"; }

# Escape a string for embedding in a JSON value. Handles backslash, quote,
# and control characters. No external dep.
json_escape() {
  local s=$1
  s=${s//\\/\\\\}
  s=${s//\"/\\\"}
  s=${s//$'\n'/\\n}
  s=${s//$'\r'/\\r}
  s=${s//$'\t'/\\t}
  printf '%s' "$s"
}

# Build the `"extras": {...}` fragment from --extra k=v pairs.
build_extras() {
  local first=true
  printf '{'
  while [[ $# -gt 0 ]]; do
    if [[ $1 != --extra ]]; then
      echo "measure.sh: unexpected argument: $1" >&2
      exit 2
    fi
    shift
    local kv=${1:-}
    shift || true
    if [[ -z $kv || $kv != *=* ]]; then
      echo "measure.sh: --extra expects key=value, got: '$kv'" >&2
      exit 2
    fi
    local k=${kv%%=*}
    local v=${kv#*=}
    if $first; then first=false; else printf ','; fi
    printf '"%s":"%s"' "$(json_escape "$k")" "$(json_escape "$v")"
  done
  printf '}'
}

cmd_start() {
  local phase=$1
  local start_file="$PERF_DIR/$phase.start"
  now_ns > "$start_file"
  printf '%s\n' "$(now_rfc3339)" > "$PERF_DIR/$phase.started_at"
}

cmd_end() {
  local phase=$1
  shift
  local start_file="$PERF_DIR/$phase.start"
  local started_at_file="$PERF_DIR/$phase.started_at"
  if [[ ! -f $start_file ]]; then
    echo "measure.sh: no start record for phase '$phase' at $start_file" >&2
    exit 2
  fi
  local start_ns end_ns
  start_ns=$(cat "$start_file")
  end_ns=$(now_ns)
  # Duration in seconds with 3-decimal precision. Avoid bc dependency.
  local delta_ns=$((end_ns - start_ns))
  local secs=$((delta_ns / 1000000000))
  local millis=$(((delta_ns % 1000000000) / 1000000))
  local duration
  printf -v duration '%d.%03d' "$secs" "$millis"

  local started_at ended_at extras
  started_at=$(cat "$started_at_file" 2> /dev/null || printf '%s' "$(now_rfc3339)")
  ended_at=$(now_rfc3339)
  extras=$(build_extras "$@")

  printf '{"phase":"%s","started_at":"%s","ended_at":"%s","duration_s":%s,"extras":%s}\n' \
    "$(json_escape "$phase")" "$started_at" "$ended_at" "$duration" "$extras" \
    >> "$PERF_DIR/results.jsonl"

  rm -f "$start_file" "$started_at_file"
}

cmd_emit() {
  local phase=$1
  shift
  local now extras
  now=$(now_rfc3339)
  extras=$(build_extras "$@")
  printf '{"phase":"%s","started_at":"%s","ended_at":"%s","duration_s":0,"extras":%s}\n' \
    "$(json_escape "$phase")" "$now" "$now" "$extras" \
    >> "$PERF_DIR/results.jsonl"
}

main() {
  if [[ $# -lt 2 ]]; then
    echo "usage: measure.sh {start|end|emit} <phase> [--extra k=v ...]" >&2
    exit 2
  fi
  local verb=$1
  shift
  case $verb in
    start) cmd_start "$@" ;;
    end) cmd_end "$@" ;;
    emit) cmd_emit "$@" ;;
    *)
      echo "measure.sh: unknown verb '$verb'" >&2
      exit 2
      ;;
  esac
}

main "$@"
