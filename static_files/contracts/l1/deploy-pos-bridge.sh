#!/usr/bin/env bash
set -euxo pipefail

# Deploy pos-bridge L1 (root) contracts on top of an existing pos-contracts deployment.
# Mirrors mainnet maticnetwork/pos-portal.

CONTRACT_ADDRESSES_FILE="/opt/contracts/contractAddresses.json"

for v in PRIVATE_KEY L1_RPC_URL; do
  if [[ -z "${!v:-}" ]]; then
    echo "Error: ${v} is not set"
    exit 1
  fi
done

cd /opt/pos-portal

echo "Copying contract addresses file..."
mkdir -p /opt/contracts
cp /opt/data/addresses/contractAddresses.json /opt/pos-portal/contractAddresses.json

echo "Deploying pos-bridge L1 (root) contracts..."
export DEPLOYER_PRIVATE_KEY="${PRIVATE_KEY}"
forge script -vvvv --rpc-url "${L1_RPC_URL}" --broadcast --legacy \
  scripts/deployment-scripts/deployPosBridgeRoot.s.sol:DeployPosBridgeRootScript

cp contractAddresses.json "${CONTRACT_ADDRESSES_FILE}"
if [[ -s "${CONTRACT_ADDRESSES_FILE}" ]]; then
  echo "pos-bridge L1 deployed. Updated contractAddresses.json:"
  cat "${CONTRACT_ADDRESSES_FILE}"
else
  echo "Error: ${CONTRACT_ADDRESSES_FILE} does not exist or is empty."
  exit 1
fi
