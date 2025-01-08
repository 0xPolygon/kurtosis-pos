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
  cl_peer_count="$(curl --silent "${cl_rpc_url}/net_info" | jq '.result.peers | length')"
  # shellcheck disable=SC2116
  el_peer_count="$(echo $(( $(curl --silent -H "Content-Type: application/json" --data '{"jsonrpc": "2.0", "method": "net_peerCount", "params": [], "id": 1}' "${el_rpc_url}" | jq --raw-output '.result') )))"
  cl_block_height="$(curl --silent "${cl_rpc_url}/status" | jq --raw-output '.result.sync_info.latest_block_height')"
  cl_latest_block_hash="$(curl --silent "${cl_rpc_url}/status" | jq --raw-output '.result.sync_info.latest_block_hash')"
  el_block_height="$(cast bn --rpc-url "${el_rpc_url}")"
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
  echo "----------------------------------------"
  echo "Timestamp: $(date +"%Y-%m-%d %H:%M:%S.%3N")"
  echo

  # Loop through each CL and EL service to get their statuses.
  for (( i=0; i<"${#cl_services[@]}"; i++ )); do
    cl_service_name="${cl_services[${i}]}"
    cl_rpc_url="${cl_rpc_urls[${i}]}"
    
    el_service_name="${el_services[${i}]}"
    el_rpc_url="${el_rpc_urls[${i}]}"

    status="$(get_status "${cl_rpc_url}" "${el_rpc_url}")"
    read -r cl_peer_count el_peer_count cl_block_height cl_latest_block_hash el_block_height el_latest_block_hash <<< "${status}"

    echo "Participant #$(( i + 1))"

    cl_peer_status=""
    if (( cl_peer_count == 0 )); then
      cl_peer_status=" 🚨"
    fi

    el_peer_status=""
    if (( el_peer_count == 0 )); then
      el_peer_status=" 🚨"
    fi

    cl_height_diff=$((cl_block_height - previous_cl_heights[i]))
    cl_height_status=""
    if (( cl_height_diff == 0)); then
      cl_height_status=" 🚨"
    fi

    el_height_diff=$((el_block_height - previous_el_heights[i]))
    el_height_status=""
    if (( el_height_diff == 0)); then
      el_height_status=" 🚨"
    fi

    echo "CL | name: ${cl_service_name} | peers: ${cl_peer_count}${cl_peer_status} | height: ${cl_block_height} (+${cl_height_diff})${cl_height_status} | block hash: ${cl_latest_block_hash}"
    echo "EL | name: ${el_service_name} | peers: ${el_peer_count}${el_peer_status} | height: ${el_block_height} (+${el_height_diff})${el_height_status} | block hash: ${el_latest_block_hash}"

    # Only print a new line after each participant block except for the last one.
    if [[ "${i}" -lt $((${#cl_services[@]} - 1)) ]]; then
      echo
    fi

    # Update previous heights for next iteration.
    previous_cl_heights[i]="${cl_block_height}"
    previous_el_heights[i]="${el_block_height}"
  done
  
  sleep "${CHECK_RATE_SECONDS}"
done
