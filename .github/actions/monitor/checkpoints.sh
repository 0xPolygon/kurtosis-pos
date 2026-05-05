#!/usr/bin/env bash
set -euo pipefail

# Monitor checkpoint progress in a Polygon PoS devnet.
# Usage: ./checkpoints.sh <enclave_name> [delta]
#   delta — how far ack_count must advance past its current value
#           (default 1). On a fresh deploy current=0, so target=1
#           matches the old behaviour. On a restored devnet current
#           is whatever was in the snapshot, so target=current+1
#           proves a fresh checkpoint landed post-restore.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"
source "${SCRIPT_DIR}/resolve-url.sh"

log_info "Monitoring checkpoints progress"

enclave_name=${1:-"pos"}
delta=${2:-"1"}
log_info "Using enclave name: ${enclave_name}"

api_url=$(resolve_l2_cl_api_url "${enclave_name}")
log_info "Using API url: ${api_url}"

baseline=$(curl -sf "${api_url}/checkpoints/count" 2>/dev/null | jq -r '.ack_count // 0')
target=$((baseline + delta))
log_info "Baseline ack_count=${baseline}, target=${target}"

num_steps=100
for step in $(seq 1 "${num_steps}"); do
  log_info "Check ${step}/${num_steps}"
  count=$(curl -sf "${api_url}/checkpoints/count" 2>/dev/null | jq -r '.ack_count // 0')
  log_info "Got checkpoints count: ${count}"
  if [[ "${count}" -ge "${target}" ]]; then
    log_info "Target checkpoints reached" "target=${target}"
    exit 0
  fi
  sleep 5
done

log_error "Target checkpoints have not been reached" "target=${target}"
exit 1
