#!/usr/bin/env bash
set -euxo pipefail

# Migrate MATIC to POL on L1. Deploys the production PolygonEcosystemToken and PolygonMigration
# from 0xPolygon/pol-token (mainnet deploy shape, see deployPolAndMigration.s.sol), then mirrors the
# mainnet UpgradeStake_DepositManager_Mainnet batch (pos-contracts scripts/deployers/pol-upgrade/...)
# — steps 2/8 (impl upgrades) are skipped because d96d5929 already ships the POL-aware StakeManager
# and DepositManager.

CONTRACT_ADDRESSES_FILE="/opt/contracts/contractAddresses.json"

for v in PRIVATE_KEY L1_RPC_URL; do
  if [[ -z "${!v:-}" ]]; then
    echo "Error: ${v} is not set"
    exit 1
  fi
done

cd /opt/pol-token

echo "Copying contract addresses file..."
mkdir -p /opt/contracts
cp /opt/data/addresses/contractAddresses.json ./contractAddresses.json

echo "Deploying POL token and PolygonMigration..."
export DEPLOYER_PRIVATE_KEY="${PRIVATE_KEY}"
forge script -vvvv --hardfork "${L1_HARDFORK}" --rpc-url "${L1_RPC_URL}" --broadcast \
  script/deployPolAndMigration.s.sol:DeployPolAndMigrationScript

# Parse deployed addresses from the broadcast JSON. PolygonMigration is reached through its
# TransparentUpgradeableProxy; require exactly one of each so a future extra proxy or token
# deployment in the script cannot be parsed by mistake.
l1_chain_id=$(cast chain-id --rpc-url "${L1_RPC_URL}")
broadcast_file="/opt/pol-token/broadcast/deployPolAndMigration.s.sol/${l1_chain_id}/run-latest.json"
created() {
  jq -r --arg name "$1" \
    '[.transactions[] | select(.contractName == $name and .transactionType == "CREATE") | .contractAddress]' \
    "${broadcast_file}"
}
pol_tokens=$(created PolygonEcosystemToken)
migrations=$(created TransparentUpgradeableProxy)
if [[ $(jq length <<< "${pol_tokens}") -ne 1 || $(jq length <<< "${migrations}") -ne 1 ]]; then
  echo "Error: expected exactly one PolygonEcosystemToken and one TransparentUpgradeableProxy (PolygonMigration) in ${broadcast_file}."
  echo "PolygonEcosystemToken: ${pol_tokens}"
  echo "TransparentUpgradeableProxy: ${migrations}"
  exit 1
fi
pol_token=$(jq -r '.[0]' <<< "${pol_tokens}")
migration=$(jq -r '.[0]' <<< "${migrations}")
echo "POL token: ${pol_token}"
echo "PolygonMigration: ${migration}"

# Merge the new addresses into contractAddresses.json.
jq --arg pol "${pol_token}" --arg migration "${migration}" \
  '.root.tokens.PolToken = $pol | .root.tokens.PolygonMigration = $migration' \
  contractAddresses.json > contractAddresses.json.tmp
mv contractAddresses.json.tmp contractAddresses.json

matic_token=$(jq -r '.root.tokens.MaticToken' contractAddresses.json)
registry_proxy_address=$(jq -r '.root.Registry' contractAddresses.json)
governance_proxy_address=$(jq -r '.root.GovernanceProxy' contractAddresses.json)
stake_manager_proxy_address=$(jq -r '.root.StakeManagerProxy' contractAddresses.json)
deposit_manager_proxy_address=$(jq -r '.root.DepositManagerProxy' contractAddresses.json)
native_gas_token="0x0000000000000000000000000000000000001010"

# Mainnet step 3: StakeManager.initializePOL — converts StakeManager's MATIC stakes to POL.
echo "Calling StakeManager.initializePOL..."
calldata=$(cast calldata "initializePOL(address,address)" "${pol_token}" "${migration}")
cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" \
  "${governance_proxy_address}" "update(address,bytes)" "${stake_manager_proxy_address}" "${calldata}"

# Rewards are paid out of StakeManager's POL balance, which on mainnet the emission manager
# tops up. Without it, withdrawRewardsPOL and unstakePOL revert once rewards exceed the stakes.
echo "Funding StakeManager with POL for validator rewards..."
cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" \
  "${pol_token}" "transfer(address,uint256)" "${stake_manager_proxy_address}" 1000000ether

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

cp contractAddresses.json "${CONTRACT_ADDRESSES_FILE}"
if [[ -s "${CONTRACT_ADDRESSES_FILE}" ]]; then
  echo "POL migration complete. Updated contractAddresses.json:"
  cat "${CONTRACT_ADDRESSES_FILE}"
else
  echo "Error: ${CONTRACT_ADDRESSES_FILE} does not exist or is empty."
  exit 1
fi
