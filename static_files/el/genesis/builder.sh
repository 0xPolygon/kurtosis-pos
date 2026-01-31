#!/usr/bin/env sh
# The shebang was changed from bash to sh for compatibility with the badouralix/curl-jq image.
set -eux

# Build L2 EL genesis file.
EL_GENESIS_FILE="/opt/data/genesis/genesis.json"

# Checking environment variables.
if [[ -z "${VALIDATOR_ALLOC}" ]]; then
  echo "Error: VALIDATOR_ALLOC environment variable is not set"
  exit 1
fi
echo "VALIDATOR_ALLOC: ${VALIDATOR_ALLOC}"

if [[ -z "${ADMIN_ADDRESS}" ]]; then
  echo "Error: ADMIN_ADDRESS environment variable is not set"
  exit 1
fi
if [[ -z "${ADMIN_BALANCE_WEI}" ]]; then
  echo "Error: ADMIN_BALANCE_WEI environment variable is not set"
  exit 1
fi
echo "ADMIN_ADDRESS: ${ADMIN_ADDRESS}"
echo "ADMIN_BALANCE_WEI: ${ADMIN_BALANCE_WEI}"

# The genesis file is already generated using a template.
jq . /opt/data/genesis/genesis-tmp.json >"${EL_GENESIS_FILE}"

# Append the validator alloc to the alloc field.
jq --argjson a "${VALIDATOR_ALLOC}" '.alloc = (.alloc + $a)' "${EL_GENESIS_FILE}" > tmp.json
mv tmp.json "${EL_GENESIS_FILE}"

# Append the admin address to the alloc field.
admin_address=$(echo "${ADMIN_ADDRESS}" | sed 's/^0x//')
jq --arg a "${admin_address}" --arg b "${ADMIN_BALANCE_WEI}" '.alloc[$a] = {"balance": $b}' "${EL_GENESIS_FILE}" >tmp.json
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
