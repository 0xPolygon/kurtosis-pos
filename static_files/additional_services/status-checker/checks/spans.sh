#!/usr/bin/env bash

# This script checks that spans are progressing.
# Spans should be produced every 8 sprints (128 blocks), which is roughly every 128 seconds,
# assuming a one second block time.

# shellcheck source=static_files/additional_services/status-checker/checks/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

now=$(date +%s)
error=0

for key in $(echo "$L2_URLS" | jq -r 'keys[]'); do
  heimdall_api=$(echo "$L2_URLS" | jq -r --arg k "$key" '.[$k].heimdall')
  if [[ -z "$heimdall_api" || "$heimdall_api" == "null" ]]; then
    echo "ERROR: heimdall api is empty for $key"
    exit 0
  fi

  bor_rpc=$(echo "$L2_URLS" | jq -r --arg k "$key" '.[$k].rpc')
  if [[ -z "$bor_rpc" || "$bor_rpc" == "null" ]]; then
    echo "ERROR: bor rpc is empty for $key"
    exit 0
  fi

  # Get the timestamp of the current span's start block.
  latest_span_id=$(curl -s "$heimdall_api/bor/spans/latest" | jq -r '.span.id')
  current_span_id=$((latest_span_id - 1))
  start_block=$(curl -s "$heimdall_api/bor/spans/$current_span_id" | jq -r '.span.start_block')
  block_ts_hex=$(cast block "$start_block" --rpc-url "$bor_rpc" --json | jq -r '.timestamp')
  block_ts=$((block_ts_hex))
  if [[ -z "$block_ts" || "$block_ts" == "null" ]]; then
    echo "ERROR: unable to retrieve start block timestamp for span $current_span_id for $key"
    exit 1
  fi

  now=$(date +%s)
  dt=$((now - block_ts))
  if [[ "$dt" -gt 200 ]]; then
    echo "ERROR: span is stuck for $key"
    error=1
  fi
done

exit "$error"
