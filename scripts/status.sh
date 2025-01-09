#!/usr/bin/env bash
set -euo pipefail

# Check the status of the devnet.
# For each participant (EL and CL nodes), print the number of peers and the block height.
TMP_FOLDER="tmp"
CL_SERVICES_FILE="cl_services.txt"
EL_SERVICES_FILE="el_services.txt"

get_cl_status() {
  rpc_url="$1"
  local peer_count height latest_block_hash
  peer_count=$(curl --silent "${rpc_url}/net_info" | jq '.result.peers | length')
  sync_info=$(curl --silent "${rpc_url}/status" | jq --raw-output '.result.sync_info | [.latest_block_height, .latest_block_hash, .catching_up] | @tsv')
  read -r height latest_block_hash is_syncing <<< "${sync_info}"
  echo "${peer_count} ${height} ${latest_block_hash} ${is_syncing}"
}

get_el_status() {
  rpc_url="$1"
  local peer_count height latest_block_hash
  # shellcheck disable=SC2116
  peer_count=$(cast rpc --rpc-url "${rpc_url}" net_peerCount | sed 's/"//g' | cast to-dec)
  height=$(cast bn --rpc-url "${rpc_url}")
  latest_block_hash=$(cast block --rpc-url "${rpc_url}" --json | jq --raw-output '.hash')
  is_syncing=$(cast rpc --rpc-url "${rpc_url}" eth_syncing)
  if [[ "${is_syncing}" != false ]]; then
    is_syncing=true
  fi
  echo "${peer_count} ${height} ${latest_block_hash} ${is_syncing}"
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
echo "{"
echo '  "enclave": "'"${ENCLAVE}"'",'
echo '  "timestamp": "'"$(date -u +"%Y-%m-%dT%H:%M:%SZ")"'",'
echo '  "participants": {'

# Loop through each CL service to get the status.
echo '    "cl": ['
for (( i=0; i<"${#cl_services[@]}"; i++ )); do
  name="${cl_services[${i}]}"
  rpc_url="${cl_rpc_urls[${i}]}"

  status=$(get_cl_status "${rpc_url}")
  read -r peer_count height latest_block_hash is_syncing <<< "${status}"

  echo '      {'
  echo '        "id": '"$(( i + 1))"','
  echo '        "name": "'"${name}"'",'
  echo '        "peers": '"${peer_count}"','
  echo '        "height": '"${height}"','
  echo '        "latestBlockHash": "'"${latest_block_hash}"'",'
  echo '        "isSyncing": '"${is_syncing}"''
  echo '      }'"$([ $i -lt $((${#cl_services[@]} - 1)) ] && echo ',')"
done
echo '    ],'

# Loop through each EL service to get the status.
echo '    "el": ['
for (( i=0; i<"${#el_services[@]}"; i++ )); do
  name="${el_services[${i}]}"
  rpc_url="${el_rpc_urls[${i}]}"

  status=$(get_el_status "${rpc_url}")
  read -r peer_count height latest_block_hash is_syncing <<< "${status}"

  echo '      {'
  echo '        "id": '"$(( i + 1))"','
  echo '        "name": "'"${name}"'",'
  echo '        "peers": '"${peer_count}"','
  echo '        "height": '"${height}"','
  echo '        "latestBlockHash": "'"${latest_block_hash}"'",'
  echo '        "isSyncing": '"${is_syncing}"''
  echo '      }'"$([ $i -lt $((${#el_services[@]} - 1)) ] && echo ',')"
done

echo '    ]'
echo '  }'
echo '}'
