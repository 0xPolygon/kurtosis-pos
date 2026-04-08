#!/usr/bin/env bash

# Docker utility functions for monitor scripts.
# Usage: source /path/to/docker.sh
#
# Requires log.sh to be sourced before this file.

get_cl_containers() {
  local docker_network="$1"
  docker ps --filter "network=${docker_network}" --filter "name=l2-cl" --format '{{.Names}}' |
    grep -v rabbitmq |
    sort -V
}

get_any_cl_api_url() {
  local docker_network="$1"
  local container host_port url
  while IFS= read -r container; do
    host_port=$(docker port "${container}" 1317 2>/dev/null | head -1 | sed 's/0.0.0.0/127.0.0.1/')
    if [[ -n "${host_port}" ]]; then
      url="http://${host_port}"
      if curl -sf "${url}/bor/spans/latest" &>/dev/null; then
        echo "${url}"
        return 0
      fi
    fi
  done < <(get_cl_containers "${docker_network}")
  log_error "No available CL container with a reachable API in network '${docker_network}'"
  return 1
}

get_el_containers() {
  local docker_network="$1"
  docker ps --filter "network=${docker_network}" --filter "name=l2-el" --format '{{.Names}}' |
    sort -V
}

get_any_el_rpc_url() {
  local docker_network="$1"
  local container host_port url
  while IFS= read -r container; do
    host_port=$(docker port "${container}" 8545 2>/dev/null | head -1 | sed 's/0.0.0.0/127.0.0.1/')
    if [[ -n "${host_port}" ]]; then
      url="http://${host_port}"
      if cast bn --rpc-url "${url}" &>/dev/null; then
        echo "${url}"
        return 0
      fi
    fi
  done < <(get_el_containers "${docker_network}")
  log_error "No available EL container with a reachable RPC in network '${docker_network}'"
  return 1
}
