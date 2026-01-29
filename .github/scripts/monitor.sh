#!/usr/bin/env bash
set -euo pipefail

# This script monitors the progress of a blockchain rollup.
# Usage: ./monitor.sh <enclave_name>
# Example: ./monitor.sh pos

# Helper function to get the current timestamp
_timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

# Helper function to format key=value pairs
_format_fields() {
  local msg="$1"
  shift
  local fields=""
  for arg in "$@"; do
    fields="$fields $arg"
  done
  echo "$msg$fields"
}

# Logging functions
log_info() { echo "$(_timestamp) INFO $(_format_fields "$@")" >&2; }
log_error() { echo "$(_timestamp) ERROR $(_format_fields "$@")" >&2; }

log_info "Monitoring rollup progress"

# Validate input parameters
enclave_name=${1:-"pos"}
if [[ -z "${enclave_name}" ]]; then
  log_error "Enclave name must be provided"
  exit 1
fi
log_info "Using enclave name: ${enclave_name}"

rpc_name="l2-el-1-bor-heimdall-v2-validator"
log_info "Using rpc name: ${rpc_name}"

rpc_url=$(kurtosis port print "${enclave_name}" "${rpc_name}" rpc)
log_info "Using rpc url: ${rpc_url}"

target="100"
log_info "Using target: ${target}"

# Monitor the rollup progress
num_steps=100
gas_price_factor=1
for step in $(seq 1 "${num_steps}"); do
  log_info "Check ${step}/${num_steps}"

  LATEST_BLOCK=$(cast bn --rpc-url "${rpc_url}")
  FINALIZED_BLOCK=$(cast bn finalized --rpc-url "${rpc_url}")
  log_info "Got blocks: latest=${LATEST_BLOCK}, finalized=${FINALIZED_BLOCK}"
  if [[ "${LATEST_BLOCK}" -ge "${target}" && "${FINALIZED_BLOCK}" -ge "${target}" ]]; then
    log_info "Target blocks reached for all block types (latest and finalized)"
    exit 0
  fi

  # Send a transaction to stimulate progress
  gas_price=$(cast gas-price --rpc-url "$rpc_url")
  gas_price=$(bc -l <<< "$gas_price * $gas_price_factor" | sed 's/\..*//')

  log_info "Sending a test transaction"
  cast send \
    --legacy \
    --timeout 30 \
    --gas-price "${gas_price}" \
    --rpc-url "${rpc_url}" \
    --private-key "0xd40311b5a5ca5eaeb48dfba5403bde4993ece8eccf4190e98e19fcd4754260ea" \
    --gas-limit 100000 \
    --create 0x6001617000526160006110005ff05b6109c45a111560245761600061100080833c600e565b50
  result="$?"
  if [[ "${result}" -eq 0 ]]; then
    gas_price_factor=1
  else
    gas_price_factor=$(bc -l <<< "$gas_price_factor * 1.5")
  fi

  sleep 5
done

# If the code reaches here, the target was not met within the allowed steps
"Target blocks have not been reached for all block types (latest and finalized)"
exit 1
