#!/usr/bin/env bash
set -euxo pipefail

# Upgrade the on-chain ValidatorShare implementation to the version mainnet
# runs (pos-contracts/main, not anvil-pos/d96d5929).
#
# # Why this exists
#
# anvil-pos pinned at d96d5929 (Aug 2025) ships a ValidatorShare with
# `restakePOL()` and `buyVoucherPOL(uint256,uint256)` as separate functions.
# sPOL's `sPOLController._buySharesFromValidator` calls the fused
# `restakeAndStakePOL(uint256)` (selector 0x75cbee12) — landed on
# pos-contracts/main in 24a81a5fe9 (Oct 2025) and deployed to Ethereum
# mainnet on 2026-02-27 (impl 0xBe63B977ABBAA99fC0243e208340c530Dd4ee9E8,
# Registry update tx 0x77953b264dfa64e70603d868b9cb171bbfdd36960564093b18f9c02154ebe053).
# Without this upgrade, every `buySPOL` call on the devnet reverts with
# empty data deep inside the validator delegation chain.
#
# # How mainnet handled it
#
# Polygon ValidatorShare proxies don't store an `implementation` slot — they
# read `Registry.contractMap[keccak256("validatorShare")]` on every call.
# A single `Registry.updateContractMap('validatorShare', <newImpl>)` call
# (gated by Governance) flips the impl for every existing validator at once.
# Storage layout is forward-compatible: the new ValidatorShare keeps every
# existing variable in place and only appends EIP-712 storage.
#
# # What this script does
#
# 1. Deploy the new ValidatorShare bytecode (compiled from
#    /opt/pos-contracts-main at image-build time).
# 2. Call governance.update(registry, updateContractMap('validatorShare', newImpl))
#    using the kurtosis admin private key — same path migrate-matic-to-pol-token.sh
#    uses for its registry mutations.

CONTRACT_ADDRESSES_FILE="/opt/contracts/contractAddresses.json"

for v in PRIVATE_KEY L1_RPC_URL; do
	if [[ -z "${!v:-}" ]]; then
		echo "Error: ${v} is not set"
		exit 1
	fi
done

cd /opt/pos-contracts-main

echo "Loading contract addresses..."
mkdir -p /opt/contracts
cp /opt/data/addresses/contractAddresses.json "${CONTRACT_ADDRESSES_FILE}"
registry_proxy_address=$(jq -r '.root.Registry' "${CONTRACT_ADDRESSES_FILE}")
governance_proxy_address=$(jq -r '.root.GovernanceProxy' "${CONTRACT_ADDRESSES_FILE}")

if [[ -z "${registry_proxy_address}" || "${registry_proxy_address}" == "null" ]]; then
	echo "Error: Registry address missing from ${CONTRACT_ADDRESSES_FILE}"
	exit 1
fi
if [[ -z "${governance_proxy_address}" || "${governance_proxy_address}" == "null" ]]; then
	echo "Error: GovernanceProxy address missing from ${CONTRACT_ADDRESSES_FILE}"
	exit 1
fi

echo "Deploying upgraded ValidatorShare implementation..."
# Deploy from the pre-built artifact — the runtime stage only carries `out/`,
# not the source tree. `cast send --create <bytecode>` is the simplest way to
# deploy raw bytecode without needing the .sol file path.
artifact="/opt/pos-contracts-main/out/ValidatorShare.sol/ValidatorShare.json"
if [[ ! -f "${artifact}" ]]; then
	echo "Error: ValidatorShare artifact missing at ${artifact}"
	exit 1
fi
bytecode=$(jq -r '.bytecode.object' "${artifact}")
if [[ -z "${bytecode}" || "${bytecode}" == "null" ]]; then
	echo "Error: failed to read ValidatorShare bytecode from ${artifact}"
	exit 1
fi
new_validator_share=$(cast send \
	--rpc-url "${L1_RPC_URL}" \
	--private-key "${PRIVATE_KEY}" \
	--legacy \
	--create "${bytecode}" \
	--json |
	jq -r '.contractAddress')

if [[ -z "${new_validator_share}" || "${new_validator_share}" == "null" ]]; then
	echo "Error: failed to parse deployed ValidatorShare address."
	exit 1
fi
echo "New ValidatorShare implementation: ${new_validator_share}"

# Flip Registry.contractMap['validatorShare'] -> new impl. Mirrors the mainnet
# upgrade tx (0x77953b264d...): one call, every ValidatorShare proxy on the
# chain immediately uses the new bytecode on its next request.
echo "Pointing Registry.validatorShare -> ${new_validator_share}..."
key_hash=$(cast keccak "validatorShare")
calldata=$(cast calldata "updateContractMap(bytes32,address)" "${key_hash}" "${new_validator_share}")
cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" \
	"${governance_proxy_address}" "update(address,bytes)" "${registry_proxy_address}" "${calldata}"

# Persist the new impl address in the merged artifact for traceability.
jq --arg vs "${new_validator_share}" \
	'.root.ValidatorShareImpl = $vs' \
	"${CONTRACT_ADDRESSES_FILE}" > "${CONTRACT_ADDRESSES_FILE}.tmp"
mv "${CONTRACT_ADDRESSES_FILE}.tmp" "${CONTRACT_ADDRESSES_FILE}"

echo "ValidatorShare upgrade complete. Updated contractAddresses.json:"
cat "${CONTRACT_ADDRESSES_FILE}"
