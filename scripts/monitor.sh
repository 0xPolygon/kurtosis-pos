#!/usr/bin/env bash
set -euo pipefail

# Monitor the status of the devnet.
TMP_FOLDER="tmp"
L1_RPC_FILE="l1_rpc.txt"
L1_ROOT_CHAIN_PROXY_ADDRESS="l1_root_chain_proxy.txt"
L1_STATE_SENDER_ADDRESS="l1_state_sender.txt"
L2_CL_RPCS_FILE="l2_cl_rpcs.txt"
L2_CL_APIS_FILE="l2_cl_apis.txt"
L2_EL_RPCS_FILE="l2_el_rpcs.txt"
L2_STATE_RECEIVER_ADDRESS="l2_state_receiver.txt"

CHECK_RATE_SECONDS=${CHECK_RATE_SECONDS:-10}
TIMEOUT_SECONDS=${TIMEOUT_SECONDS:-60}
# Minimum number of peers expected, per client.
EXPECTED_MIN_CL_PEERS=${EXPECTED_MIN_CL_PEERS:-1}
EXPECTED_MIN_EL_PEERS=${EXPECTED_MIN_EL_PEERS:-1}
# Minimum chain height expected.
EXPECTED_MIN_CL_HEIGHT=${EXPECTED_MIN_CL_HEIGHT:-30}
EXPECTED_MIN_EL_HEIGHT=${EXPECTED_MIN_EL_HEIGHT:-20}

get_l1_chain_status() {
  rpc_url="$1"
  root_chain_proxy_address="$2"
  state_sender_address="$3"
  local latest_bn safe_bn finalized_bn latest_checkpoint latest_state_id
  latest_bn=$(cast bn --rpc-url "${rpc_url}")
  safe_bn=$(cast bn --rpc-url "${rpc_url}" safe)
  finalized_bn=$(cast bn --rpc-url "${rpc_url}" finalized)
  latest_checkpoint=$(cast call --rpc-url "${rpc_url}" "${root_chain_proxy_address}" 'currentHeaderBlock()(uint)')
  state_sender_address=$(cast call --rpc-url "${rpc_url}" "${state_sender_address}" 'counter()(uint)')
  echo "${latest_bn} ${safe_bn} ${finalized_bn} ${latest_checkpoint}" "${state_sender_address}"
}

get_l2_chain_status() {
  rpc_url="$1"
  state_receiver_address="$2"
  local latest_bn finalized_bn latest_state_id
  latest_bn=$(cast bn --rpc-url "${rpc_url}")
  finalized_bn=$(cast bn --rpc-url "${rpc_url}" finalized)
  latest_state_id=$(cast call --rpc-url "${rpc_url}" "${state_receiver_address}" "lastStateId()(uint)")
  echo "${latest_bn} ${finalized_bn}" "${latest_state_id}"
}

get_l2_cl_node_status() {
  name="$1"
  rpc_url="$2"
  api_url="$3"
  local peer_count height latest_block_hash
  peer_count=$(curl --silent "${rpc_url}/net_info" | jq '.result.peers | length')
  sync_info=$(curl --silent "${rpc_url}/status" | jq --raw-output '.result.sync_info | [.latest_block_height, .latest_block_hash, .catching_up] | @tsv')
  read -r height latest_block_hash is_syncing <<<"${sync_info}"
  if [[ "${name}" =~ "heimdall-v2" ]]; then
    span=$(curl --silent "${api_url}/bor/span/latest" | jq --raw-output '.span.id')
    state_sync_count=$(curl --silent "${api_url}/clerk/event-record/list" | jq --raw-output '.event_records | length')
  else
    span=$(curl --silent "${api_url}/bor/latest-span" | jq --raw-output '.height')
    state_sync_count=$(curl --silent "${api_url}/clerk/event-record/list" | jq --raw-output '.result | length')
  fi
  checkpoint_count=$(curl --silent "${api_url}/checkpoints/list" | jq --raw-output '.checkpoint_list | length')
  milestone_count=$(curl --silent "${api_url}/milestone/count" | jq --raw-output '.count')
  echo "${peer_count} ${height} ${latest_block_hash} ${is_syncing} ${span} ${state_sync_count} ${checkpoint_count}" "${milestone_count}"
}

