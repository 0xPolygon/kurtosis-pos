#!/usr/bin/env bash

# Check that checkpoints are progressing on Heimdall.
# Checkpoints should be produced every 256 blocks, which is roughly every 256 seconds, assuming a one second block time.

# Threshold, in seconds, after which a checkpoint is considered stuck.
threshold_seconds=400

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

  # Fetch the last checkpoint
  checkpoint=$(curl -s "$heimdall_api/checkpoints/latest" | jq -r '.checkpoint')
  if [[ -z "$checkpoint" || "$checkpoint" == "null" ]]; then
    echo "ERROR: $key unable to retrieve the last milestone"
    error=1
    continue
  fi

  # Retrieve checkpoint id and timestamp
  id=$(echo "$checkpoint" | jq -r '.id')
  ts=$(echo "$checkpoint" | jq -r '.timestamp')

  # Check that the checkpoint is not too old
  now=$(date +%s)
  dt=$((now - ts))
  if [[ "$dt" -gt "$threshold_seconds" ]]; then
    echo "ERROR: $key checkpoint is stuck at id $id"
    error=1
  fi
done

exit "$error"
