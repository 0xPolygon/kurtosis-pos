#!/usr/bin/env bash
set -euo pipefail

# This script monitors checkpoints progress in a Polygon PoS devnet.
# Usage: ./checkpoints.sh <enclave_name>
# Example: ./checkpoints.sh pos

# Source logging library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"

log_info "Monitoring checkpoints progress"

# Validate input parameters
enclave_name=${1:-"pos"}
if [[ -z "${enclave_name}" ]]; then
  log_error "Enclave name must be provided"
  exit 1
fi
log_info "Using enclave name: ${enclave_name}"

cl_name="l2-cl-1-heimdall-v2-bor-validator"
log_info "Using CL node: ${cl_name}"

api_url=$(kurtosis port print "${enclave_name}" "${cl_name}" http)
log_info "Using API url: ${api_url}"

target="1"
log_info "Using target: ${target}"

# Monitor checkpoint progress
num_steps=100
gas_price_factor=1
for step in $(seq 1 "${num_steps}"); do
  log_info "Check ${step}/${num_steps}"

  CHECKPOINTS_COUNT=$(curl "${api_url}/checkpoints/count" | jq --raw-output '.ack_count')
  log_info "Got checkpoints count: ${CHECKPOINTS_COUNT}"
  if [[ "${CHECKPOINTS_COUNT}" -ge "${target}" ]]; then
    log_info "Target checkpoints reached"
    exit 0
  fi
  sleep 5
done

# If the code reaches here, the target was not met within the allowed steps
log_error "Target checkpoints have not been reached"
exit 1
