#!/usr/bin/env bash

# This script checks that the last 15 blocks are produced by the expected block producer.

# shellcheck source=static_files/additional_services/status-checker/checks/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

error=0

for key in $(echo "$L2_URLS" | jq -r 'keys[]'); do
  rpc=$(echo "$L2_URLS" | jq -r --arg k "$key" '.[$k].rpc')
  heimdall_api=$(echo "$L2_URLS" | jq -r --arg k "$key" '.[$k].heimdall')

  # Get the current span id.
  latest_span_id=$(curl -s "$heimdall_api/bor/spans/latest" | jq -r '.span.id')
  current_span_id=$((latest_span_id - 1))
  current_span=$(curl -s "$heimdall_api/bor/spans/$current_span_id")
  span_start=$(echo "$current_span" | jq -r '.span.start_block')
  span_end=$(echo "$current_span" | jq -r '.span.end_block')

  # Check the last 20 blocks.
  last_block_number=$(cast bn --rpc-url "$rpc")
  start_block_number=$((last_block_number - 19))
  for block_number in $(seq $start_block_number $last_block_number); do
    # Check if the current block is in the span.
    if [[ "$block_number" -lt "$span_start" || "$block_number" -gt "$span_end" ]]; then
      echo "$key block $block_number is outside current span ($span_start-$span_end), skipping"
      continue
    fi

    # Fetch the block producer from Bor.
    block_hex=$(printf '0x%x' "$block_number")
    producer=$(cast rpc bor_getAuthor "$block_hex" --rpc-url "$rpc" | tr '[:upper:]' '[:lower:]' | sed 's/"//g')

    # Fetch the expected block producer from Heimdall.
    expected_producer=$(echo "$current_span" | jq -r '.span.validator_set.proposer.signer' | tr '[:upper:]' '[:lower:]')

    if [[ "$producer" != "$expected_producer" ]]; then
      echo "❌ $key block $block_number producer mismatch: got $producer, expected $expected_producer"
      error=1
    fi
  done
done

exit "$error"
