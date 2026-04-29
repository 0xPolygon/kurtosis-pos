#!/usr/bin/env bash
set -euxo pipefail

# Deploy pos-bridge L2 (child) contracts, then do the final cross-chain wiring on L1
# (RootChainManager.setChildChainManagerAddress + mapToken per token pair).

CONTRACT_ADDRESSES_FILE="/opt/contracts/contractAddresses.json"

for v in PRIVATE_KEY L1_RPC_URL L2_RPC_URL; do
  if [[ -z "${!v:-}" ]]; then
    echo "Error: ${v} is not set"
    exit 1
  fi
done

cd /opt/pos-portal

echo "Copying contract addresses file..."
mkdir -p /opt/contracts
cp /opt/data/addresses/contractAddresses.json /opt/pos-portal/contractAddresses.json

echo "Deploying pos-bridge L2 (child) contracts..."
export DEPLOYER_PRIVATE_KEY="${PRIVATE_KEY}"
forge script -vvvv --rpc-url "${L2_RPC_URL}" --broadcast --legacy \
  scripts/deployment-scripts/deployPosBridgeChild.s.sol:DeployPosBridgeChildScript

# Cross-chain wiring on L1: L2-side addresses are now known, so RootChainManager can be
# pointed at the ChildChainManager and tokens can be mapped. Kept in bash rather than a
# third forge script to avoid re-reading artifacts for a handful of cast sends.
rcm_proxy=$(jq -r '.root.posBridge.RootChainManagerProxy' contractAddresses.json)
ccm_proxy=$(jq -r '.child.posBridge.ChildChainManagerProxy' contractAddresses.json)
state_sender=$(jq -r '.root.StateSender' contractAddresses.json)

echo "Setting ChildChainManagerAddress on RootChainManager..."
cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" --legacy \
  "${rcm_proxy}" "setChildChainManagerAddress(address)" "${ccm_proxy}"

# Pair (sender=RootChainManagerProxy, receiver=ChildChainManagerProxy) in the StateSender so
# RootChainManager.mapToken's state-sync emit passes StateSender.onlyRegistered. Without
# this the first mapToken reverts with "Invalid sender" from StateSender.syncState.
echo "Registering (RCM -> CCM) in StateSender..."
cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" --legacy \
  "${state_sender}" "register(address,address)" "${rcm_proxy}" "${ccm_proxy}"

# Token type ids that RootChainManager.mapToken keys on.
erc20_type=$(cast keccak "ERC20")
erc721_type=$(cast keccak "ERC721")
erc1155_type=$(cast keccak "ERC1155")
ether_type=$(cast keccak "Ether")
mintable_erc20_type=$(cast keccak "MintableERC20")
# MintableERC721Predicate hardcodes this value rather than keccak256("MintableERC721").
mintable_erc721_type="0xd4392723c111fcb98b073fe55873efb447bcd23cd3e49ec9ea2581930cd01ddc"
mintable_erc1155_type=$(cast keccak "MintableERC1155")

# Ether "root" is the canonical sentinel; matches pos-portal mainnet config.
ether_root="0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE"

for pair in \
    "ERC20:$(jq -r '.root.posBridge.DummyERC20' contractAddresses.json):$(jq -r '.child.posBridge.DummyERC20' contractAddresses.json):${erc20_type}" \
    "MintableERC20:$(jq -r '.root.posBridge.DummyMintableERC20' contractAddresses.json):$(jq -r '.child.posBridge.DummyMintableERC20' contractAddresses.json):${mintable_erc20_type}" \
    "ERC721:$(jq -r '.root.posBridge.DummyERC721' contractAddresses.json):$(jq -r '.child.posBridge.DummyERC721' contractAddresses.json):${erc721_type}" \
    "MintableERC721:$(jq -r '.root.posBridge.DummyMintableERC721' contractAddresses.json):$(jq -r '.child.posBridge.DummyMintableERC721' contractAddresses.json):${mintable_erc721_type}" \
    "ERC1155:$(jq -r '.root.posBridge.DummyERC1155' contractAddresses.json):$(jq -r '.child.posBridge.DummyERC1155' contractAddresses.json):${erc1155_type}" \
    "MintableERC1155:$(jq -r '.root.posBridge.DummyMintableERC1155' contractAddresses.json):$(jq -r '.child.posBridge.DummyMintableERC1155' contractAddresses.json):${mintable_erc1155_type}" \
    "Ether:${ether_root}:$(jq -r '.child.posBridge.MaticWETH' contractAddresses.json):${ether_type}"; do
  IFS=':' read -r label root_token child_token tt <<< "${pair}"
  # Idempotency: cl-el-genesis re-deploy hits these contracts a second time. mapToken
  # reverts with ALREADY_MAPPED if rootToken already has a child mapping, so skip when
  # the existing mapping already points to the expected child (re-deploys land at the
  # same address via CREATE-nonce determinism). If it points elsewhere, the deploy
  # order has drifted and L1 routes to stale addresses — fail loud rather than skip.
  current_child=$(cast call --rpc-url "${L1_RPC_URL}" \
    "${rcm_proxy}" "rootToChildToken(address)(address)" "${root_token}")
  if [[ "${current_child}" != "0x0000000000000000000000000000000000000000" ]]; then
    if [[ "${current_child,,}" == "${child_token,,}" ]]; then
      echo "Skipping ${label} (${root_token}) — already mapped to ${current_child}"
      continue
    fi
    echo "ERROR: ${label} (${root_token}) is mapped to ${current_child} on L1 but the" \
      "current deploy produced ${child_token}. L1 routes to a stale child contract." >&2
    exit 1
  fi
  echo "Mapping ${label} (${root_token} <-> ${child_token}) on RootChainManager..."
  cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" --legacy \
    "${rcm_proxy}" "mapToken(address,address,bytes32)" "${root_token}" "${child_token}" "${tt}"
done

cp contractAddresses.json "${CONTRACT_ADDRESSES_FILE}"
if [[ -s "${CONTRACT_ADDRESSES_FILE}" ]]; then
  echo "pos-bridge L2 deploy + cross-chain wiring complete. Final contractAddresses.json:"
  cat "${CONTRACT_ADDRESSES_FILE}"
else
  echo "Error: ${CONTRACT_ADDRESSES_FILE} does not exist or is empty."
  exit 1
fi
