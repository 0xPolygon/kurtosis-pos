#!/usr/bin/env bash
set -euo pipefail

# Check the status of the devnet.
# For each participant (EL and CL nodes), print the number of peers and the block height.
TMP_FOLDER="tmp"
CL_SERVICES_FILE="cl_services.txt"
EL_SERVICES_FILE="el_services.txt"

get_status() {
  cl_rpc_url="$1"
  el_rpc_url="$2"

  local cl_peer_count el_peer_count cl_block_height el_block_height
  cl_peer_count="$(curl --silent "${cl_rpc_url}/net_info" | jq '.result.peers | length')"
  # shellcheck disable=SC2116
  el_peer_count="$(echo $(( $(curl --silent -H "Content-Type: application/json" --data '{"jsonrpc": "2.0", "method": "net_peerCount", "params": [], "id": 1}' "${el_rpc_url}" | jq --raw-output '.result') )))"
  cl_block_height="$(curl --silent "${cl_rpc_url}/status" | jq --raw-output '.result.sync_info.latest_block_height')"
  cl_latest_block_hash="$(curl --silent "${cl_rpc_url}/status" | jq --raw-output '.result.sync_info.latest_block_hash')"
  el_block_height="$(cast bn --rpc-url "${el_rpc_url}")"
  el_latest_block_hash="$(curl --silent "${el_rpc_url}" | jq --raw-output '.hash')"
  echo "${cl_peer_count} ${el_peer_count} ${cl_block_height} ${cl_latest_block_hash} ${el_block_height} ${el_latest_block_hash}"
}

# Load services and rpc urls from files.
mkdir -p "${TMP_FOLDER}"

declare -a cl_services cl_rpc_urls
while IFS='=' read -r service url; do
  cl_services+=("${service}")
  cl_rpc_urls+=("${url}")
done < "${TMP_FOLDER}/${CL_SERVICES_FILE}"

declare -a el_services el_rpc_urls
while IFS='=' read -r service url; do
  el_services+=("${service}")
  el_rpc_urls+=("${url}")
done < "${TMP_FOLDER}/${EL_SERVICES_FILE}"

# Print status.
echo "Devnet Status (${ENCLAVE})"
echo

for (( i=0; i<"${#cl_services[@]}"; i++ )); do
  cl_service_name="${cl_services[${i}]}"
  cl_rpc_url="${cl_rpc_urls[${i}]}"

  el_service_name="${el_services[${i}]}"
  el_rpc_url="${el_rpc_urls[${i}]}"

  status=$(get_status "${cl_rpc_url}" "${el_rpc_url}")
  read -r cl_peer_count el_peer_count cl_block_height cl_latest_block_hash el_block_height el_latest_block_hash <<< "${status}"

  echo "Participant #$(( i + 1))"
  echo "- CL | name: ${cl_service_name} | peers: ${cl_peer_count} | block height: ${cl_block_height} (${cl_latest_block_hash})"
  echo "- EL | name: ${el_service_name} | peers: ${el_peer_count} | block height: ${el_block_height} (${el_latest_block_hash})"

  # Only print a new line after each participant block except for the last one.
  if [[ "${i}" -lt $((${#cl_services[@]} - 1)) ]]; then
    echo
  fi
done
