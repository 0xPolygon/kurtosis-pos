#!/usr/bin/env bash

# Check that blocks are progressing on Bor.
# Blocks should be produced every one second.

# Threshold, in seconds, after which a block is considered stuck.
stuck_threshold_seconds=30

# shellcheck source=static_files/additional_services/status-checker/checks/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

now=$(date +%s)
error=0

for key in $(echo "$L2_URLS" | jq -r 'keys[]'); do
  # Get the rpc url
  rpc=$(echo "$L2_URLS" | jq -r --arg k "$key" '.[$k].rpc')
  if [[ -z "$rpc" || "$rpc" == "null" ]]; then
    echo "ERROR: $key rpc is empty"
    error=1
    continue
  fi

  # Get the timestamp of the latest block
  block=$(cast block latest --rpc-url "$rpc" --json)
  if [[ -z "$block" || "$block" == "null" ]]; then
    echo "ERROR: $key unable to retrieve the last block"
    error=1
    continue
  fi

  # Retrieve block number and timestamp
  hex_block_number=$(echo "$block" | jq -r '.number')
  if [[ -z "$hex_block_number" || "$hex_block_number" == "null" ]]; then
    echo "ERROR: $key response missing block number"
    error=1
    continue
  fi
  block_number=$((hex_block_number))

  hex_ts=$(echo "$block" | jq -r '.timestamp')
  if [[ -z "$hex_ts" || "$hex_ts" == "null" ]]; then
    echo "ERROR: $key response missing block timestamp"
    error=1
    continue
  fi
  ts=$((hex_ts))

  # Check that the block is not too old
  now=$(date +%s)
  dt=$((now - ts))
  if [[ "$dt" -gt "$stuck_threshold_seconds" ]]; then
    echo "ERROR: $key block number is stuck at block number $block_number"
    error=1
  fi
done

exit "$error"
