#!/usr/bin/env bash
set -euxo pipefail

# Deploy Polygon PoS contracts to L1, initialise state and stake for each validator.
# For reference: https://github.com/0xPolygon/pos-contracts/tree/arya/matic-cli/pos-1869

CONTRACT_ADDRESSES_FILE="/opt/contracts/contractAddresses.json"
VALIDATORS_CONFIG_FILE="/opt/contracts/validators.js"

# Setting EL chain id if needed.
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

echo "Processing templates..."
npm run template:process -- --bor-chain-id "${EL_CHAIN_ID}"

echo "Generating interfaces..."
npm run generate:interfaces

echo "Compiling the Polygon PoS contracts..."
forge build

# Deploy Polygon PoS contracts on L1.
if [[ -z "${PRIVATE_KEY}" ]]; then
  echo "Error: PRIVATE_KEY environment variable is not set"
  exit 1
fi
if [[ -z "${L1_RPC_URL}" ]]; then
  echo "Error: L1_RPC_URL environment variable is not set"
  exit 1
fi
if [[ -z "${CL_CHAIN_ID}" ]]; then
  echo "Error: CL_CHAIN_ID environment variable is not set"
  exit 1
fi
echo "L1_RPC_URL: ${L1_RPC_URL}"
echo "CL_CHAIN_ID: ${CL_CHAIN_ID}"

echo "Deploying Polygon PoS contracts to L1, draining StakeManager and initialising state..."
export DEPLOYER_PRIVATE_KEY="${PRIVATE_KEY}"
export HEIMDALL_ID="${CL_CHAIN_ID}"

forge script -vvvv --rpc-url "${L1_RPC_URL}" --broadcast \
  scripts/deployment-scripts/deployContracts.s.sol:DeploymentScript

forge script -vvvv --rpc-url "${L1_RPC_URL}" --broadcast \
  scripts/deployment-scripts/drainStakeManager.s.sol:DrainStakeManagerDeployment

forge script -vvvv --rpc-url "${L1_RPC_URL}" --broadcast \
  scripts/deployment-scripts/initializeState.s.sol:InitializeStateScript

# Swap ERC20/ERC721 predicates for the BurnOnly variants (typed-tx support).
# pos-contracts at d96d5929 deploys ERC20Predicate + ERC721Predicate, whose
# startExitWithBurntTokens does not handle EIP-1559 receipts. Mainnet registered
# the *BurnOnly variants, so do the same here to stay faithful to mainnet.
forge script -vvvv --rpc-url "${L1_RPC_URL}" --broadcast \
  scripts/deployment-scripts/deployBurnOnlyPredicates.s.sol:DeployBurnOnlyPredicatesScript

mkdir -p /opt/contracts
cp contractAddresses.json /opt/contracts

# Set the WithdrawManager exit period to 1 to allow near-immediate exits in the devnet.
# Note: This matches the Sepolia configuration (HALF_EXIT_PERIOD=1, exitWindow=0).
# This is done via cast send instead of a forge script to avoid gas estimation issues.
echo "Updating the WithdrawManager exit period to 1..."
withdraw_manager_proxy_address=$(jq -r '.root.WithdrawManagerProxy' "${CONTRACT_ADDRESSES_FILE}")
cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" \
  "${withdraw_manager_proxy_address}" "updateExitPeriod(uint256)" 1

if [[ -s "${CONTRACT_ADDRESSES_FILE}" ]]; then
  echo "Polygon PoS contracts deployed to L1:"
  cat "${CONTRACT_ADDRESSES_FILE}"
  echo
else
  echo "Error: ${CONTRACT_ADDRESSES_FILE} does not exist or is empty."
fi

# Stake for each validator.
if [[ -z "${VALIDATOR_ACCOUNTS}" ]]; then
  echo "Error: VALIDATOR_ACCOUNTS environment variable is not set"
  exit 1
fi
if [[ -z "${VALIDATOR_BALANCE}" ]]; then
  echo "Error: VALIDATOR_BALANCE environment variable is not set"
  exit 1
fi
if [[ -z "${VALIDATOR_STAKE_AMOUNT_ETH}" ]]; then
  echo "Error: VALIDATOR_STAKE_AMOUNT_ETH environment variable is not set"
  exit 1
