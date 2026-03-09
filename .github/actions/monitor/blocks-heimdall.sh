#!/usr/bin/env bash
set -euo pipefail

# This script monitors Heimdall block progress in a Polygon PoS devnet.
# Usage: ./blocks-heimdall.sh <enclave_name> [target_block]
# Example: ./blocks-heimdall.sh pos 100

# Source libraries
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/log.sh"
source "${SCRIPT_DIR}/lib/docker.sh"

# Function to monitor a CL node
monitor_cl_node() {
  local container="$1"
  local target="$2"
  local host_port
  host_port=$(docker port "${container}" 1317 2>/dev/null | head -1 | sed 's/0.0.0.0/127.0.0.1/')
  if [[ -z "${host_port}" ]]; then
    log_error "No published port 1317" "container=${container}"
    return 1
  fi
  local api_url="http://${host_port}"

  local num_steps=100
  local latest_block=0

  for step in $(seq 1 "${num_steps}"); do
    latest_block=$(curl -s "${api_url}/status" | jq --raw-output '.latest_block_height')
    log_debug "Check" "container=${container}" "step=${step}/${num_steps}" "latest=${latest_block}"

    if [[ "${latest_block}" -ge "${target}" ]]; then
      break
    fi

    sleep 5
  done

  if [[ "${latest_block}" -lt "${target}" ]]; then
    log_error "Target block height not reached" "container=${container}" "target=${target}"
    return 1
  fi

  log_info "Target block height reached" "container=${container}" "target=${target}"
  return 0
}

# Validate input parameters
docker_network=${1:-"kt-pos"}
if [[ -z "${docker_network}" ]]; then
  log_error "Docker network name must be provided"
  exit 1
fi
target=${2:-"100"}
if [[ -z "${target}" ]]; then
  log_error "Target block height must be provided"
  exit 1
fi
log_info "Monitoring Heimdall block progress" "network=${docker_network}" "target=${target}"

# Get CL containers
containers=$(get_cl_containers "${docker_network}")

declare -a pids=()
declare -a container_array=()
while IFS= read -r container; do
  container_array+=("${container}")
done <<< "${containers}"
count=${#container_array[@]}
if [[ "${count}" -eq 1 ]]; then
  log_info "Found 1 container" "container=${container_array[0]}"
else
  log_info "Found ${count} containers" "containers=$(IFS=,; echo "${container_array[*]}")"
fi

# Monitor block progress for each container, in parallel
for container in "${container_array[@]}"; do
  monitor_cl_node "${container}" "${target}" &
  pids+=($!)
done

failed=0
for pid in "${pids[@]}"; do
  if ! wait "${pid}"; then
    failed=1
  fi
done

# Check if any CL node failed
if [[ "${failed}" -eq 1 ]]; then
  log_error "One or more containers failed to reach target block height" "target=${target}"
  exit 1
fi

log_info "Devnet reached target block height"
exit 0
