#!/usr/bin/env bash
set -euxo pipefail

# Deploy sPOL/LST contracts to L1 and L2 using the kurtosis PoS devnet addresses.
# Runs inside the spol-contract-deployer image, which ships with the spol-contracts
# source, kurtosis mocks, pre-installed soldeer deps, and a warm forge cache at
# /opt/spol-contracts.

cd /opt/spol-contracts

# Read addresses from kurtosis PoS artifact
STAKE_MANAGER=$(jq -r '.root.StakeManagerProxy' /opt/data/pos-addresses/contractAddresses.json)
MATIC_TOKEN_L1=$(jq -r '.root.tokens.MaticToken' /opt/data/pos-addresses/contractAddresses.json)
POL_TOKEN_L1=$(jq -r '.root.tokens.PolToken' /opt/data/pos-addresses/contractAddresses.json)
WITHDRAW_MANAGER=$(jq -r '.root.WithdrawManagerProxy' /opt/data/pos-addresses/contractAddresses.json)
ERC20_PREDICATE=$(jq -r '.root.predicates.ERC20Predicate' /opt/data/pos-addresses/contractAddresses.json)
DEPOSIT_MANAGER=$(jq -r '.root.DepositManagerProxy' /opt/data/pos-addresses/contractAddresses.json)
STATE_SENDER_L1=$(jq -r '.root.StateSender' /opt/data/pos-addresses/contractAddresses.json)
CHECKPOINT_MANAGER=$(jq -r '.root.RootChainProxy' /opt/data/pos-addresses/contractAddresses.json)
CHILD_CHAIN_MANAGER=$(jq -r '.child.ChildChain' /opt/data/pos-addresses/contractAddresses.json)
STATE_SYNCER_L2="0x0000000000000000000000000000000000001001"
POL_TOKEN_L2="0x0000000000000000000000000000000000001010"
FEE_RECEIVER_VALUE="${FEE_RECEIVER:-$ADMIN_ADDRESS}"

# Deploy mock PolygonMigration + RootChainManager on L1 — the real contracts
# don't exist in a fresh devnet. The sPOL deploy needs their addresses for
# wiring so we run DeployMocks first and read the result out of mockAddresses.json.
export DEPLOYER_PRIVATE_KEY="${PRIVATE_KEY}"
forge script script/mock/DeployMocks.s.sol:DeployMocksScript \
  --rpc-url "${L1_RPC_URL}" --broadcast --legacy

POLYGON_MIGRATION=$(jq -r '.polygonMigration' script/mockAddresses.json)
ROOT_CHAIN_MANAGER=$(jq -r '.rootChainManager' script/mockAddresses.json)

# Build the kurtosis-devnet scenario and write it under the "ethereum-polygon"
# top-level key. loadConfigFromJson reads addresses from whatever top-level key
# matches the scenario name we pass, but it has a hardcoded existence check
# against ".ethereum-polygon"; using that key satisfies the check without
# needing a change in spol-contracts.
jq -n \
  --arg saltPrefix "kurtosis-" \
  --argjson chainIdL1 "${L1_CHAIN_ID}" \
  --argjson chainIdL2 "${L2_CHAIN_ID}" \
  --arg polTokenL1 "${POL_TOKEN_L1}" \
  --arg polTokenL2 "${POL_TOKEN_L2}" \
  --arg maticTokenL1 "${MATIC_TOKEN_L1}" \
  --arg polygonMigration "${POLYGON_MIGRATION}" \
  --arg stakeManager "${STAKE_MANAGER}" \
  --arg admin "${ADMIN_ADDRESS}" \
  --arg feeReceiver "${FEE_RECEIVER_VALUE}" \
  --argjson rewardFee "${REWARD_FEE:-50}" \
  --argjson maxDivergence "${MAX_DIVERGENCE:-10}" \
  --arg withdrawManager "${WITHDRAW_MANAGER}" \
  --arg erc20predicate "${ERC20_PREDICATE}" \
  --arg childChainManager "${CHILD_CHAIN_MANAGER}" \
  --arg rootChainManager "${ROOT_CHAIN_MANAGER}" \
  --arg rcmERC20Predicate "${ERC20_PREDICATE}" \
  --arg depositManager "${DEPOSIT_MANAGER}" \
  --arg stateSenderL1 "${STATE_SENDER_L1}" \
  --arg checkpointManager "${CHECKPOINT_MANAGER}" \
  --arg stateSyncerL2 "${STATE_SYNCER_L2}" \
  '{
    "ethereum-polygon": {
      scenarioName: "kurtosis-devnet",
      saltPrefix: $saltPrefix,
      chainIdL1: $chainIdL1,
      chainIdL2: $chainIdL2,
      polTokenL1: $polTokenL1,
      polTokenL2: $polTokenL2,
      maticTokenL1: $maticTokenL1,
      polygonMigration: $polygonMigration,
      stakeManager: $stakeManager,
      admin: $admin,
      feeReceiver: $feeReceiver,
      rewardFee: $rewardFee,
      maxDivergence: $maxDivergence,
      withdrawManager: $withdrawManager,
      erc20predicate: $erc20predicate,
      childChainManager: $childChainManager,
      rootChainManager: $rootChainManager,
      rcmERC20Predicate: $rcmERC20Predicate,
      depositManager: $depositManager,
      stateSenderL1: $stateSenderL1,
      checkpointManager: $checkpointManager,
      stateSyncerL2: $stateSyncerL2
    }
  }' > script/input.json

# Deploy sPOL contracts L1 then L2 via the existing run(string) entrypoint.
# --non-interactive suppresses the multi-chain broadcast confirmation prompt
# that forge shows when vm.createSelectFork() is used in the script.
forge script script/Deploy.s.sol:Deploy \
  --sig 'run(string)' 'ethereum-polygon' \
  --rpc-url "${L1_RPC_URL}" --broadcast --legacy --non-interactive

# Write output artifact
mkdir -p /opt/lst
cp script/deployment.json /opt/lst/lstContractAddresses.json
echo "LST contracts deployed:"
cat /opt/lst/lstContractAddresses.json

# Setup initial validators.
# Uses the kurtosis-specific script which assumes validator ID 1 (the single
# validator registered in the kurtosis devnet) rather than mainnet IDs 188/92.
forge script script/mock/SetupInitialValidatorsKurtosis.s.sol:SetupInitialValidatorsKurtosis \
  --rpc-url "${L1_RPC_URL}" --broadcast --legacy
