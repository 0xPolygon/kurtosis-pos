#!/usr/bin/env bash

# shellcheck source=static_files/additional_services/status-checker/checks/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

now=$(date +%s)
error=0

for key in $(echo $L2_URLS | jq -r 'keys[]'); do
  rpc=$(echo $L2_URLS | jq -r --arg k "$key" '.[$k].rpc')

  hex_ts=$(cast block --rpc-url "$rpc" --json | jq -r '.timestamp')
  block_ts=$((hex_ts))
  now=$(date +%s)
  dt=$((now - block_ts))

  if [ $age -gt 120 ]; then
    echo "ERROR: $key block number is stuck"
    error=1
  fi
done

exit "$error"
