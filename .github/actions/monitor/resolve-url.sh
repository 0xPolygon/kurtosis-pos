#!/usr/bin/env bash
# Resolve service URLs for monitor scripts in a transport-agnostic way.
#
# Each helper looks up a single service URL or enumerates a class of services.
# The kurtosis path uses `kurtosis port print` / `kurtosis enclave inspect`.
# The docker path reads ports from a docker-compose.yaml. The choice is driven
# by env vars set by the caller — when the docker compose file path is set,
# everything resolves from compose; otherwise falls back to kurtosis.
#
# Env vars (set by the caller, all optional):
#   COMPOSE_FILE        path to a restored docker-compose.yaml — switches every
#                       helper into docker mode.
#   L2_CL_API_URL       override for the heimdall REST API (cl-1, port 1317).
#   <other URL vars>    callers can pre-set per-service URLs to skip discovery
#                       entirely (e.g. when the test harness already knows them).

# Print the L2 CL REST API URL of the first heimdall validator.
# Used by checkpoints.sh / milestones.sh / spans.sh.
resolve_l2_cl_api_url() {
    local enclave_name="$1"
    if [[ -n "${L2_CL_API_URL:-}" ]]; then
        echo "${L2_CL_API_URL}"
        return 0
    fi
    if [[ -n "${COMPOSE_FILE:-}" ]]; then
        local port
        port=$(yq -r '.services | to_entries[] | select(.key | test("-l2-cl-1-heimdall-v2-bor-validator$")) | .value.ports[0]' "${COMPOSE_FILE}" | cut -d: -f1)
        echo "http://localhost:${port}"
        return 0
    fi
    kurtosis port print "${enclave_name}" l2-cl-1-heimdall-v2-bor-validator http
}

# Enumerate L2 EL services as `name|rpc_url` lines. Used by blocks-bor.sh.
# In docker mode, names are the compose service names. In kurtosis mode they
# are the bare service names with a UUID suffix.
enumerate_l2_el_services() {
    local enclave_name="$1"
    local mode="${2:-all}" # all | first
    if [[ -n "${COMPOSE_FILE:-}" ]]; then
        local entries
        entries=$(yq -r '.services | to_entries[] | select(.key | test("-l2-el-[0-9]+-")) | "\(.key)|http://localhost:\(.value.ports[0] | split(":") | .[0])"' "${COMPOSE_FILE}" | sort)
        if [[ "${mode}" == "first" ]]; then
            echo "${entries}" | head -n 1
        else
            echo "${entries}"
        fi
        return 0
    fi
    local rpc_names
    if [[ "${mode}" == "first" ]]; then
        rpc_names=$(kurtosis enclave inspect "${enclave_name}" | awk '/l2-el/ && /RUNNING/ {print $2 "--" $1}' | head -n 1)
    else
        rpc_names=$(kurtosis enclave inspect "${enclave_name}" | awk '/l2-el/ && /RUNNING/ {print $2 "--" $1}')
    fi
    while IFS= read -r entry; do
        [[ -z "${entry}" ]] && continue
        local name="${entry%%--*}"
        local url
        url=$(kurtosis port print "${enclave_name}" "${name}" rpc)
        echo "${name}|${url}"
    done <<< "${rpc_names}"
}

# Enumerate L2 CL services (heimdall validators only, excluding rabbitmq) as
# `name|rpc_url` lines. The URL points at the cometBFT RPC (port 26657 inside
# the container) which serves /status with the .result.sync_info.* shape.
# Used by blocks-heimdall.sh.
enumerate_l2_cl_services() {
    local enclave_name="$1"
    local mode="${2:-all}"
    if [[ -n "${COMPOSE_FILE:-}" ]]; then
        # Compose generation maps two ports per l2-cl: 1317 (REST) and 26657
        # (cometBFT). The cometBFT mapping is the one that ends in :26657.
        local entries
        entries=$(yq -r '.services | to_entries[]
            | select((.key | test("-l2-cl-[0-9]+-")) and (.key | test("rabbitmq") | not))
            | .key as $name
            | (.value.ports[] | select(endswith(":26657")) | split(":")[0]) as $port
            | "\($name)|http://localhost:\($port)"' "${COMPOSE_FILE}" | sort)
        if [[ "${mode}" == "first" ]]; then
            echo "${entries}" | head -n 1
        else
            echo "${entries}"
        fi
        return 0
    fi
    local cl_names
    if [[ "${mode}" == "first" ]]; then
        cl_names=$(kurtosis enclave inspect "${enclave_name}" | awk '/l2-cl/ && !/rabbitmq/ && /RUNNING/ {print $2 "--" $1}' | head -n 1)
    else
        cl_names=$(kurtosis enclave inspect "${enclave_name}" | awk '/l2-cl/ && !/rabbitmq/ && /RUNNING/ {print $2 "--" $1}')
    fi
    while IFS= read -r entry; do
        [[ -z "${entry}" ]] && continue
        local name="${entry%%--*}"
        local url
        url=$(kurtosis port print "${enclave_name}" "${name}" rpc)
        echo "${name}|${url}"
    done <<< "${cl_names}"
}
