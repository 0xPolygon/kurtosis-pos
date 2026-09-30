#!/usr/bin/env bash

# Report producer rotations over the most recent spans: a span replaced by a
# later one starting at or before it, or a change of block producer.
# Rotations are reported as warnings; the check only fails when spans cannot be read.

# Number of spans to inspect, counting back from the latest one.
span_window=20

# shellcheck source=static_files/additional_services/status-checker/checks/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

error=0

for key in $(echo "$L2_URLS" | jq -r 'keys[]'); do
  heimdall_api=$(echo "$L2_URLS" | jq -r --arg k "$key" '.[$k].heimdall')
  if [[ -z "$heimdall_api" || "$heimdall_api" == "null" ]]; then
    echo "ERROR: $key heimdall api is empty"
    error=1
    continue
  fi

  latest_span_id=$(curl -s "$heimdall_api/bor/spans/latest" | jq -r '.span.id')
  if [[ ! "$latest_span_id" =~ ^[0-9]+$ ]]; then
    echo "ERROR: $key unable to retrieve the latest span id"
    error=1
    continue
  fi

  first_span_id=$((latest_span_id > span_window ? latest_span_id - span_window : 0))
  last_producer=""
  last_start_block=""
  for ((span_id = first_span_id; span_id <= latest_span_id; span_id++)); do
    span=$(curl -s "$heimdall_api/bor/spans/$span_id" | jq -c '.span')
    start_block=$(echo "$span" | jq -r '.start_block')
    producer=$(echo "$span" | jq -r '.selected_producers[0].val_id')
    if [[ ! "$start_block" =~ ^[0-9]+$ || ! "$producer" =~ ^[0-9]+$ ]]; then
      echo "ERROR: $key unable to retrieve span $span_id"
      error=1
      break
    fi

    if [[ -n "$last_start_block" && "$start_block" -le "$last_start_block" ]]; then
      echo "WARN: $key span $((span_id - 1)) was replaced by span $span_id (start block $start_block)"
    fi
    if [[ -n "$last_producer" && "$producer" != "$last_producer" ]]; then
      echo "WARN: $key producer rotated from $last_producer to $producer at span $span_id"
    fi
    last_producer="$producer"
    last_start_block="$start_block"
  done
done

exit "$error"
