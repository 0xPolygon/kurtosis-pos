#!/usr/bin/env bash

# This script checks that milestones are progressing on Heimdall.
# Milestones should be produced every 10 blocks maximum, which is roughly every 10 seconds,
# assuming a one second block time. Most of the time, they are produced every 2 blocks.

# shellcheck source=static_files/additional_services/status-checker/checks/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

now=$(date +%s)
error=0

for key in $(echo "$L2_URLS" | jq -r 'keys[]'); do
  heimdall_api=$(echo "$L2_URLS" | jq -r --arg k "$key" '.[$k].heimdall')

  response=$(curl -s "$heimdall_api/milestones/latest")
  milestone_ts=$(echo "$response" | jq -r '.milestone.timestamp')
  if [[ -z "$milestone_ts" ]]; then
    echo "WARN: no milestone available yet"
    exit 0
  fi

  now=$(date +%s)
  dt=$((now - milestone_ts))
  if [[ "$dt" -gt 60 ]]; then
    echo "ERROR: milestone is stuck"
    error=1
  fi
done

exit "$error"
