#!/usr/bin/env bash
set -euo pipefail

# Monitor Bor block progress in a Polygon PoS devnet.
# Usage: ./blocks-bor.sh <enclave_name> [first|all]
# Example: ./blocks-bor.sh pos first  # Check only the first RPC
# Example: ./blocks-bor.sh pos all    # Check all RPCs (default)

# Source helpers
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"
source "${SCRIPT_DIR}/resolve-url.sh"

# Function to monitor a single RPC
monitor_rpc() {
  local rpc_name="$1"
  local rpc_url="$2"
  local target="$3"

  log_info "Checking RPC: ${rpc_name}"
  log_info "Using rpc url: ${rpc_url}"

  local num_steps=100
  local gas_price_factor=1
  local LATEST_BLOCK=0
  local FINALIZED_BLOCK=0

  for step in $(seq 1 "${num_steps}"); do
    log_info "Check ${step}/${num_steps} for ${rpc_name}"

    # Tolerate transient RPC errors (e.g. "finalized block not found" before the
    # chain has reached the finality threshold) — treat as 0 so the loop retries
    # instead of being killed by set -e.
    LATEST_BLOCK=$(cast bn --rpc-url "${rpc_url}" 2>/dev/null || echo 0)
    FINALIZED_BLOCK=$(cast bn finalized --rpc-url "${rpc_url}" 2>/dev/null || echo 0)
    log_info "Got block height: latest=${LATEST_BLOCK}, finalized=${FINALIZED_BLOCK}"
    if [[ "${LATEST_BLOCK}" -ge "${target}" && "${FINALIZED_BLOCK}" -ge "${target}" ]]; then
      break
    fi

    # Send a transaction to stimulate progress
    local gas_price
    gas_price=$(cast gas-price --rpc-url "$rpc_url" 2>/dev/null || echo 0)
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
    log_error "Target block height has not been reached for ${rpc_name}" "target=${target}"
    return 1
  fi

  log_info "Target block height reached for all block types (latest and finalized) for ${rpc_name}" "target=${target}"
  return 0
}

log_info "Monitoring Bor block progress"

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

# Get RPC names + URLs (`name|url` per line).
rpc_entries=$(enumerate_l2_el_services "${enclave_name}" "${check_mode}")
if [[ -z "${rpc_entries}" ]]; then
  log_error "No running l2-el services found in enclave ${enclave_name}"
  exit 1
fi
log_info "Found RPC(s):"
echo "${rpc_entries}" | while read -r e; do log_info "  ${e}"; done

target="40" # a sprint is 16 blocks so 40 is ~2.5 sprints, which should be enough to see progress
log_info "Using target: ${target}"

# Monitor block progress for each RPC in parallel
declare -a pids=()
declare -a rpc_names=()

while IFS='|' read -r rpc_name rpc_url; do
  [[ -z "${rpc_name}" ]] && continue
  rpc_names+=("${rpc_name}")
  monitor_rpc "${rpc_name}" "${rpc_url}" "${target}" &
  pids+=($!)
done <<< "${rpc_entries}"

# Wait for all background jobs and collect exit codes
failed=0
declare -a failed_rpcs=()
for i in "${!pids[@]}"; do
  if ! wait "${pids[$i]}"; then
    failed=1
    failed_rpcs+=("${rpc_names[$i]}")
  fi
done

# Check if any RPC failed
if [[ "${failed}" -eq 1 ]]; then
  log_error "RPCs failed to reach target block height" "target=${target}" "rpcs=${failed_rpcs[*]}"
  exit 1
fi

log_info "All RPCs have reached target block height" "target=${target}"
exit 0
