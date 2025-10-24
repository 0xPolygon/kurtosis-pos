#!/usr/bin/env bash

# Check that milestones are progressing on Heimdall.
# Milestones should be produced every 10 blocks maximum, which is roughly every 10 seconds, assuming a one second block time.
# Most of the time, they are produced every 2 blocks.

# Threshold, in seconds, after which a milestone is considered stuck.
stuck_threshold_seconds=60

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

  # Get the last milestone
  milestone=$(curl -s "$heimdall_api/milestones/latest" | jq -r '.milestone')
  if [[ -z "$milestone" || "$milestone" == "null" ]]; then
    echo "ERROR: $key unable to retrieve the last milestone"
    error=1
    continue
  fi

  # Get milestone id and timestamp
  id=$(echo "$milestone" | jq -r '.milestone_id')
  if [[ -z "$id" || "$id" == "null" ]]; then
    echo "ERROR: $key response missing milestone id"
    error=1
    continue
  fi

  ts=$(echo "$milestone" | jq -r '.timestamp')
  if [[ -z "$ts" || "$ts" == "null" ]]; then
    echo "ERROR: $key response missing milestone timestamp"
    error=1
    continue
  fi

  # Check that the milestone is not too old
  now=$(date +%s)
  dt=$((now - ts))
  if [[ "$dt" -gt "$stuck_threshold_seconds" ]]; then
    echo "ERROR: $key milestones is stuck at id $id"
    error=1
    continue
  fi
done

exit "$error"
