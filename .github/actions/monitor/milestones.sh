#!/usr/bin/env bash
set -euo pipefail

# This script monitors milestones progress in a Polygon PoS devnet.
# Usage: ./milestones.sh <docker_network>
# Example: ./milestones.sh kt-pos

# Source libraries
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/log.sh"
source "${SCRIPT_DIR}/lib/docker.sh"

log_info "Monitoring milestones progress"

# Validate input parameters
docker_network=${1:-"kt-pos"}
if [[ -z "${docker_network}" ]]; then
  log_error "Docker network name must be provided"
  exit 1
fi
log_info "Using docker network: ${docker_network}"

# Get CL API URL
api_url=$(get_any_cl_api_url "${docker_network}")
log_info "Using API url: ${api_url}"

# Monitor milestone progress
target="10"
log_info "Using target: ${target}"

num_steps=100
gas_price_factor=1
for step in $(seq 1 "${num_steps}"); do
  log_info "Check ${step}/${num_steps}"

  MILESTONES_COUNT=$(curl "${api_url}/milestones/count" | jq --raw-output '.count')
  log_info "Got milestones count: ${MILESTONES_COUNT}"
  if [[ "${MILESTONES_COUNT}" -ge "${target}" ]]; then
    log_info "Target milestones reached"
    exit 0
  fi
  sleep 5
done

# If the code reaches here, the target was not met within the allowed steps
log_error "Target milestones have not been reached"
exit 1
