#!/usr/bin/env bash
set -euxo pipefail

# Deploy sPOL/LST contracts to L1 and L2 using the kurtosis PoS devnet addresses.
# Runs inside the pos-contract-deployer image, which bundles the spol-contracts
# source, soldeer deps, and a warm forge cache at /opt/spol-contracts
# (alongside pos-contracts and pos-portal). The kurtosis validator setup script
# is rendered at deploy time and uploaded as the `setup-validators` artifact.

# Drop the rendered setupInitialValidators script into the spol-contracts tree
# so its `import "../../src/sPOLController.sol"` resolves. Lives under
# script/kurtosis/ to disambiguate from upstream's mainnet-id'd
# script/SetupInitialValidators.s.sol.
mkdir -p /opt/spol-contracts/script/kurtosis
cp /opt/data/setup-validators/setupInitialValidators.s.sol \
   /opt/spol-contracts/script/kurtosis/

cd /opt/spol-contracts

# Read addresses from the accumulated PoS artifact. By the time this step runs,
# main.star has executed: plasma-bridge L1 → matic-to-pol migration → pos-bridge
# L1 → plasma-bridge L2 → pos-bridge L2, so PolygonMigration and the
# RootChainManager proxy are real on-chain contracts (no mocks needed).
STAKE_MANAGER=$(jq -re '.root.StakeManagerProxy' /opt/data/pos-addresses/contractAddresses.json)
MATIC_TOKEN_L1=$(jq -re '.root.tokens.MaticToken' /opt/data/pos-addresses/contractAddresses.json)
POL_TOKEN_L1=$(jq -re '.root.tokens.PolToken' /opt/data/pos-addresses/contractAddresses.json)
POLYGON_MIGRATION=$(jq -re '.root.tokens.PolygonMigration' /opt/data/pos-addresses/contractAddresses.json)
WITHDRAW_MANAGER=$(jq -re '.root.WithdrawManagerProxy' /opt/data/pos-addresses/contractAddresses.json)
ERC20_PREDICATE=$(jq -re '.root.predicates.ERC20Predicate' /opt/data/pos-addresses/contractAddresses.json)
DEPOSIT_MANAGER=$(jq -re '.root.DepositManagerProxy' /opt/data/pos-addresses/contractAddresses.json)
STATE_SENDER_L1=$(jq -re '.root.StateSender' /opt/data/pos-addresses/contractAddresses.json)
CHECKPOINT_MANAGER=$(jq -re '.root.RootChainProxy' /opt/data/pos-addresses/contractAddresses.json)
ROOT_CHAIN_MANAGER=$(jq -re '.root.posBridge.RootChainManagerProxy' /opt/data/pos-addresses/contractAddresses.json)
CHILD_CHAIN_MANAGER=$(jq -re '.child.ChildChain' /opt/data/pos-addresses/contractAddresses.json)
STATE_SYNCER_L2="0x0000000000000000000000000000000000001001"
POL_TOKEN_L2="0x0000000000000000000000000000000000001010"
FEE_RECEIVER_VALUE="${FEE_RECEIVER:-$ADMIN_ADDRESS}"
export DEPLOYER_PRIVATE_KEY="${PRIVATE_KEY}"

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
# Forge runs against L1_RPC_URL as primary; the script reaches L2 internally
# via vm.createSelectFork(L2_RPC_URL) on a per-tx basis. L2_RPC_URL and
# L2_CHAIN_ID are read from the input.json scenario above, not from the forge
# CLI here. --non-interactive suppresses the multi-chain broadcast confirmation
# prompt that forge shows when vm.createSelectFork() is used in the script.
forge script script/Deploy.s.sol:Deploy \
  --sig 'run(string)' 'ethereum-polygon' \
  --rpc-url "${L1_RPC_URL}" --broadcast --legacy --non-interactive

# Write output artifact
mkdir -p /opt/lst
cp script/deployment.json /opt/lst/lstContractAddresses.json
echo "LST contracts deployed:"
cat /opt/lst/lstContractAddresses.json

# Setup initial validators.
# Uses the rendered kurtosis-specific script (validator count baked at devnet
# launch time, ids 1..N matching the on-chain stake order) rather than the
# mainnet/testnet ids (188, 92) hardcoded in upstream's SetupInitialValidators.
forge script script/kurtosis/setupInitialValidators.s.sol:SetupInitialValidators \
  --rpc-url "${L1_RPC_URL}" --broadcast --legacy
