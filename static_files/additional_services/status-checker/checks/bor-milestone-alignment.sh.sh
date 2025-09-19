#!/usr/bin/env bash

# Check that each Bor node is aligned with the latest Heimdall milestone.

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

  # Get the rpc url
  rpc=$(echo "$L2_URLS" | jq -r --arg k "$key" '.[$k].rpc')
  if [[ -z "$rpc" || "$rpc" == "null" ]]; then
    echo "ERROR: $key rpc is empty"
    error=1
    continue
  fi

  # Get the last milestone
  milestone=$(curl -s "$heimdall_api/milestones/latest" | jq -r '.milestone')
  if [[ -z "$milestone" || "$milestone" == "null" ]]; then
    echo "ERROR: $key unable to retrieve the last milestone"
    error=1
    continue
  fi

  # Get milestone id, end block and hash
  id=$(echo "$milestone" | jq -r '.milestone_id')
  if [[ -z "$id" || "$id" == "null" ]]; then
    echo "ERROR: $key response missing milestone id"
    error=1
    continue
  fi

  end_block=$(echo "$milestone" | jq -r '.end_block')
  if [[ -z "$end_block" || "$end_block" == "null" ]]; then
    echo "ERROR: $key response missing milestone end block"
    error=1
    continue
  fi

  hash_base64=$(echo "$milestone" | jq -r '.hash')
  if [[ -z "$hash_base64" || "$hash_base64" == "null" ]]; then
    echo "ERROR: $key response missing milestone hash"
    error=1
    continue
  fi
  milestone_block_hash=$(echo "$hash_base64" | base64 --decode | xxd -p | tr -d '\n' | sed 's/^/0x/')
  milestone_block_hash_lc=${milestone_block_hash,,}

  # Get the Bor block at milestone's end_block
  bor_block=$(curl -s "$heimdall_api/bor/blocks/$end_block" | jq -r '.block')
  if [[ -z "$bor_block" || "$bor_block" == "null" ]]; then
    echo "ERROR: $key unable to retrieve the block $end_block"
    error=1
    continue
  fi

  # Get the Bor block hash
  bor_block_hash=$(echo "$bor_block" | jq -r '.hash')
  if [[ -z "$bor_block_hash" || "$bor_block_hash" == "null" ]]; then
    echo "ERROR: $key response missing block hash"
    error=1
    continue
  fi
  bor_block_hash_lc=${bor_block_hash,,}

  # Compare milestone block hash with Bor block hash
  # Report an error if they do not match (node is diverged / on a wrong fork)
  if [[ "$milestone_block_hash_lc" != "$bor_block_hash_lc" ]]; then
    echo "ERROR: $key bor block hash for block $end_block ($bor_block_hash_lc) does not match expected block hash from milestone $id ($milestone_block_hash_lc)"
    error=1
    continue
  fi
done

exit "$error"