fi
if [[ -z "${VALIDATOR_TOP_UP_FEE_AMOUNT_ETH}" ]]; then
  echo "Error: VALIDATOR_TOP_UP_FEE_AMOUNT_ETH environment variable is not set"
  exit 1
fi
echo "VALIDATOR_ACCOUNTS: ${VALIDATOR_ACCOUNTS}"
# Note: VALIDATOR_ACCOUNTS is expected to follow this exact pattern:
# "<address_1>,<eth_public_key_1>;<address_2>,<eth_public_key_2>;..."
echo "VALIDATOR_BALANCE: ${VALIDATOR_BALANCE}"
echo "VALIDATOR_STAKE_AMOUNT_ETH: ${VALIDATOR_STAKE_AMOUNT_ETH}"
echo "VALIDATOR_TOP_UP_FEE_AMOUNT_ETH: ${VALIDATOR_TOP_UP_FEE_AMOUNT_ETH}"

# Update the validator threshold to type(uint256).max.
# Fixes "add new validator" test case in the e2e repo.
# This is necessary to add more validators to the validator set after the initial deployment.
echo "Updating the validator threshold to type(uint256).max..."
validator_threshold=$(cast max-uint)
calldata=$(cast calldata "updateValidatorThreshold(uint)" "${validator_threshold}")

governance_proxy_address=$(jq -r '.root.GovernanceProxy' "${CONTRACT_ADDRESSES_FILE}")
stake_manager_proxy_address=$(jq -r '.root.StakeManagerProxy' "${CONTRACT_ADDRESSES_FILE}")
cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" \
  "${governance_proxy_address}" "update(address,bytes)" "${stake_manager_proxy_address}" "${calldata}"

# Create the validator config file.
jq -n '[]' > "${VALIDATORS_CONFIG_FILE}"

echo "Staking for each validator node..."
IFS=';' read -ra validator_accounts <<< "${VALIDATOR_ACCOUNTS}"
for account in "${validator_accounts[@]}"; do
  IFS=',' read -r address eth_public_key <<< "${account}"
  # Note: MaticStake requires the amount to be specified in wei, not in eth.
  forge script -vvvv --rpc-url "${L1_RPC_URL}" --broadcast \
    scripts/matic-cli-scripts/stake.s.sol:MaticStake \
    --sig "run(address,bytes,uint256,uint256)" \
    "${address}" "${eth_public_key}" "${VALIDATOR_STAKE_AMOUNT_ETH}000000000000000000" "${VALIDATOR_TOP_UP_FEE_AMOUNT_ETH}000000000000000000"

  # Update the validator config file.
  jq --arg address "${address}" --arg stake "${VALIDATOR_STAKE_AMOUNT_ETH}" --arg balance "${VALIDATOR_BALANCE}" \
    '. += [{"address": $address, "stake": ($stake | tonumber), "balance": ($balance | tonumber)}]' \
    "${VALIDATORS_CONFIG_FILE}" > "${VALIDATORS_CONFIG_FILE}.tmp"
  mv "${VALIDATORS_CONFIG_FILE}.tmp" "${VALIDATORS_CONFIG_FILE}"
done
echo "exports = module.exports = $(< ${VALIDATORS_CONFIG_FILE})" > "${VALIDATORS_CONFIG_FILE}"

if [[ -s "${VALIDATORS_CONFIG_FILE}" ]]; then
  echo "Validators config created successfully."
  cat "${VALIDATORS_CONFIG_FILE}"
else
  echo "Error: ${VALIDATORS_CONFIG_FILE} does not exist or is empty."
fi

# Deploy POL token and PolygonMigration, then wire them into the system.
# Validators staked MATIC above (before initializePOL); initializePOL converts that MATIC to POL.
echo "Deploying POL token and PolygonMigration..."
forge script -vvvv --rpc-url "${L1_RPC_URL}" --broadcast \
  scripts/deployment-scripts/deployPolAndMigration.s.sol:DeployPolAndMigrationScript

