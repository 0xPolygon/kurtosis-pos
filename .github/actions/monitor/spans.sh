#!/usr/bin/env bash
set -euo pipefail

# Monitor span progress in a Polygon PoS devnet.
# Usage: ./spans.sh <enclave_name> [delta]
#   delta — how far the latest span id must advance past its current
#           value (default 1). On a fresh deploy current is 0 (or the
#           genesis span), so any progress proves bor → heimdall span
#           rotation works. On a restored devnet current is whatever
#           the snapshot captured.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"
source "${SCRIPT_DIR}/resolve-url.sh"

log_info "Monitoring span progress"

enclave_name=${1:-"pos"}
delta=${2:-"1"}
log_info "Using enclave name: ${enclave_name}"

api_url=$(resolve_l2_cl_api_url "${enclave_name}")
log_info "Using API url: ${api_url}"

baseline=$(curl -sf "${api_url}/bor/spans/latest" 2>/dev/null | jq -r '.span.id // 0')
[[ "${baseline}" =~ ^[0-9]+$ ]] || baseline=0
target=$((baseline + delta))
log_info "Baseline span id=${baseline}, target=${target}"

num_steps=100
for step in $(seq 1 "${num_steps}"); do
  log_info "Check ${step}/${num_steps}"
  span_id=$(curl -sf "${api_url}/bor/spans/latest" 2>/dev/null | jq -r '.span.id // 0')
  log_info "Got latest span id: ${span_id:-?}"
  if [[ "${span_id:-}" =~ ^[0-9]+$ ]] && [[ "${span_id}" -ge "${target}" ]]; then
    log_info "Target span id reached" "target=${target}"
    exit 0
  fi
  sleep 5
done

log_error "Target span id has not been reached" "target=${target}"
exit 1
