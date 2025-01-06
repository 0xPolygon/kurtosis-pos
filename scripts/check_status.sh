#!/usr/bin/env bash
set -euo pipefail

# Check the status of a Polygon PoS devnet.
# Display the number of peers of the first node (heimdall/bor).
# Also display the block height of the different chains (CL, L1 and L2).

print_usage() {
  echo "Usage: $0 [--monitor]"
  echo "  Without arguments - Print current devnet status once"
  echo "  --monitor         - Continuously monitor devnet status"
}

get_status() {
  local cl_peer_count el_peer_count cl_block_height l1_block_height l2_block_height
  cl_peer_count="$(curl --silent "${cl_rpc_url}/net_info" | jq '.result.peers | length')"
  # shellcheck disable=SC2116
  el_peer_count="$(echo $(( $(curl --silent -H "Content-Type: application/json" --data '{"jsonrpc": "2.0", "method": "net_peerCount", "params": [], "id": 1}' "${l2_rpc_url}" | jq --raw-output '.result') )))"
  cl_block_height="$(curl --silent "${cl_rpc_url}/status" | jq --raw-output '.result.sync_info.latest_block_height')"
  l1_block_height="$(cast bn --rpc-url "${l1_rpc_url}")"
  l2_block_height="$(cast bn --rpc-url "${l2_rpc_url}")"
  echo "${cl_peer_count} ${el_peer_count} ${cl_block_height} ${l1_block_height} ${l2_block_height}"
}

print_row() {
  local key="$1"
  local value="$2"
  printf "│ %-15s │ %5s │\n" "${key}" "${value}"
}

print_status() {
  read -r cl_peer_count el_peer_count cl_block_height l1_block_height l2_block_height <<< "${status}"

  echo "┌─────────────────┬───────┐"
  echo "│ Devnet Status   │ Value │"
  echo "├─────────────────┼───────┤"
  print_row "CL Peer Count" "${cl_peer_count}"
  print_row "EL Peer Count" "${el_peer_count}"
  echo "├─────────────────┼───────┤"
  print_row "CL Block Height" "${cl_block_height}"
  print_row "L1 Block Height" "${l1_block_height}"
  print_row "L2 Block Height" "${l2_block_height}"
  echo "└─────────────────┴───────┘"
}

monitor() {
  local timeout_seconds=60
  local check_rate_seconds=10
  echo "- Timeout: ${timeout_seconds}s"
  echo "- Check Rate: ${check_rate_seconds}s"
  echo

  local start_time
  start_time="$(date +%s)"
  local previous_cl_height=0
  local previous_l1_height=0
  local previous_l2_height=0

  while true; do
    local current_time
    current_time="$(date +%s)"
    if (( current_time - start_time >= timeout_seconds )); then
      echo "Timeout reached. Exiting monitor."

      local error=false
      if (( previous_cl_height < 10 )); then
        echo "Error: CL chain has not progressed enough."
        error=true
      fi
      if (( previous_l1_height < 10 )); then
        echo "Error: L1 chain has not progressed enough."
        error=true
      fi
      if (( previous_l2_height < 10 )); then
        echo "Error: L2 chain has not progressed enough."
        error=true
      fi
      if "${error}"; then
        exit 1
      fi
    fi

    status="$(get_status)"
    read -r cl_peer_count el_peer_count cl_block_height l1_block_height l2_block_height <<< "${status}"

    # CL, L1 and L2 block heights.
    if (( cl_block_height > previous_cl_height )); then
      diff=$((cl_block_height - previous_cl_height))
      echo "✅ CL: ${previous_cl_height} -> ${cl_block_height} (+${diff})"
    else
      echo "❌ CL block height has not progressed: ${cl_block_height}"
    fi

    if (( l1_block_height > previous_l1_height )); then
      diff=$((l1_block_height - previous_l1_height))
      echo "✅ L1: $previous_l1_height -> $l1_block_height (+${diff})"
    else
      echo "❌ L1 block height has not progressed: ${l1_block_height}"
    fi

    if (( l2_block_height > previous_l2_height )); then
      diff=$((l2_block_height - previous_l2_height))
      echo "✅ L2: $previous_l2_height -> $l2_block_height (+${diff})"
    else
      echo "❌ L2 block height has not progressed: ${l2_block_height}"
    fi

    previous_cl_height="${cl_block_height}"
    previous_l1_height="${l1_block_height}"
    previous_l2_height="${l2_block_height}"

    echo "---"
    sleep "${check_rate_seconds}"
  done
}

# Default mode is status.
mode="status"

# Check if an argument is provided
if [ $# -gt 0 ]; then
  case "$1" in
    --monitor)
      mode="monitor"
      ;;
    --help)
      print_usage
      exit 0
      ;;
    *)
      echo "Error: Invalid argument '$1'"
      print_usage
      exit 1
      ;;
  esac
fi

# Check the environment variables.
if [[ -z "${ENCLAVE}" ]]; then
  echo "Error: ENCLAVE environment variable is not set"
  exit 1
fi
echo "ENCLAVE: ${ENCLAVE}"
echo

# Get the RPC urls.
l1_rpc_url="http://$(kurtosis --cli-log-level info port print "${ENCLAVE}" el-1-geth-lighthouse rpc)"
if [ -z "${l1_rpc_url}" ]; then
  echo "Error: l1_rpc_url variable is empty, is the l1 rpc properly running?"
  exit 1
fi

cl_rpc_url="$(kurtosis --cli-log-level info port print "${ENCLAVE}" heimdall-0 rpc)"
if [ -z "${cl_rpc_url}" ]; then
  echo "Error: cl_rpc_url variable is empty, is the heimdall node rpc running?"
  exit 1
fi

l2_rpc_url="$(kurtosis --cli-log-level info port print "${ENCLAVE}" bor-0 rpc)"
if [ -z "${l2_rpc_url}" ]; then
  echo "Error: l2_rpc_url variable is empty, is the bor node rpc running?"
  exit 1
fi

# Main execution based on mode
case "$mode" in
  monitor)
    echo "Starting continuous chain height monitoring..."
    monitor
    ;;
  status)
    status="$(get_status)"
    print_status "${status}"
    ;;
esac
