#!/usr/bin/env bash
set -euo pipefail

# This script monitors checkpoints progress in a Polygon PoS devnet.
# Usage: ./checkpoints.sh <docker_network>
# Example: ./checkpoints.sh kt-pos

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
target="1"
log_info "Monitoring checkpoints progress" "network=${docker_network}" "target=${target}"

# Get CL API URL
api_url=$(get_any_cl_api_url "${docker_network}")

# Monitor checkpoint progress
num_steps=100
for step in $(seq 1 "${num_steps}"); do
  CHECKPOINTS_COUNT=$(curl -sS "${api_url}/checkpoints/count" | jq --raw-output '.ack_count')
  log_debug "Check" "step=${step}/${num_steps}" "count=${CHECKPOINTS_COUNT}"
  if [[ "${CHECKPOINTS_COUNT}" -ge "${target}" ]]; then
    log_info "Devnet reached target checkpoints"
    exit 0
  fi
  sleep 5
done

# If the code reaches here, the target was not met within the allowed steps
log_error "Target checkpoints not reached" "target=${target}"
exit 1
