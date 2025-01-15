#!/usr/bin/env bash
set -euxo pipefail

# Build MATIC child chain genesis.
# For reference: https://github.com/maticnetwork/genesis-contracts

# Checking environment variables.
if [[ -z "${BOR_ID}" ]]; then
  echo "Error: BOR_ID environment variable is not set"
  exit 1
fi
if [[ -z "${DEFAULT_BOR_ID}" ]]; then
  echo "Error: DEFAULT_BOR_ID environment variable is not set"
  exit 1
fi
echo "BOR_ID: ${BOR_ID}"
echo "DEFAULT_BOR_ID: ${DEFAULT_BOR_ID}"

if [[ -z "${CL_ID}" ]]; then
  echo "Error: CL_ID environment variable is not set"
  exit 1
fi
if [[ -z "${DEFAULT_CL_ID}" ]]; then
  echo "Error: DEFAULT_CL_ID environment variable is not set"
  exit 1
fi
echo "CL_ID: ${CL_ID}"
echo "DEFAULT_CL_ID: ${DEFAULT_CL_ID}"

# Regenerate the validator set if needed.
if [[ "${BOR_ID}" == "${DEFAULT_BOR_ID}" && "${CL_ID}" == "${DEFAULT_CL_ID}" ]]; then
  echo "There is no need to regenerate the validator set since BOR_ID and CL_ID are already set to their default values."
else
  echo "Generating the validator set since BOR_ID and/or CL_ID are different than the default values..."
  node generate-borvalidatorset.js --bor-chain-id "${BOR_ID}" --heimdall-chain-id "${CL_ID}"

  echo "Re-compiling the genesis contracts..."
  truffle compile
fi

# Generate the genesis file.
echo "Generating the genesis file..."
cp /opt/data/validator/validators.js validators.js
node generate-genesis.js --bor-chain-id "${BOR_ID}" --heimdall-chain-id "${CL_ID}"
