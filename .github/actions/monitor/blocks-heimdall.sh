#!/usr/bin/env bash
set -euo pipefail

# This script monitors Heimdall block progress in a Polygon PoS devnet.
# Usage: ./blocks-heimdall.sh <enclave_name> [first|all]
# Example: ./blocks-heimdall.sh pos first  # Check only the first CL node
# Example: ./blocks-heimdall.sh pos all    # Check all CL nodes (default)

# Source logging library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"

# Function to monitor a single CL node
monitor_cl() {
  local cl_entry="$1"
  local enclave_name="$2"
  local target="$3"
  local cl_name="${cl_entry%%--*}"

  log_info "Checking CL node: ${cl_name}"

  local rpc_url
  rpc_url=$(kurtosis port print "${enclave_name}" "${cl_name}" rpc)
  log_info "Using rpc url: ${rpc_url}"

  local num_steps=100
  local LATEST_BLOCK=0

  for step in $(seq 1 "${num_steps}"); do
    log_info "Check ${step}/${num_steps} for ${cl_name}"

    LATEST_BLOCK=$(curl -s "${rpc_url}/status" | jq --raw-output '.result.sync_info.latest_block_height')
    log_info "Got block height: ${LATEST_BLOCK}"

    if [[ "${LATEST_BLOCK}" -ge "${target}" ]]; then
      break
    fi

    sleep 5
  done

  if [[ "${LATEST_BLOCK}" -lt "${target}" ]]; then
    log_error "Target block height not reached for ${cl_name}" "target=${target}"
    return 1
  fi

  log_info "Target block height reached for ${cl_name}" "target=${target}"
  return 0
}

log_info "Monitoring Heimdall block progress"

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

# Get CL node names (exclude rabbitmq services)
if [[ "${check_mode}" == "first" ]]; then
  cl_names=$(kurtosis enclave inspect "${enclave_name}" | awk '/l2-cl/ && !/rabbitmq/ && /RUNNING/ {print $2 "--" $1}' | head -n 1)
else
  cl_names=$(kurtosis enclave inspect "${enclave_name}" | awk '/l2-cl/ && !/rabbitmq/ && /RUNNING/ {print $2 "--" $1}')
fi
if [[ -z "${cl_names}" ]]; then
  log_error "No running l2-cl services found in enclave ${enclave_name}"
  exit 1
fi
log_info "Found CL node(s): ${cl_names}"

target="40"
log_info "Using target: ${target}"

# Monitor block progress for each CL node in parallel
declare -a pids=()
declare -a cl_array=()

# Convert cl_names to array
while IFS= read -r cl_entry; do
  cl_array+=("${cl_entry}")
done <<< "${cl_names}"

# Launch monitoring jobs in parallel
for cl_entry in "${cl_array[@]}"; do
  monitor_cl "${cl_entry}" "${enclave_name}" "${target}" &
  pids+=($!)
done

# Wait for all background jobs and collect exit codes
failed=0
for pid in "${pids[@]}"; do
  if ! wait "${pid}"; then
    failed=1
  fi
done

# Check if any CL node failed
if [[ "${failed}" -eq 1 ]]; then
  log_error "One or more CL nodes failed to reach target block height" "target=${target}"
  exit 1
fi

log_info "All CL nodes have reached target block height" "target=${target}"
exit 0
