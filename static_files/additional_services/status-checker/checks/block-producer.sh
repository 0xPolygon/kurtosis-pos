#!/usr/bin/env bash

# Check that the last 30 blocks are produced by the expected block producer.

# shellcheck source=static_files/additional_services/status-checker/checks/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

# shellcheck source=static_files/additional_services/status-checker/checks/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

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

  # Get the current span start and end blocks
  start_block=$(echo "$current_span" | jq -r '.start_block')
  if [[ -z "$start_block" || "$start_block" == "null" ]]; then
    echo "ERROR: $key missing start block for span $current_span_id"
    error=1
    continue
  fi

  end_block=$(echo "$current_span" | jq -r '.end_block')
  if [[ -z "$end_block" || "$end_block" == "null" ]]; then
    echo "ERROR: $key missing end block for span $current_span_id"
    error=1
    continue
  fi

  # Get the previous span - the one before the current one
  previous_span_id=$((current_span_id - 1))
  previous_span=$(curl -s "$heimdall_api/bor/spans/$previous_span_id" | jq -r '.span')
  if [[ -z "$previous_span" || "$previous_span" == "null" ]]; then
    echo "ERROR: $key unable to retrieve the previous span $previous_span_id"
    error=1
    continue
  fi

  # Check the last 30 blocks.
  last_block_number=$(cast bn --rpc-url "$rpc")
  start_block_number=$((last_block_number - 30 + 1))
  for n in $(seq $start_block_number $last_block_number); do
    # Check if the block is in the current span
    # If not, we assume the block is in the previous span
    span=""
    if [[ "$n" -gt "$start_block" && "$n" -lt "$end_block" ]]; then
      span="$current_span"
    else
      span="$previous_span"
    fi

    # Get the block producer from Bor
    block_hex=$(printf '0x%x' "$n")
    producer=$(cast rpc bor_getAuthor "$block_hex" --rpc-url "$rpc" | tr '[:upper:]' '[:lower:]' | sed 's/"//g')

    # Get the expected block producer from Heimdall
    expected_producer=$(echo "$span" | jq -r '.span.selected_producers[0].signer' | tr '[:upper:]' '[:lower:]')

    # Compare the producers
    if [[ "$producer" != "$expected_producer" ]]; then
      echo "❌ $key block $n producer mismatch: got $producer, expected $expected_producer"
      error=1
      continue
    fi
  done
done

exit "$error"
