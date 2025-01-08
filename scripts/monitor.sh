#!/usr/bin/env bash
set -euo pipefail

# Monitor the status of the devnet.
TMP_FOLDER="tmp"
CL_SERVICES_FILE="cl_services.txt"
EL_SERVICES_FILE="el_services.txt"

TIMEOUT_SECONDS=60
CHECK_RATE_SECONDS=10

get_status() {
  cl_rpc_url="$1"
  el_rpc_url="$2"

  local cl_peer_count el_peer_count cl_block_height el_block_height
  cl_peer_count=$(curl --silent "${cl_rpc_url}/net_info" | jq '.result.peers | length')
  # shellcheck disable=SC2116
  el_peer_count=$(( $(curl --silent -H "Content-Type: application/json" --data '{"jsonrpc": "2.0", "method": "net_peerCount", "params": [], "id": 1}' "${el_rpc_url}" | jq --raw-output '.result') ))
  cl_block_height=$(curl --silent "${cl_rpc_url}/status" | jq --raw-output '.result.sync_info.latest_block_height')
  cl_latest_block_hash=$(curl --silent "${cl_rpc_url}/status" | jq --raw-output '.result.sync_info.latest_block_hash')
  el_block_height=$(cast bn --rpc-url "${el_rpc_url}")
  el_latest_block_hash="$(cast block --rpc-url "${el_rpc_url}" --json | jq --raw-output '.hash')"
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

# Monitor the status of the devnet.
echo "Monitoring the status of the devnet..."
echo "- Enclave: ${ENCLAVE}"
echo "- Timeout: ${TIMEOUT_SECONDS}"
echo "- Check rate: ${CHECK_RATE_SECONDS}"

declare -a previous_cl_heights previous_el_heights
for (( i=0; i<"${#cl_services[@]}"; i++ )); do
  previous_cl_heights[i]=0
  previous_el_heights[i]=0
done

start_time="$(date +%s)"
while true; do
  # Check for timeout.
  current_time="$(date +%s)"
  if (( current_time - start_time >= TIMEOUT_SECONDS )); then
    echo
    echo "Timeout reached. Exiting monitor."

    error=false
    for (( i=0; i<"${#cl_services[@]}"; i++ )); do
      cl_service_name="${cl_services[${i}]}"
      cl_rpc_url="${cl_rpc_urls[${i}]}"
      
      el_service_name="${el_services[${i}]}"
      el_rpc_url="${el_rpc_urls[${i}]}"

      status="$(get_status "${cl_rpc_url}" "${el_rpc_url}")"
      read -r cl_peer_count el_peer_count cl_block_height cl_latest_block_hash el_block_height el_latest_block_hash <<< "${status}"

      if (( previous_cl_heights[i] < 10 )); then
        echo "💥 ${cl_service_name} is stuck..."
        error=true
      fi
      if (( previous_el_heights[i] < 10 )); then
        echo "💥 ${el_service_name} is stuck..."
        error=true
      fi
    done

    if "${error}"; then
      exit 1
    fi
    exit 0
  fi

  echo
  echo "---"
  echo "Timestamp: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  echo

  output=""
  output+='{'
  output+='  "participants": ['

  # Loop through each CL and EL service to get their statuses.
  for (( i=0; i<"${#cl_services[@]}"; i++ )); do
    cl_service_name="${cl_services[${i}]}"
    cl_rpc_url="${cl_rpc_urls[${i}]}"
    
    el_service_name="${el_services[${i}]}"
    el_rpc_url="${el_rpc_urls[${i}]}"

    status=$(get_status "${cl_rpc_url}" "${el_rpc_url}")
    read -r cl_peer_count el_peer_count cl_block_height cl_latest_block_hash el_block_height el_latest_block_hash <<< "${status}"

    cl_peer_status="OK"
    if (( cl_peer_count == 0 )); then
      cl_peer_status="NONE"
    fi

    el_peer_status="OK"
    if (( el_peer_count == 0 )); then
      el_peer_status="NONE"
    fi

    cl_height_diff=$((cl_block_height - previous_cl_heights[i]))
    cl_height_status="+${cl_height_diff}"
    if (( cl_height_diff == 0)); then
      cl_height_status="STUCK"
    fi

    el_height_diff=$((el_block_height - previous_el_heights[i]))
    el_height_status="+${el_height_diff}"
    if (( el_height_diff == 0)); then
      el_height_status="STUCK"
    fi

    output+='    {'
    output+='      "id": '"$(( i + 1))"','
    output+='      "cl": {'
    output+='        "name": "'"${cl_service_name}"'",'
    output+='        "peers": '"${cl_peer_count}"','
    output+='        "peersStatus": "'"${cl_peer_status}"'",'
    output+='        "height": '"${cl_block_height}"','
    output+='        "heightStatus": "'"${cl_height_status}"'",'
    output+='        "latestBlockHash": "'"${cl_latest_block_hash}"'"'
    output+='      },'
    output+='      "el": {'
    output+='        "name": "'"${el_service_name}"'",'
    output+='        "peers": '"${el_peer_count}"','
    output+='        "peersStatus": "'"${el_peer_status}"'",'
    output+='        "height": '"${el_block_height}"','
    output+='        "heightStatus": "'"${el_height_status}"'",'
    output+='        "latestBlockHash": "'"${el_latest_block_hash}"'"'
    output+='      }'
    output+='    }'
    if [[ "${i}" -lt $((${#cl_services[@]} - 1)) ]]; then
        output+=','
    fi

    # Update previous heights for next iteration.
    previous_cl_heights[i]="${cl_block_height}"
    previous_el_heights[i]="${el_block_height}"
  done

  output+='  ]'
  output+='}'
  # echo -e "${output}"
  # echo -e "${output}" | jq
  echo -e "${output}" | jq --raw-output '(["ID", "CL Name", "CL Peers", "CL Peers Status", "CL Height", "CL Height Status", "CL Latest Hash", "EL Name", "EL Peers", "EL Peers Status", "EL Height", "EL Height Status", "EL Latest Hash"] | (., map(length*"-"))), (.participants[] | [.id, .cl.name, .cl.peers, .cl.peersStatus, .cl.height, .cl.heightStatus, .cl.latestBlockHash[:10], .el.name, .el.peers, .el.peersStatus, .el.height, .el.heightStatus, .el.latestBlockHash[:10]]) | @tsv' | column -ts $'\t'
  # echo -e "${output}" | jq --raw-output '(["ID", "CL Name", "CL Peers", "CL Peers Status", "CL Height", "CL Height Status", "CL Latest Hash", "EL Name", "EL Peers", "EL Peers Status", "EL Height", "EL Height Status", "EL Latest Hash"] | (., map(length*"-"))), (.participants[] | [.id, .cl.name, .cl.peers, .cl.peersStatus, .cl.height, .cl.heightStatus, .cl.latestBlockHash[:10], .el.name, .el.peers, .el.peersStatus, .el.height, .el.heightStatus, .el.latestBlockHash[:10]])'

  sleep "${CHECK_RATE_SECONDS}"
done
