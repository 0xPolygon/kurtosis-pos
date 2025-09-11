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
  bor_rpc=$(echo "$L2_URLS" | jq -r --arg k "$key" '.[$k].rpc')

  # Get the timestamp of the latest span's end block.
  latest_span_end_block=$(curl -s "$heimdall_api/bor/spans/latest" | jq -r '.span.end_block')
  block_ts_hex=$(cast block "$latest_span_end_block" --rpc-url "$bor_rpc" --json | jq -r '.timestamp')
  block_ts=$((block_ts_hex))

  now=$(date +%s)
  dt=$((now - block_ts))
  if [[ "$dt" -gt 200 ]]; then
    echo "ERROR: span is stuck"
    error=1
  fi
done

exit "$error"
