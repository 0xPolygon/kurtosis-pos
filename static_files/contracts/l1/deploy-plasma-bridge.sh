#!/usr/bin/env bash
set -euxo pipefail

# Deploy Polygon PoS contracts to L1, initialise state and stake for each validator.
# For reference: https://github.com/0xPolygon/pos-contracts/tree/arya/matic-cli/pos-1869

CONTRACT_ADDRESSES_FILE="/opt/contracts/contractAddresses.json"
VALIDATORS_CONFIG_FILE="/opt/contracts/validators.js"

cd /opt/pos-contracts-anvil-pos

# Contracts are compiled at image-build time against the image's baked chain ID.
# Custom L2 chain IDs are not supported — rebuild the image with a different
# EL_CHAIN_ID build arg if you need another value.

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

# Lower StakeManager.dynasty + WITHDRAWAL_DELAY to 1 epoch so a validator
# unstake becomes claimable one checkpoint after it is opened, not the
# mainnet-scaled default (`dynasty = 886` epochs, ~50 days;
# `WITHDRAWAL_DELAY = 2^13` epochs). Both fields gate the delay before
# `StakeManager.unstakeClaim(validatorId)` is permitted — and transitively
# gate `sPOLController.withdrawPOL(user)`, which aggregates per-validator
# nonces for an sPOL seller. Without this override, a fast-cadence kurtosis
# devnet still cannot observe the sPOL burn → checkpoint → withdrawPOL
# chain in test-timeout bounds; with the delay at 1 epoch the unbond clears
# in roughly one `avg_checkpoint_length` × bor block-time window (~16-25s
# at the current cadence settings). `updateDynastyValue` is
# `onlyGovernance` and sets BOTH fields in one call. Matches the existing
# WithdrawManager `exitPeriod=1` override above — same test-devnet contract.
echo "Updating the StakeManager dynasty to 1 (near-immediate stake unbond)..."
dynasty_calldata=$(cast calldata "updateDynastyValue(uint256)" 1)
cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" \
  "${governance_proxy_address}" "update(address,bytes)" "${stake_manager_proxy_address}" "${dynasty_calldata}"

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

cp contractAddresses.json "${CONTRACT_ADDRESSES_FILE}"
if [[ -s "${CONTRACT_ADDRESSES_FILE}" ]]; then
  echo "Plasma bridge deployed. contractAddresses.json:"
  cat "${CONTRACT_ADDRESSES_FILE}"
else
  echo "Error: ${CONTRACT_ADDRESSES_FILE} does not exist or is empty."
  exit 1
fi
