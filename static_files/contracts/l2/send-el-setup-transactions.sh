#!/usr/bin/env bash
# No xtrace here: the transactions can carry private keys.
set -euo pipefail

# Send the transactions given through `el_setup_transactions` on L2, in order, and stop
# at the first one that fails.

TRANSACTIONS_FILE="/opt/data/transactions/transactions.json"
OUTPUT_FILE="/opt/contracts/elSetupTransactions.json"
SENDER_FUNDING="10ether"

for v in PRIVATE_KEY L2_RPC_URL; do
  if [[ -z "${!v:-}" ]]; then
    echo "Error: ${v} is not set"
    exit 1
  fi
done

mkdir -p /opt/contracts
echo "[]" > "${OUTPUT_FILE}"

# Bor takes about a minute after it starts to produce its first block, and it takes no
# transactions until then.
echo "Waiting for the L2 chain to produce its first block..."
until [[ "$(cast block-number --rpc-url "${L2_RPC_URL}" 2> /dev/null || echo 0)" -gt 0 ]]; do
  sleep 2
done

admin=$(cast wallet address --private-key "${PRIVATE_KEY}")
count=$(jq 'length' "${TRANSACTIONS_FILE}")
for ((i = 0; i < count; i++)); do
  to=$(jq -r ".[${i}].to // empty" "${TRANSACTIONS_FILE}")
  data=$(jq -r ".[${i}].data" "${TRANSACTIONS_FILE}")
  key=$(jq -r ".[${i}].private_key // empty" "${TRANSACTIONS_FILE}")
  key="${key:-${PRIVATE_KEY}}"
  sender=$(cast wallet address --private-key "${key}")

  # A sender other than the admin has no funds on a fresh devnet.
  if [[ "${sender}" != "${admin}" ]]; then
    balance=$(cast balance --rpc-url "${L2_RPC_URL}" "${sender}")
    if [[ "${balance}" == "0" ]]; then
      echo "Funding sender ${sender} with ${SENDER_FUNDING}..."
      cast send --rpc-url "${L2_RPC_URL}" --private-key "${PRIVATE_KEY}" --legacy \
        --value "${SENDER_FUNDING}" "${sender}" > /dev/null
    fi
  fi

  if [[ -z "${to}" ]]; then
    receipt=$(cast send --json --rpc-url "${L2_RPC_URL}" --private-key "${key}" --legacy --create "${data}")
  else
    receipt=$(cast send --json --rpc-url "${L2_RPC_URL}" --private-key "${key}" --legacy "${to}" "${data}")
  fi

  if [[ "$(jq -r '.status' <<< "${receipt}")" != "0x1" ]]; then
    echo "Error: transaction ${i} failed"
    exit 1
  fi
  echo "Sent transaction ${i} from ${sender}: $(jq -c '{transactionHash, to, contractAddress, blockNumber}' <<< "${receipt}")"

  jq --argjson r "${receipt}" \
    '. + [$r | {transactionHash, from, to, contractAddress, blockNumber}]' "${OUTPUT_FILE}" > tmp.json
  mv tmp.json "${OUTPUT_FILE}"
done

echo "L2 setup transactions:"
cat "${OUTPUT_FILE}"
