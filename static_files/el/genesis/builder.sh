#!/usr/bin/env bash
set -euxo pipefail

# Build L2 EL genesis file.
# For reference: https://github.com/0xPolygon/genesis-contracts

EL_GENESIS_ALLOC_FILE="/opt/genesis-contracts/genesis.json"
EL_GENESIS_FILE="/opt/data/genesis/genesis.json"

# Checking environment variables. Chain ids are baked into the image at build time
# (via EL_CHAIN_ID / CL_CHAIN_ID ENVs in the Dockerfile) and injected back into this
# script's environment by the container; custom values are not supported.
for v in EL_CHAIN_ID CL_CHAIN_ID ADMIN_ADDRESS ADMIN_BALANCE_WEI; do
  if [[ -z "${!v:-}" ]]; then
    echo "Error: ${v} environment variable is not set"
    exit 1
  fi
done
echo "EL_CHAIN_ID: ${EL_CHAIN_ID}"
echo "CL_CHAIN_ID: ${CL_CHAIN_ID}"
echo "ADMIN_ADDRESS: ${ADMIN_ADDRESS}"
echo "ADMIN_BALANCE_WEI: ${ADMIN_BALANCE_WEI}"

# Generate the EL genesis alloc field (validator set + genesis contracts are
# pre-built in the image against the baked chain ids).
echo "Generating the genesis file..."
cp /opt/data/validator/validators.js validators.js
node generate-genesis.js --bor-chain-id "${EL_CHAIN_ID}" --heimdall-chain-id "${CL_CHAIN_ID}"
if [[ -s "${EL_GENESIS_ALLOC_FILE}" ]]; then
  echo "EL genesis alloc field generated."
else
  echo "Error: ${EL_GENESIS_ALLOC_FILE} does not exist or is empty."
fi

# Append the admin address to the alloc field.
admin_address=$(echo "${ADMIN_ADDRESS}" | sed 's/^0x//')
jq --arg a "${admin_address}" --arg b "${ADMIN_BALANCE_WEI}" \
  '.alloc[$a] = {"balance": $b}' "${EL_GENESIS_ALLOC_FILE}" > tmp.json
mv tmp.json "${EL_GENESIS_ALLOC_FILE}"

# Add the EIP-2935 block hash history contract to the alloc field.
eip2935_address="0000F90827F1C53a10cb7A02335B175320002935"
eip2935_code="0x3373fffffffffffffffffffffffffffffffffffffffe14604657602036036042575f35600143038111604257611fff81430311604257611fff9006545f5260205ff35b5f5ffd5b5f35611fff60014303065500"
jq --arg a "${eip2935_address}" --arg c "${eip2935_code}" \
  '.alloc[$a] = {"balance": "0x0", "code": $c}' "${EL_GENESIS_ALLOC_FILE}" > tmp.json
mv tmp.json "${EL_GENESIS_ALLOC_FILE}"

# Add the alloc field to the temporary EL genesis to create the final EL genesis.
jq --arg key 'alloc' '. + {($key): input | .[$key]}' \
  "${EL_GENESIS_FILE}" "${EL_GENESIS_ALLOC_FILE}" > tmp.json
mv tmp.json "${EL_GENESIS_FILE}"

# Add the current timestamp to the EL genesis.
timestamp=$(printf "0x%x" $(date +%s))
jq --arg t "${timestamp}" '.timestamp = $t' "${EL_GENESIS_FILE}" > tmp.json
mv tmp.json "${EL_GENESIS_FILE}"

# Verify and output the EL genesis file.
if [[ -s "${EL_GENESIS_FILE}" ]]; then
  echo "L2 EL genesis:"
  cat "${EL_GENESIS_FILE}"
else
  echo "Error: ${EL_GENESIS_FILE} does not exist or is empty."
fi
