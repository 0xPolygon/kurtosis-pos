#!/usr/bin/env bash
set -euo pipefail

# This script monitors block progress in a Polygon PoS devnet.
# Usage: ./blocks.sh <enclave_name> [first|all]
# Example: ./blocks.sh pos first  # Check only the first RPC
# Example: ./blocks.sh pos all    # Check all RPCs (default)

# Source logging library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"

# Function to monitor a single RPC
monitor_rpc() {
  local rpc_entry="$1"
  local enclave_name="$2"
  local target="$3"
  local rpc_name="${rpc_entry%%--*}"

  log_info "Checking RPC: ${rpc_name}"

  local rpc_url
  rpc_url=$(kurtosis port print "${enclave_name}" "${rpc_name}" rpc)
  log_info "Using rpc url: ${rpc_url}"

  local num_steps=20
  local gas_price_factor=1
  local LATEST_BLOCK=0
  local FINALIZED_BLOCK=0

  for step in $(seq 1 "${num_steps}"); do
    log_info "Check ${step}/${num_steps} for ${rpc_name}"

    LATEST_BLOCK=$(cast bn --rpc-url "${rpc_url}")
    FINALIZED_BLOCK=$(cast bn finalized --rpc-url "${rpc_url}")
    log_info "Got blocks: latest=${LATEST_BLOCK}, finalized=${FINALIZED_BLOCK}"
    if [[ "${LATEST_BLOCK}" -ge "${target}" && "${FINALIZED_BLOCK}" -ge "${target}" ]]; then
      break
    fi

    # Send a transaction to stimulate progress
    local gas_price
    gas_price=$(cast gas-price --rpc-url "$rpc_url")
    gas_price=$(bc -l <<< "$gas_price * $gas_price_factor" | sed 's/\..*//')

    log_info "Sending a test transaction"
    set +e
    cast send \
      --legacy \
      --timeout 30 \
      --async \
      --gas-price "${gas_price}" \
      --rpc-url "${rpc_url}" \
      --private-key "0xd40311b5a5ca5eaeb48dfba5403bde4993ece8eccf4190e98e19fcd4754260ea" \
      --gas-limit 100000 \
      --create 0x6001617000526160006110005ff05b6109c45a111560245761600061100080833c600e565b50
    local result="$?"
    set -e
    if [[ "${result}" -eq 0 ]]; then
      gas_price_factor=1
    else
      gas_price_factor=$(bc -l <<< "$gas_price_factor * 1.5")
    fi

    sleep 5
  done

  # Check if target was reached for this RPC
  if [[ "${LATEST_BLOCK}" -lt "${target}" || "${FINALIZED_BLOCK}" -lt "${target}" ]]; then
    log_error "Target blocks have not been reached for ${rpc_name}"
    return 1
  fi

  log_info "Target blocks reached for all block types (latest and finalized) for ${rpc_name}"
  return 0
}

log_info "Monitoring block progress"

# Validate input parameters
enclave_name=${1:-"pos"}
if [[ -z "${enclave_name}" ]]; then
  log_error "Enclave name must be provided"
  exit 1
fi
log_info "Using enclave name: ${enclave_name}"

check_mode=${2:-"all"}
if [[ "${check_mode}" != "first" && "${check_mode}" != "all" ]]; then
  log_error "Check mode must be 'first' or 'all'"
  exit 1
fi
log_info "Using check mode: ${check_mode}"

# Get RPC names
if [[ "${check_mode}" == "first" ]]; then
  rpc_names=$(kurtosis enclave inspect "${enclave_name}" | awk '/l2-el/ && /RUNNING/ {print $2 "--" $1}' | head -n 1)
else
  rpc_names=$(kurtosis enclave inspect "${enclave_name}" | awk '/l2-el/ && /RUNNING/ {print $2 "--" $1}')
fi
if [[ -z "${rpc_names}" ]]; then
  log_error "No running l2-el services found in enclave ${enclave_name}"
  exit 1
fi
log_info "Found RPC(s): ${rpc_names}"

target="100"
log_info "Using target: ${target}"

# Monitor block progress for each RPC in parallel
declare -a pids=()
declare -a rpc_array=()

# Convert rpc_names to array
while IFS= read -r rpc_entry; do
  rpc_array+=("${rpc_entry}")
done <<< "${rpc_names}"

# Launch monitoring jobs in parallel
for rpc_entry in "${rpc_array[@]}"; do
  monitor_rpc "${rpc_entry}" "${enclave_name}" "${target}" &
  pids+=($!)
done

# Wait for all background jobs and collect exit codes
failed=0
for pid in "${pids[@]}"; do
  if ! wait "${pid}"; then
    failed=1
  fi
done

# Check if any RPC failed
if [[ "${failed}" -eq 1 ]]; then
  log_error "One or more RPCs failed to reach target blocks"
  exit 1
fi

log_info "All RPCs have reached target blocks"
exit 0
