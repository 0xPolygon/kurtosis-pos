#!/usr/bin/env bash
set -euo pipefail

# This script monitors checkpoints progress in a Polygon PoS devnet.
# Usage: ./checkpoints.sh <docker_network>
# Example: ./checkpoints.sh kt-pos

# Source libraries
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/log.sh"
source "${SCRIPT_DIR}/lib/docker.sh"

log_info "Monitoring checkpoints progress"

# Validate input parameters
docker_network=${1:-"kt-pos"}
if [[ -z "${docker_network}" ]]; then
  log_error "Docker network name must be provided"
  exit 1
fi
log_info "Using docker network: ${docker_network}"

api_url=$(get_any_cl_api_url "${docker_network}")
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
