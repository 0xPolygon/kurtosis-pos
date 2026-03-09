#!/usr/bin/env bash
set -euo pipefail

# This script monitors span progress in a Polygon PoS devnet.
# Usage: ./spans.sh <enclave_name>
# Example: ./spans.sh pos

# Source logging library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/log.sh"

# Validate input parameters
enclave_name=${1:-"pos"}
if [[ -z "${enclave_name}" ]]; then
  log_error "Enclave name must be provided"
  exit 1
fi
target="2"
log_info "Monitoring span progress" "enclave=${enclave_name}" "target=${target}"

cl_name="l2-cl-1-heimdall-v2-bor-validator"
api_url=$(kurtosis port print "${enclave_name}" "${cl_name}" http)

# Monitor span progress
num_steps=100
for step in $(seq 1 "${num_steps}"); do
  SPAN_ID=$(curl -sS "${api_url}/bor/spans/latest" | jq --raw-output '.span.id')
  log_debug "Check" "step=${step}/${num_steps}" "span_id=${SPAN_ID}"
  if [[ "${SPAN_ID}" =~ ^[0-9]+$ ]] && [[ "${SPAN_ID}" -ge "${target}" ]]; then
    log_info "Devnet reached target span"
    exit 0
  fi
  sleep 5
done

# If the code reaches here, the target was not met within the allowed steps
log_error "Target span not reached" "target=${target}"
exit 1
