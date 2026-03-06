#!/usr/bin/env bash
set -euo pipefail

# This script monitors block progress in a Polygon PoS devnet.
# Usage: ./blocks.sh <docker_network> [first|all]
# Example: ./blocks.sh kt-pos first  # Check only the first RPC
# Example: ./blocks.sh kt-pos all    # Check all RPCs (default)

# Source libraries
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/log.sh"
source "${SCRIPT_DIR}/lib/docker.sh"

# Function to monitor a single RPC
monitor_rpc() {
  local container="$1"
  local target="$2"
  local rpc_name="${container%%--*}"

  log_info "Checking RPC: ${rpc_name}"

  local host_port
  host_port=$(docker port "${container}" 8545 2>/dev/null | head -1 | sed 's/0.0.0.0/127.0.0.1/')
  if [[ -z "${host_port}" ]]; then
    log_error "No published port 8545 for container ${container}"
    return 1
  fi
  local rpc_url="http://${host_port}"
  log_info "Using rpc url: ${rpc_url}"

  local num_steps=100
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
docker_network=${1:-"kt-pos"}
if [[ -z "${docker_network}" ]]; then
  log_error "Docker network name must be provided"
  exit 1
fi
log_info "Using docker network: ${docker_network}"

check_mode=${2:-"all"}
if [[ "${check_mode}" != "first" && "${check_mode}" != "all" ]]; then
  log_error "Check mode must be 'first' or 'all'"
  exit 1
fi
log_info "Using check mode: ${check_mode}"

# Get EL containers
if [[ "${check_mode}" == "first" ]]; then
  containers=$(get_el_containers "${docker_network}" | head -n 1)
else
  containers=$(get_el_containers "${docker_network}")
fi
log_info "Found container(s): ${containers}"

target="40" # a sprint is 16 blocks so 40 is ~2.5 sprints, which should be enough to see progress
log_info "Using target: ${target}"

# Monitor block progress for each RPC in parallel
declare -a pids=()
declare -a container_array=()

while IFS= read -r container; do
  container_array+=("${container}")
done <<< "${containers}"

# Launch monitoring jobs in parallel
for container in "${container_array[@]}"; do
  monitor_rpc "${container}" "${target}" &
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
