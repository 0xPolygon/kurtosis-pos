#!/usr/bin/env bash
set -euo pipefail

# This script monitors milestones progress in a Polygon PoS devnet.
# Usage: ./milestones.sh <docker_network>
# Example: ./milestones.sh kt-pos

# Source logging library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"

log_info "Monitoring milestones progress"

# Validate input parameters
docker_network=${1:-"kt-pos"}
if [[ -z "${docker_network}" ]]; then
  log_error "Docker network name must be provided"
  exit 1
fi
log_info "Using docker network: ${docker_network}"

cl_container=$(docker ps --filter "network=${docker_network}" --filter "name=l2-cl-1" --format '{{.Names}}' | grep -v rabbitmq | head -1)
if [[ -z "${cl_container}" ]]; then
  log_error "No running CL container in network '${docker_network}'"
  exit 1
fi
host_port=$(docker port "${cl_container}" 1317 2>/dev/null | head -1 | sed 's/0.0.0.0/127.0.0.1/')
if [[ -z "${host_port}" ]]; then
  log_error "No published port 1317 for container ${cl_container}"
  exit 1
fi
api_url="http://${host_port}"
log_info "Using API url: ${api_url}"

target="10"
log_info "Using target: ${target}"

# Monitor milestone progress
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