# Parse deployed addresses from the broadcast JSON.
l1_chain_id=$(cast chain-id --rpc-url "${L1_RPC_URL}")
broadcast_file="/opt/pos-contracts/broadcast/deployPolAndMigration.s.sol/${l1_chain_id}/run-latest.json"
pol_token=$(jq -r '.transactions[] | select(.contractName == "ERC20Permit") | .contractAddress' "${broadcast_file}" | head -1)
migration=$(jq -r '.transactions[] | select(.contractName == "PolygonMigration") | .contractAddress' "${broadcast_file}" | head -1)
echo "POL token: ${pol_token}"
echo "PolygonMigration: ${migration}"

if [[ -z "${pol_token}" || "${pol_token}" == "null" ]]; then
  echo "Error: failed to parse POL token address from broadcast file."
  exit 1
fi
if [[ -z "${migration}" || "${migration}" == "null" ]]; then
  echo "Error: failed to parse PolygonMigration address from broadcast file."
  exit 1
fi

# Merge the new addresses into contractAddresses.json.
jq --arg pol "${pol_token}" --arg migration "${migration}" \
  '.root.tokens.PolToken = $pol | .root.tokens.PolygonMigration = $migration' \
  contractAddresses.json > contractAddresses.json.tmp
mv contractAddresses.json.tmp contractAddresses.json

# POL migration — sequence mirrors mainnet's UpgradeStake_DepositManager_Mainnet batch
# (pos-contracts scripts/deployers/pol-upgrade/...). Steps 2/8 (impl upgrades) are
# skipped because d96d5929 already ships the POL-aware StakeManager and DepositManager.
matic_token=$(jq -r '.root.tokens.MaticToken' "${CONTRACT_ADDRESSES_FILE}")
registry_proxy_address=$(jq -r '.root.Registry' "${CONTRACT_ADDRESSES_FILE}")
deposit_manager_proxy_address=$(jq -r '.root.DepositManagerProxy' "${CONTRACT_ADDRESSES_FILE}")
native_gas_token="0x0000000000000000000000000000000000001010"

# Mainnet step 3: StakeManager.initializePOL — converts StakeManager's MATIC stakes to POL.
echo "Calling StakeManager.initializePOL..."
calldata=$(cast calldata "initializePOL(address,address)" "${pol_token}" "${migration}")
cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" \
  "${governance_proxy_address}" "update(address,bytes)" "${stake_manager_proxy_address}" "${calldata}"

# Mainnet steps 4/5/6: register pol, matic, polygonMigration in the contract map.
echo "Registering pol, matic, polygonMigration in Registry..."
for pair in "pol:${pol_token}" "matic:${matic_token}" "polygonMigration:${migration}"; do
  key="${pair%%:*}"
  addr="${pair##*:}"
  key_hash=$(cast keccak "${key}")
  calldata=$(cast calldata "updateContractMap(bytes32,address)" "${key_hash}" "${addr}")
  cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" \
    "${governance_proxy_address}" "update(address,bytes)" "${registry_proxy_address}" "${calldata}"
  echo "Registered ${key} -> ${addr}"
done

# Mainnet step 7: map POL to the PoS native gas token (0x...1010).
# Sets rootToChildToken[POL] = native and — as a side effect — childToRootToken[native] = POL.
# The reverse overwrite is intentional on mainnet; the ERC20Predicate reads the L1 rootToken
# from the L2 Withdraw event topic, not from childToRootToken, so MATIC withdraws still work.
echo "Mapping POL -> native gas token..."
calldata=$(cast calldata "mapToken(address,address,bool)" "${pol_token}" "${native_gas_token}" false)
cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" \
  "${governance_proxy_address}" "update(address,bytes)" "${registry_proxy_address}" "${calldata}"

# Mainnet step 9: drain DepositManager MATIC into POL. No-op on a fresh devnet
# (DepositManager holds 0 MATIC until users bridge), kept for mainnet parity.
echo "Calling DepositManager.migrateMatic..."
calldata=$(cast calldata "migrateMatic()")
cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" \
  "${governance_proxy_address}" "update(address,bytes)" "${deposit_manager_proxy_address}" "${calldata}"

# Sync the updated contractAddresses.json to /opt/contracts for the kurtosis artifact.
echo "Syncing updated contract addresses to /opt/contracts/..."
cp contractAddresses.json /opt/contracts/contractAddresses.json

if [[ -s "${CONTRACT_ADDRESSES_FILE}" ]]; then
  echo "Final contract addresses:"
  cat "${CONTRACT_ADDRESSES_FILE}"
  echo
fi
