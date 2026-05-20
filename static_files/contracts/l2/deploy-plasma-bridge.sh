#!/usr/bin/env bash
set -euxo pipefail

# Deploy MATIC contracts to L2 and synchronize state on L1.
# For reference: https://github.com/0xPolygon/pos-contracts/tree/arya/matic-cli/pos-1869

CONTRACT_ADDRESSES_FILE="/opt/contracts/contractAddresses.json"

cd /opt/pos-contracts-anvil-pos

echo "Copying contract addresses file..."
cp /opt/data/addresses/contractAddresses.json /opt/pos-contracts-anvil-pos/contractAddresses.json

# Deploy Polygon PoS contracts on L2.
if [[ -z "${PRIVATE_KEY}" ]]; then
	echo "Error: PRIVATE_KEY environment variable is not set"
	exit 1
fi
if [[ -z "${L1_RPC_URL}" ]]; then
	echo "Error: L1_RPC_URL environment variable is not set"
	exit 1
fi
if [[ -z "${L2_RPC_URL}" ]]; then
	echo "Error: L2_RPC_URL environment variable is not set"
	exit 1
fi
echo "L1_RPC_URL: ${L1_RPC_URL}"
echo "L2_RPC_URL: ${L2_RPC_URL}"

echo "Deploying Polygon PoS contracts to L2..."
export DEPLOYER_PRIVATE_KEY="${PRIVATE_KEY}"

forge script -vvvv --rpc-url "${L2_RPC_URL}" --broadcast --legacy \
	scripts/deployment-scripts/childContractDeployment.s.sol:ChildContractDeploymentScript

echo "Mapping L2 contracts to the registry on L1..."
forge script -vvvv --rpc-url "${L1_RPC_URL}" --broadcast --legacy \
	scripts/deployment-scripts/syncChildStateToRoot.s.sol:SyncChildStateToRootScript

mkdir -p /opt/contracts
mv contractAddresses.json /opt/contracts

if [[ -s "${CONTRACT_ADDRESSES_FILE}" ]]; then
	echo "Polygon PoS contracts deployed to L1 and L2:"
	cat "${CONTRACT_ADDRESSES_FILE}"
else
	echo "Error: ${CONTRACT_ADDRESSES_FILE} does not exist or is empty."
fi
