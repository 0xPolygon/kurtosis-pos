#!/usr/bin/env bash

# This check verifies that Heimdall is producing new checkpoints.
# Checkpoints should be produced every 256 blocks, which is roughly every 256 seconds, assuming a
# one second block time.

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

now=$(date +%s)
error=0

for key in $(echo "$L2_URLS" | jq -r 'keys[]'); do
  heimdall_api=$(echo "$L2_URLS" | jq -r --arg k "$key" '.[$k].heimdall')
  checkpoint_ts=$(curl -s "$heimdall_api/checkpoints/latest" | jq -r '.checkpoint.timestamp')

  now=$(date +%s)
  dt=$((now - checkpoint_ts))
  if [[ "$dt" -gt 400 ]]; then
    echo "ERROR: checkpoint is stuck"
    error=1
  fi
done

exit "$error"
