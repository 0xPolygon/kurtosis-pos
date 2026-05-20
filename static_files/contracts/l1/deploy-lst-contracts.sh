#!/usr/bin/env bash
set -euxo pipefail

# Deploy sPOL/LST contracts to L1 and L2 using the kurtosis PoS devnet addresses.
# Runs inside the pos-contract-deployer image, which bundles the spol-contracts
# source, soldeer deps, and a warm forge cache at /opt/spol-contracts
# (alongside pos-contracts and pos-portal).

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
  }' >script/input.json

# Deploy sPOL contracts L1 then L2 via the existing run(string) entrypoint.
# Forge runs against L1_RPC_URL as primary; the script reaches L2 internally
# via vm.createSelectFork(L2_RPC_URL) on a per-tx basis. L2_RPC_URL and
# L2_CHAIN_ID are read from the input.json scenario above, not from the forge
# CLI here. --non-interactive suppresses the multi-chain broadcast confirmation
# prompt that forge shows when vm.createSelectFork() is used in the script.
forge script script/Deploy.s.sol:Deploy \
	--sig 'run(string)' 'ethereum-polygon' \
	--rpc-url "${L1_RPC_URL}" --broadcast --legacy --non-interactive

# Merge LST addresses into the accumulated contractAddresses.json so a single
# artifact carries plasma + matic-to-pol + pos-bridge + spol. Upstream's
# script/deployment.json has sPOL_L1 / sPOL_L2 top-level keys; nest them under
# .root.spol / .child.spol to match the existing root/child layout.
mkdir -p /opt/contracts
jq -s '.[0] as $pos | .[1] as $spol
  | $pos
  | .root.spol = $spol.sPOL_L1
  | .child.spol = $spol.sPOL_L2' \
	/opt/data/pos-addresses/contractAddresses.json script/deployment.json \
	>/opt/contracts/contractAddresses.json
echo "LST contracts deployed. Updated contractAddresses.json:"
cat /opt/contracts/contractAddresses.json

# Setup initial validators. Mirrors mainnet's canonical
# spol-contracts/script/SetupInitialValidators.s.sol but ranges over kurtosis'
# sequential validator ids (1..VALIDATOR_COUNT) rather than the mainnet/testnet
# ids (188, 92) it hardcodes. Inlined here in bash to keep all kurtosis-specific
# orchestration in one place — the upstream forge scripts in script/ are only
# used when a forge multi-step deploy genuinely needs Solidity (e.g. CREATE2 +
# vm.createSelectFork in Deploy.s.sol).
for v in VALIDATOR_COUNT INITIAL_DEPOSIT_WEI ADMIN_ADDRESS; do
	if [[ -z "${!v:-}" ]]; then
		echo "Error: ${v} is not set"
		exit 1
	fi
done

CONTROLLER=$(jq -re '.sPOL_L1.sPOLControllerProxy' script/deployment.json)
SPOL_TOKEN=$(jq -re '.sPOL_L1.sPOLProxy' script/deployment.json)
DEAD="0x000000000000000000000000000000000000dEaD"

# 1. Add every kurtosis-registered validator (ids are 1..N, sequential).
for ((i = 1; i <= VALIDATOR_COUNT; i++)); do
	cast send "${CONTROLLER}" "addValidator(uint16)" "$i" \
		--rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" --legacy >/dev/null
	echo "Validator added: $i"
done

# 2. Distribute deposit shares equally. Remainder from integer division goes to
# validator 1 so the shares always sum to 100.
base_share=$((100 / VALIDATOR_COUNT))
remainder=$((100 - base_share * VALIDATOR_COUNT))
val_ids="1"
shares="$((base_share + remainder))"
for ((i = 2; i <= VALIDATOR_COUNT; i++)); do
	val_ids="${val_ids},${i}"
	shares="${shares},${base_share}"
done
cast send "${CONTROLLER}" "updateValidatorTargetShare(uint16[],uint8[])" \
	"[${val_ids}]" "[${shares}]" \
	--rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" --legacy >/dev/null
echo "Deposit shares set across ${VALIDATOR_COUNT} validators (base=${base_share}%, validator-1=$((base_share + remainder))%)"

# 3. Bootstrap deposit so the controller has non-zero state when the e2e tests
# start. Mirrors mainnet's bootstrap (sPOL-contracts/script/SetupInitialValidators.s.sol).
POL_TOKEN=$(cast call "${CONTROLLER}" "polToken()(address)" --rpc-url "${L1_RPC_URL}")
cast send "${POL_TOKEN}" "approve(address,uint256)" "${CONTROLLER}" "${INITIAL_DEPOSIT_WEI}" \
	--rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" --legacy >/dev/null
cast send "${CONTROLLER}" "buySPOL(uint256)" "${INITIAL_DEPOSIT_WEI}" \
	--rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" --legacy >/dev/null
spol_minted=$(cast call "${SPOL_TOKEN}" "balanceOf(address)(uint256)" "${ADMIN_ADDRESS}" --rpc-url "${L1_RPC_URL}" | awk '{print $1}')
echo "sPOL minted to deployer: ${spol_minted}"

# 4. Lock the bootstrap sPOL at 0xdead — it is not meant to be redeemed.
cast send "${SPOL_TOKEN}" "transfer(address,uint256)" "${DEAD}" "${spol_minted}" \
	--rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" --legacy >/dev/null
echo "sPOL locked at 0xdead: ${spol_minted}"

# Verify state.
dead_balance=$(cast call "${SPOL_TOKEN}" "balanceOf(address)(uint256)" "${DEAD}" --rpc-url "${L1_RPC_URL}" | awk '{print $1}')
deployer_balance=$(cast call "${SPOL_TOKEN}" "balanceOf(address)(uint256)" "${ADMIN_ADDRESS}" --rpc-url "${L1_RPC_URL}" | awk '{print $1}')
if [[ "${dead_balance}" == "0" ]]; then
	echo "Error: bootstrap sPOL not at dead address"
	exit 1
fi
if [[ "${deployer_balance}" != "0" ]]; then
	echo "Error: deployer should hold 0 sPOL after lock, got ${deployer_balance}"
	exit 1
fi
echo "Kurtosis devnet validator setup complete!"
