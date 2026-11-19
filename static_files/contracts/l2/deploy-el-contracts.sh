#!/usr/bin/env bash
# No xtrace here: the deployments can carry private keys.
set -euo pipefail

# Deploy the contracts given through `el_contract_deployments` on L2, in order, one
# transaction each. A contract's address follows from its deployer and that deployer's
# nonce, so the same input gives the same addresses on every fresh devnet.

DEPLOYMENTS_FILE="/opt/data/deployments/deployments.json"
OUTPUT_FILE="/opt/contracts/elContractDeployments.json"
DEPLOYER_FUNDING="10ether"

for v in PRIVATE_KEY L2_RPC_URL; do
  if [[ -z "${!v:-}" ]]; then
    echo "Error: ${v} is not set"
    exit 1
  fi
done

mkdir -p /opt/contracts
echo "[]" > "${OUTPUT_FILE}"

admin=$(cast wallet address --private-key "${PRIVATE_KEY}")
count=$(jq 'length' "${DEPLOYMENTS_FILE}")
for ((i = 0; i < count; i++)); do
  bytecode=$(jq -r ".[${i}].bytecode" "${DEPLOYMENTS_FILE}")
  key=$(jq -r ".[${i}].private_key // empty" "${DEPLOYMENTS_FILE}")
  key="${key:-${PRIVATE_KEY}}"
  deployer=$(cast wallet address --private-key "${key}")

  # A deployer other than the admin has no funds on a fresh devnet.
  if [[ "${deployer}" != "${admin}" ]]; then
    balance=$(cast balance --rpc-url "${L2_RPC_URL}" "${deployer}")
    if [[ "${balance}" == "0" ]]; then
      echo "Funding deployer ${deployer} with ${DEPLOYER_FUNDING}..."
      cast send --rpc-url "${L2_RPC_URL}" --private-key "${PRIVATE_KEY}" --legacy \
        --value "${DEPLOYER_FUNDING}" "${deployer}" > /dev/null
    fi
  fi

  nonce=$(cast nonce --rpc-url "${L2_RPC_URL}" "${deployer}")
  address=$(cast compute-address "${deployer}" --nonce "${nonce}" | awk '{print $NF}')
  cast send --rpc-url "${L2_RPC_URL}" --private-key "${key}" --legacy --create "${bytecode}" > /dev/null

  if [[ "$(cast code --rpc-url "${L2_RPC_URL}" "${address}")" == "0x" ]]; then
    echo "Error: deployment ${i} left no code at ${address}"
    exit 1
  fi
  block=$(cast block-number --rpc-url "${L2_RPC_URL}")
  echo "Deployed contract ${i} at ${address} (deployer ${deployer}, nonce ${nonce}, by block ${block})"

  jq --arg a "${address}" --arg d "${deployer}" --argjson n "${nonce}" \
    '. + [{address: $a, deployer: $d, nonce: $n}]' "${OUTPUT_FILE}" > tmp.json
  mv tmp.json "${OUTPUT_FILE}"
done

echo "L2 contract deployments:"
cat "${OUTPUT_FILE}"
