#!/usr/bin/env bash
set -euo pipefail

# Monitor Heimdall block progress in a Polygon PoS devnet.
# Usage: ./blocks-heimdall.sh <enclave_name> [first|all] [delta]
# Example: ./blocks-heimdall.sh pos first       # Check only the first CL node
# Example: ./blocks-heimdall.sh pos all         # Check all CL nodes (default)
# Example: ./blocks-heimdall.sh restored all 40 # Require +40 blocks past baseline
#
# The target is computed per-CL as `baseline + delta`, where `baseline` is the
# latest block height at startup. On a fresh deploy baseline=0 so the target
# matches the historical absolute behaviour. On a restored devnet the baseline
# is whatever was in the snapshot, and the script proves the chain is still
# advancing.

# Source helpers
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"
source "${SCRIPT_DIR}/resolve-url.sh"

# Function to monitor a single CL node
monitor_cl() {
  local cl_name="$1"
  local rpc_url="$2"
  local delta="$3"

  log_info "Checking CL node: ${cl_name}"
  log_info "Using rpc url: ${rpc_url}"

  local num_steps=100
  local LATEST_BLOCK=0

  # Capture baseline so the target is "current + delta".
  local baseline target
  baseline=$(curl -s "${rpc_url}/status" 2>/dev/null | jq --raw-output '.result.sync_info.latest_block_height // 0' 2>/dev/null || echo 0)
  [[ -z "${baseline}" || "${baseline}" == "null" ]] && baseline=0
  target=$((baseline + delta))
  log_info "Baseline for ${cl_name}: ${baseline}; target=${target}"

  for step in $(seq 1 "${num_steps}"); do
    log_info "Check ${step}/${num_steps} for ${cl_name}"

    # Tolerate transient curl/jq failures — treat as 0 so the loop retries
    # instead of being killed by set -e (and pipefail).
    LATEST_BLOCK=$(curl -s "${rpc_url}/status" 2>/dev/null | jq --raw-output '.result.sync_info.latest_block_height // 0' 2>/dev/null || echo 0)
    [[ -z "${LATEST_BLOCK}" || "${LATEST_BLOCK}" == "null" ]] && LATEST_BLOCK=0
    log_info "Got block height: ${LATEST_BLOCK}"

    if [[ "${LATEST_BLOCK}" -ge "${target}" ]]; then
      break
    fi

    sleep 5
  done

  if [[ "${LATEST_BLOCK}" -lt "${target}" ]]; then
    log_error "Target block height not reached for ${cl_name}" "target=${target}" "latest=${LATEST_BLOCK}"
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

# Number of additional blocks past the baseline that must land for the check
# to pass.
delta=${3:-"40"}
if ! [[ "${delta}" =~ ^[0-9]+$ ]] || [[ "${delta}" -le 0 ]]; then
  log_error "Delta must be a positive integer"
  exit 1
fi
log_info "Using delta: ${delta}"

# Get CL node names + URLs (`name|url` per line, exclude rabbitmq).
cl_entries=$(enumerate_l2_cl_services "${enclave_name}" "${check_mode}")
if [[ -z "${cl_entries}" ]]; then
  log_error "No running l2-cl services found in enclave ${enclave_name}"
  exit 1
fi
log_info "Found CL node(s):"
echo "${cl_entries}" | while read -r e; do log_info "  ${e}"; done

# Monitor block progress for each CL node in parallel
declare -a pids=()
declare -a cl_names=()

while IFS='|' read -r cl_name rpc_url; do
  [[ -z "${cl_name}" ]] && continue
  cl_names+=("${cl_name}")
  monitor_cl "${cl_name}" "${rpc_url}" "${delta}" &
  pids+=($!)
done <<< "${cl_entries}"

# Wait for all background jobs and collect exit codes
failed=0
declare -a failed_cls=()
for i in "${!pids[@]}"; do
  if ! wait "${pids[$i]}"; then
    failed=1
    failed_cls+=("${cl_names[$i]}")
  fi
done

# Check if any CL node failed
if [[ "${failed}" -eq 1 ]]; then
  log_error "CL nodes failed to reach target block height" "delta=${delta}" "cls=${failed_cls[*]}"
  exit 1
fi

log_info "All CL nodes have reached target block height" "delta=${delta}"
exit 0
