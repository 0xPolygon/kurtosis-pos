#!/usr/bin/env bash
set -euo pipefail

# One-time bootstrap for the reserved-blockspace registry deployed in genesis
# at REGISTRY_ADDR. The registry has no constructor (its runtime bytecode is
# embedded directly, like the validator set and state receiver), so it starts
# with empty storage: no owner, no clients, zero capacity. Until this script
# (or something equivalent) runs, the ReservedBlockspace fork is active but
# dormant — headers carry ReservedCapacity=0 and no sender is classified
# reserved. This mirrors the bootstrap spec'd for bor's own reserved-blockspace
# integration tests (POS-3669/70/71).
#
# Idempotent: safe to re-run against an already-initialized registry, and
# verifies the existing state matches intent rather than treating any prior
# initialization as success — a mismatch fails loudly instead of silently
# leaving the registry in an unexpected state.

for v in PRIVATE_KEY L2_RPC_URL ADMIN_ADDRESS REGISTRY_ADDR CLIENT_ADDR CLIENT_QUOTA_GAS; do
  if [[ -z "${!v:-}" ]]; then
    echo "Error: ${v} is not set"
    exit 1
  fi
done

MAX_TOTAL_GAS="${MAX_TOTAL_GAS:-40000000}"
MAX_CLIENT_GAS="${MAX_CLIENT_GAS:-30000000}"
CLIENT_METADATA="${CLIENT_METADATA:-kurtosis-devnet-client-1}"

cast_call() {
  cast call "${REGISTRY_ADDR}" "$@" --rpc-url "${L2_RPC_URL}"
}

cast_send() {
  cast send "${REGISTRY_ADDR}" "$@" --private-key "${PRIVATE_KEY}" --rpc-url "${L2_RPC_URL}" --legacy
}

echo "Reading current registry state at ${REGISTRY_ADDR}..."
current_owner="$(cast_call 'owner()(address)')"
current_max_total="$(cast_call 'maxTotalReservedGas()(uint64)')"
current_max_client="$(cast_call 'maxClientReservedGas()(uint64)')"

if [[ "${current_owner}" == "0x0000000000000000000000000000000000000000" ]]; then
  echo "Registry not initialized. Calling initialize(${ADMIN_ADDRESS}, ${MAX_TOTAL_GAS}, ${MAX_CLIENT_GAS})..."
  cast_send 'initialize(address,uint64,uint64)' "${ADMIN_ADDRESS}" "${MAX_TOTAL_GAS}" "${MAX_CLIENT_GAS}"
elif [[ "${current_owner,,}" == "${ADMIN_ADDRESS,,}" && "${current_max_total}" == "${MAX_TOTAL_GAS}" && "${current_max_client}" == "${MAX_CLIENT_GAS}" ]]; then
  echo "Registry already initialized with matching owner and limits. Skipping initialize()."
else
  echo "Error: registry already initialized with unexpected state (owner=${current_owner}, maxTotal=${current_max_total}, maxClient=${current_max_client})"
  exit 1
fi

echo "Reading client state for ${CLIENT_ADDR}..."
client_info="$(cast_call 'getClientForAddress(address)(uint256,uint64,address,bool,uint8,uint64)' "${CLIENT_ADDR}")"
existing_client_id="$(echo "${client_info}" | sed -n '1p')"

if [[ "${existing_client_id}" == "0" ]]; then
  echo "Address not registered. Calling createClient(admin=${ADMIN_ADDRESS}, quota=${CLIENT_QUOTA_GAS}, feeMode=0, effectiveFrom=0)..."
  cast_send 'createClient(address,uint64,uint8,uint64,string,address[])' \
    "${ADMIN_ADDRESS}" "${CLIENT_QUOTA_GAS}" 0 0 "${CLIENT_METADATA}" "[${CLIENT_ADDR}]"
else
  existing_quota="$(echo "${client_info}" | sed -n '2p')"
  existing_active="$(echo "${client_info}" | sed -n '4p')"
  existing_fee_mode="$(echo "${client_info}" | sed -n '5p')"
  if [[ "${existing_quota}" == "${CLIENT_QUOTA_GAS}" && "${existing_active}" == "true" && "${existing_fee_mode}" == "0" ]]; then
    echo "Client already registered (id=${existing_client_id}) with matching quota/active/feeMode. Skipping createClient()."
  else
    echo "Error: ${CLIENT_ADDR} already registered (id=${existing_client_id}) with unexpected state (quota=${existing_quota}, active=${existing_active}, feeMode=${existing_fee_mode})"
    exit 1
  fi
fi

echo "Reserved-blockspace registry bootstrap complete."
echo "totalReservedGas: $(cast_call 'totalReservedGas()(uint64)')"