get_l2_el_node_status() {
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
l1_rpc_url=$(cat ${TMP_FOLDER}/${L1_RPC_FILE})
l1_root_chain_proxy_address=$(cat ${TMP_FOLDER}/${L1_ROOT_CHAIN_PROXY_ADDRESS})
l1_state_sender_address=$(cat ${TMP_FOLDER}/${L1_STATE_SENDER_ADDRESS})
l2_rpc_url=""
l2_state_receiver_address=$(cat ${TMP_FOLDER}/${L2_STATE_RECEIVER_ADDRESS})

declare -a cl_services cl_rpc_urls
while IFS='=' read -r service rpc_url; do
  cl_services+=("${service}")
  cl_rpc_urls+=("${rpc_url}")
done <"${TMP_FOLDER}/${L2_CL_RPCS_FILE}"
if [ "${#cl_services[@]}" -ne "${#cl_rpc_urls[@]}" ]; then
  echo "Error: The numbers of CL services (${#cl_services[@]}) is not the same as the number of CL RPC URLs (${#cl_rpc_urls[@]})."
  exit 1
fi

declare -a cl_api_urls
while IFS='=' read -r service api_url; do
  cl_api_urls+=("${api_url}")
done <"${TMP_FOLDER}/${L2_CL_APIS_FILE}"
if [ "${#cl_services[@]}" -ne "${#cl_api_urls[@]}" ]; then
  echo "Error: The numbers of CL services (${#cl_services[@]}) is not the same as the number of CL API URLs (${#cl_api_urls[@]})."
  exit 1
fi

declare -a el_services el_rpc_urls
while IFS='=' read -r service rpc_url; do
  el_services+=("${service}")
  el_rpc_urls+=("${rpc_url}")
  if [[ "${l2_rpc_url}" == "" ]]; then
    l2_rpc_url="${rpc_url}"
  fi
done <"${TMP_FOLDER}/${L2_EL_RPCS_FILE}"
if [ "${#el_services[@]}" -ne "${#el_rpc_urls[@]}" ]; then
  echo "The numbers of EL services (${#el_services[@]}) is not the same as the number of EL RPC URLs (${#el_rpc_urls[@]})."
  exit 1
fi

# Monitor the status of the devnet.
echo "Monitoring the status of the devnet..."
echo "- Enclave: ${ENCLAVE}"
echo "- Timeout: ${TIMEOUT_SECONDS} seconds"
echo "- Check rate: ${CHECK_RATE_SECONDS} seconds"

declare -a previous_cl_heights previous_el_heights
for ((i = 0; i < "${#el_services[@]}"; i++)); do
  previous_cl_heights[i]=0
  previous_el_heights[i]=0
done

start_time="$(date +%s)"
while true; do
  # Check for timeout.
  current_time="$(date +%s)"
  if ((current_time - start_time >= TIMEOUT_SECONDS)); then
    echo
    echo "Timeout reached. Exiting monitor."
    echo

    error=false
    # Check if there are any issues with the CL clients.
    for ((i = 0; i < "${#cl_services[@]}"; i++)); do
      name="${cl_services[${i}]}"
      rpc_url="${cl_rpc_urls[${i}]}"
      api_url="${cl_api_urls[${i}]}"

      status=$(get_l2_cl_node_status "${name}" "${rpc_url}" "${api_url}")
      read -r peer_count height latest_block_hash is_syncing span state_sync_count checkpoint_count milestone_count <<<"${l2_cl_status}"

      if ((peer_count < EXPECTED_MIN_CL_PEERS)); then
        echo "❌ ${name} has not enough peers... Number of peers: ${peer_count}, expected more than ${EXPECTED_MIN_CL_PEERS}!"
        error=true
      fi

      if ((height < EXPECTED_MIN_CL_HEIGHT)); then
        echo "❌ ${name} has not progressed enough... Current height: ${height}, expected more than ${EXPECTED_MIN_CL_HEIGHT}!"
        error=true
      fi
    done

    # Check if there are any issues with EL clients.
    for ((i = 0; i < "${#el_services[@]}"; i++)); do
      name="${el_services[${i}]}"
      rpc_url="${el_rpc_urls[${i}]}"

      status=$(get_l2_el_node_status "${rpc_url}")
      read -r peer_count height latest_block_hash <<<"${status}"

      if ((peer_count < EXPECTED_MIN_EL_PEERS)); then
        echo "❌ ${name} has not enough peers... Number of peers: ${peer_count}, expected more than ${EXPECTED_MIN_EL_PEERS}!"
        error=true
      fi

      if ((height < EXPECTED_MIN_EL_HEIGHT)); then
        echo "❌ ${name} has not progressed enough... Current height: ${height}, expected more than ${EXPECTED_MIN_EL_HEIGHT}!"
        error=true
      fi
    done

    if "${error}"; then
      exit 1
    fi
    echo "✅ The devnet looks healthy!"
    exit 0
  fi

  echo
  echo "---"
  echo "Timestamp: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  echo

  l1_chain_status=$(get_l1_chain_status "${l1_rpc_url}" "${l1_root_chain_proxy_address}" "${l1_state_sender_address}")
  read -r l1_latest_bn l1_safe_bn l1_finalized_bn l1_latest_checkpoint l1_latest_state_id <<<"${l1_chain_status}"

  l2_chain_status=$(get_l2_chain_status "${l2_rpc_url}" "${l2_state_receiver_address}")
  read -r l2_latest_bn l2_finalized_bn l2_latest_state_id <<<"${l2_chain_status}"

  output=""
  output+='{'
  output+='  "l1_chain_status": {'
  output+='    "latest_bn": '"${l1_latest_bn}"','
  output+='    "safe_bn": '"${l1_safe_bn}"','
  output+='    "finalized_bn": '"${l1_finalized_bn}"','
  output+='    "latest_checkpoint": '"${l1_latest_checkpoint}"','
  output+='    "latest_state_id": '"${l1_latest_state_id}"''
  output+='  },'
  output+='  "l2_chain_status": {'
  output+='    "latest_bn": '"${l2_latest_bn}"','
  output+='    "finalized_bn": '"${l2_finalized_bn}"','
  output+='    "latest_state_id": '"${l2_latest_state_id}"''
  output+='  },'
  output+='  "l2_participants": {'

  # Loop through each CL service to get the status.
  output+='    "cl": ['
  for ((i = 0; i < "${#cl_services[@]}"; i++)); do
    name="${cl_services[${i}]}"
    rpc_url="${cl_rpc_urls[${i}]}"
    api_url="${cl_api_urls[${i}]}"

    l2_cl_status=$(get_l2_cl_node_status "${name}" "${rpc_url}" "${api_url}")
    read -r peer_count height latest_block_hash is_syncing span state_sync_count checkpoint_count milestone_count <<<"${l2_cl_status}"

    peer_status="OK"
    if ((peer_count == 0)); then
      peer_status="NONE"
    fi

    height_diff=$((height - previous_cl_heights[i]))
    height_status="+${height_diff}"
    if ((height_diff == 0)); then
      height_status="STUCK"
    fi

    output+='      {'
    output+='        "id": '"$((i + 1))"','
    output+='        "name": "'"${name}"'",'
    output+='        "peers": '"${peer_count}"','
    output+='        "peersStatus": "'"${peer_status}"'",'
    output+='        "height": '"${height}"','
    output+='        "heightStatus": "'"${height_status}"'",'
    output+='        "latestBlockHash": "'"${latest_block_hash}"'",'
    output+='        "span": '"${span}"','
    output+='        "isSyncing": '"${is_syncing}"','
    output+='        "stateSyncCount": '"${state_sync_count}"','
    output+='        "checkpointCount": '"${checkpoint_count}"','
    output+='        "milestoneCount": '"${milestone_count}"''
    output+='      }'
    if [[ "${i}" -lt $((${#cl_services[@]} - 1)) ]]; then
      output+=','
    fi

    # Update previous heights for next iteration.
    previous_cl_heights[i]="${height}"
  done
  output+='    ],'

  # Loop through each EL service to get the status.
  output+='    "el": ['
  for ((i = 0; i < "${#el_services[@]}"; i++)); do
    name="${el_services[${i}]}"
    rpc_url="${el_rpc_urls[${i}]}"

    l2_el_status=$(get_l2_el_node_status "${rpc_url}")
    read -r peer_count height latest_block_hash is_syncing <<<"${l2_el_status}"

    peer_status="OK"
    if ((peer_count == 0)); then
      peer_status="NONE"
    fi

    height_diff=$((height - previous_el_heights[i]))
    height_status="+${height_diff}"
    if ((height_diff == 0)); then
      height_status="STUCK"
    fi

    output+='      {'
    output+='        "id": '"$((i + 1))"','
    output+='        "name": "'"${name}"'",'
    output+='        "peers": '"${peer_count}"','
    output+='        "peersStatus": "'"${peer_status}"'",'
    output+='        "height": '"${height}"','
    output+='        "heightStatus": "'"${height_status}"'",'
    output+='        "latestBlockHash": "'"${latest_block_hash}"'",'
    output+='        "isSyncing": '"${is_syncing}"''
    output+='      }'
    if [[ "${i}" -lt $((${#el_services[@]} - 1)) ]]; then
      output+=','
    fi

    # Update previous heights for next iteration.
    previous_el_heights[i]="${height}"
  done
  output+='    ]'
  output+='  }'
  output+='}'

  # Display tables
  echo "🔗 L1 Chain Status:"
  echo
  echo -e "${output}" | jq --raw-output '(["Latest Height", "Safe Height", "Finalized Height", "Latest Checkpoint", "Latest State ID (State Sender)"] | (., map(length*"-"))), (.l1_chain_status | [.latest_bn, .safe_bn, .finalized_bn, .latest_checkpoint, .latest_state_id]) | @tsv' | column -ts $'\t'

  echo
  echo "🔗 L2 Chain Status:"
  echo
  echo "${output}" | jq --raw-output '(["Latest Height", "Finalized Height", "Latest State ID (State Receiver)"] | (., map(length*"-"))), (.l2_chain_status | [.latest_bn, .finalized_bn, .latest_state_id]) | @tsv' | column -ts $'\t'

  echo
  echo "✅ L2 CL Nodes Statuses:"
  echo
  echo -e "${output}" | jq --raw-output '(["ID", "CL Name", "CL Peers", "CL Peers Status", "CL Height", "CL Height Status", "CL Latest Block Hash", "CL Span Height", "Is Syncing", "State Sync Count", "Checkpoint Count", "Milestone Count"] | (., map(length*"-"))), (.l2_participants.cl[] | [.id, .name, .peers, .peersStatus, .height, .heightStatus, .latestBlockHash[:10], .span, .isSyncing, .stateSyncCount, .checkpointCount, .milestoneCount]) | @tsv' | column -ts $'\t'

  echo
  echo "⛏️  L2 EL Nodes Statuses:"
  echo
  echo -e "${output}" | jq --raw-output '(["ID", "EL Name", "EL Peers", "EL Peers Status", "EL Height", "EL Height Status", "EL Latest Block Hash", "Is Syncing"] | (., map(length*"-"))), (.l2_participants.el[] | [.id, .name, .peers, .peersStatus, .height, .heightStatus, .latestBlockHash[:10], .isSyncing]) | @tsv' | column -ts $'\t'

  sleep "${CHECK_RATE_SECONDS}"
done
