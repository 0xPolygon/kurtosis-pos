#!/usr/bin/env bash

# This script checks that each Bor node is aligned with the latest Heimdall milestone.

# shellcheck source=static_files/additional_services/status-checker/checks/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

error=0

for key in $(echo "$L2_URLS" | jq -r 'keys[]'); do
  # Fetch the latest milestone from Heimdall.
  heimdall_api=$(echo "$L2_URLS" | jq -r --arg k "$key" '.[$k].heimdall')
  latest_milestone=$(curl -s "$heimdall_api/milestones/latest" | jq -r '.milestone')
  milestone_id=$(echo "$latest_milestone" | jq -r '.milestone_id')
  block_number=$(echo "$latest_milestone" | jq -r '.end_block')
  block_hash_base64=$(echo "$latest_milestone" | jq -r '.hash')
  block_hash=$(echo "$block_hash_base64" | base64 --decode | xxd -p | tr -d '\n' | sed 's/^/0x/')
  block_hash_lc=${block_hash,,}

  # Fetch the Bor block at the milestone's end_block.
  bor_rpc=$(echo "$L2_URLS" | jq -r --arg k "$key" '.[$k].rpc')
  local_block_hash=$(cast block "$block_number" --rpc-url "$bor_rpc" --json | jq -r '.hash')
  local_block_hash_lc=${local_block_hash,,}

  # Compare Bor's block hash with the milestone hash.
  if [[ "$local_block_hash_lc" != "$block_hash_lc" ]]; then
    # Report an error if they do not match (node is diverged / on a wrong fork).
    echo "ERROR: $key local block hash for block $block_number ($local_block_hash_lc) does not match expected block hash from milestone $milestone_id ($block_hash_lc)"
    error=1
  fi
done

exit "$error"
