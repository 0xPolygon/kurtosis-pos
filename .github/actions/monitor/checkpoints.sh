#!/usr/bin/env bash
set -euo pipefail

# This script monitors checkpoints progress in a Polygon PoS devnet.
# Usage: ./checkpoints.sh <docker_network>
# Example: ./checkpoints.sh kt-pos

# Source logging library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"

log_info "Monitoring checkpoints progress"

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
