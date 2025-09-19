#!/usr/bin/env bash

# Check that spans are progressing on Heimdall.
# Spans should be produced every 8 sprints (128 blocks), which is roughly every 128 seconds, assuming a one second block time.

# Threshold, in seconds, after which a span is considered stuck.
stuck_threshold_seconds=300

# shellcheck source=static_files/additional_services/status-checker/checks/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

now=$(date +%s)
error=0

for key in $(echo "$L2_URLS" | jq -r 'keys[]'); do
  # Get heimdall api url
  heimdall_api=$(echo "$L2_URLS" | jq -r --arg k "$key" '.[$k].heimdall')
  if [[ -z "$heimdall_api" || "$heimdall_api" == "null" ]]; then
    echo "ERROR: $key heimdall api is empty"
    error=1
    continue
  fi

  # Get rpc url
  rpc=$(echo "$L2_URLS" | jq -r --arg k "$key" '.[$k].rpc')
  if [[ -z "$rpc" || "$rpc" == "null" ]]; then
    echo "ERROR: $key rpc is empty"
    error=1
    continue
  fi

  # Get the last span
  latest_span_id=$(curl -s "$heimdall_api/bor/spans/latest" | jq -r '.span.id')
  if [[ -z "$latest_span_id" || "$latest_span_id" == "null" ]]; then
    echo "ERROR: $key unable to retrieve the last span id"
    error=1
    continue
  fi

  # Get the current span - the one before the latest one
  current_span_id=$((latest_span_id - 1))
  current_span=$(curl -s "$heimdall_api/bor/spans/$current_span_id" | jq -r '.span')
  if [[ -z "$current_span" || "$current_span" == "null" ]]; then
    echo "ERROR: $key unable to retrieve the current span $current_span_id"
    error=1
    continue
  fi

  # Get the start block of the current span
  start_block=$(echo "$current_span" | jq -r '.start_block')
  if [[ -z "$start_block" || "$start_block" == "null" ]]; then
    echo "ERROR: $key missing start block for span $current_span_id"
    error=1
    continue
  fi

  # Get the timestamp of the start block
  hex_ts=$(cast block "$start_block" --rpc-url "$rpc" --json | jq -r '.timestamp')
  if [[ -z "$hex_ts" || "$hex_ts" == "null" ]]; then
    echo "ERROR: $key response missing block timestamp"
    error=1
    continue
  fi
  ts=$((hex_ts))

  # Check that the span is not too old
  now=$(date +%s)
  dt=$((now - ts))
  if [[ "$dt" -gt "$stuck_threshold_seconds" ]]; then
    echo "ERROR: $key span is stuck at id $current_span_id"
    error=1
    continue
  fi
done

exit "$error"
