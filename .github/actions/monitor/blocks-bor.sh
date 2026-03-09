#!/usr/bin/env bash
set -euo pipefail

# This script monitors block progress in a Polygon PoS devnet.
# Usage: ./blocks-bor.sh <docker_network> [target_block]
# Example: ./blocks-bor.sh kt-pos 100

# Source libraries
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/log.sh"
source "${SCRIPT_DIR}/lib/docker.sh"

# Function to monitor an EL node
monitor_el_node() {
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
  local latest_block=0
  local finalized_block=0

  for step in $(seq 1 "${num_steps}"); do
    log_info "Check ${step}/${num_steps} for ${rpc_name}"

    latest_block=$(cast bn --rpc-url "${rpc_url}")
    finalized_block=$(cast bn finalized --rpc-url "${rpc_url}")
    log_info "Got block height: latest=${latest_block}, finalized=${finalized_block}"
    if [[ "${latest_block}" -ge "${target}" && "${finalized_block}" -ge "${target}" ]]; then
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
  if [[ "${latest_block}" -lt "${target}" || "${finalized_block}" -lt "${target}" ]]; then
    log_error "Target block height has not been reached for ${rpc_name}" "target=${target}"
    return 1
  fi

  log_info "Target block height reached for all block types (latest and finalized) for ${rpc_name}" "target=${target}"
  return 0
}

log_info "Monitoring Bor block progress"

# Validate input parameters
docker_network=${1:-"kt-pos"}
if [[ -z "${docker_network}" ]]; then
  log_error "Docker network name must be provided"
  exit 1
fi
log_info "Using docker network: ${docker_network}"

# A sprint is 16 blocks, so 40 blocks should be enough to see progress.
# This can be overridden by providing a second argument.
target=${2:-"40"}
if [[ -z "${target}" ]]; then
  log_error "Target block height must be provided"
  exit 1
fi
log_info "Using target block height: ${target}"

# Get EL containers
containers=$(get_el_containers "${docker_network}")
log_info "Found container(s): ${containers}"

declare -a pids=()
declare -a container_array=()
while IFS= read -r container; do
  container_array+=("${container}")
done <<< "${containers}"

# Monitor block progress for each container, in parallel
for container in "${container_array[@]}"; do
  monitor_el_node "${container}" "${target}" &
  pids+=($!)
done

failed=0
for pid in "${pids[@]}"; do
  if ! wait "${pid}"; then
    failed=1
  fi
done

# Check if any EL node failed
if [[ "${failed}" -eq 1 ]]; then
  log_error "One or more EL nodes failed to reach target block height" "target=${target}"
  exit 1
fi

log_info "All EL nodes have reached target block height" "target=${target}"
exit 0
