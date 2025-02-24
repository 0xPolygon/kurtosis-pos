#!/usr/bin/env bash
set -euxo pipefail

# Build MATIC chain genesis.
# For reference: https://github.com/maticnetwork/genesis-contracts

# Checking environment variables.
if [[ -z "${EL_CHAIN_ID}" ]]; then
  echo "Error: EL_CHAIN_ID environment variable is not set"
  exit 1
fi
if [[ -z "${DEFAULT_EL_CHAIN_ID}" ]]; then
  echo "Error: DEFAULT_EL_CHAIN_ID environment variable is not set"
  exit 1
fi
echo "EL_CHAIN_ID: ${EL_CHAIN_ID}"
echo "DEFAULT_EL_CHAIN_ID: ${DEFAULT_EL_CHAIN_ID}"

if [[ -z "${CL_CHAIN_ID}" ]]; then
  echo "Error: CL_CHAIN_ID environment variable is not set"
  exit 1
fi
if [[ -z "${DEFAULT_CL_CHAIN_ID}" ]]; then
  echo "Error: DEFAULT_CL_CHAIN_ID environment variable is not set"
  exit 1
fi
echo "CL_CHAIN_ID: ${CL_CHAIN_ID}"
echo "DEFAULT_CL_CHAIN_ID: ${DEFAULT_CL_CHAIN_ID}"

# Regenerate the validator set if needed.
if [[ "${EL_CHAIN_ID}" == "${DEFAULT_EL_CHAIN_ID}" && "${CL_CHAIN_ID}" == "${DEFAULT_CL_CHAIN_ID}" ]]; then
  echo "There is no need to regenerate the validator set since EL_CHAIN_ID and CL_CHAIN_ID are already set to their default values."
else
  echo "Generating the validator set since EL_CHAIN_ID and/or CL_CHAIN_ID are different than the default values..."
  node generate-borvalidatorset.js --bor-chain-id "${EL_CHAIN_ID}" --heimdall-chain-id "${CL_CHAIN_ID}"

  echo "Re-compiling the genesis contracts..."
  truffle compile
fi

# Generate the genesis file.
echo "Generating the genesis file..."
cp /opt/data/validator/validators.js validators.js
node generate-genesis.js --bor-chain-id "${EL_CHAIN_ID}" --heimdall-chain-id "${CL_CHAIN_ID}"
