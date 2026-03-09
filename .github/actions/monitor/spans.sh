#!/usr/bin/env bash
set -euo pipefail

# This script monitors span progress in a Polygon PoS devnet.
# Usage: ./spans.sh <docker_network>
# Example: ./spans.sh kt-pos

# Source libraries
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/log.sh"
source "${SCRIPT_DIR}/lib/docker.sh"

# Validate input parameters
docker_network=${1:-"kt-pos"}
if [[ -z "${docker_network}" ]]; then
  log_error "Docker network name must be provided"
  exit 1
fi
target="2"
log_info "Monitoring span progress" "network=${docker_network}" "target=${target}"

# Get CL API URL
api_url=$(get_any_cl_api_url "${docker_network}")

# Monitor span progress
num_steps=100
for step in $(seq 1 "${num_steps}"); do
  span_id=$(curl -sS "${api_url}/bor/spans/latest" | jq --raw-output '.span.id')
  log_debug "Check" "step=${step}/${num_steps}" "span_id=${span_id}"
  if [[ "${span_id}" =~ ^[0-9]+$ ]] && [[ "${span_id}" -ge "${target}" ]]; then
    log_info "Devnet reached target span"
    exit 0
  fi
  sleep 5
done

log_error "Target span not reached" "target=${target}"
exit 1
