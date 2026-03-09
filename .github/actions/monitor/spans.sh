#!/usr/bin/env bash
set -euo pipefail

# This script monitors span progress in a Polygon PoS devnet.
# Usage: ./spans.sh <enclave_name>
# Example: ./spans.sh pos

# Source logging library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"

log_info "Monitoring span progress"

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

target="2"
log_info "Using target span id: ${target}"

# Monitor span progress
num_steps=100
for step in $(seq 1 "${num_steps}"); do
  log_info "Check ${step}/${num_steps}"

  SPAN_ID=$(curl -s "${api_url}/bor/spans/latest" | jq --raw-output '.span.id')
  log_info "Got latest span id: ${SPAN_ID}"
  if [[ "${SPAN_ID}" =~ ^[0-9]+$ ]] && [[ "${SPAN_ID}" -ge "${target}" ]]; then
    log_info "Target span id reached" "target=${target}"
    exit 0
  fi
  sleep 5
done

# If the code reaches here, the target was not met within the allowed steps
log_error "Target span id has not been reached" "target=${target}"
exit 1
