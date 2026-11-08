#!/usr/bin/env bash
set -euxo pipefail

# Build L2 EL genesis file.
# For reference: https://github.com/0xPolygon/genesis-contracts

EL_GENESIS_ALLOC_FILE="/opt/genesis-contracts/genesis.json"
EL_GENESIS_FILE="/opt/data/genesis/genesis.json"

# Checking environment variables. Chain ids are baked into the image at build time
# (via EL_CHAIN_ID / CL_CHAIN_ID ENVs in the Dockerfile) and injected back into this
# script's environment by the container; custom values are not supported.
for v in EL_CHAIN_ID CL_CHAIN_ID ADMIN_ADDRESS ADMIN_BALANCE_WEI UBURU_FORK_BLOCK; do
  if [[ -z "${!v:-}" ]]; then
    echo "Error: ${v} environment variable is not set"
    exit 1
  fi
done
echo "EL_CHAIN_ID: ${EL_CHAIN_ID}"
echo "CL_CHAIN_ID: ${CL_CHAIN_ID}"
echo "ADMIN_ADDRESS: ${ADMIN_ADDRESS}"
echo "ADMIN_BALANCE_WEI: ${ADMIN_BALANCE_WEI}"

# Generate the EL genesis alloc field (validator set + genesis contracts are
# pre-built in the image against the baked chain ids).
echo "Generating the genesis file..."
cp /opt/data/validator/validators.js validators.js
node generate-genesis.js --bor-chain-id "${EL_CHAIN_ID}" --heimdall-chain-id "${CL_CHAIN_ID}"
if [[ -s "${EL_GENESIS_ALLOC_FILE}" ]]; then
  echo "EL genesis alloc field generated."
else
  echo "Error: ${EL_GENESIS_ALLOC_FILE} does not exist or is empty."
fi

# Append the admin address to the alloc field.
admin_address=$(echo "${ADMIN_ADDRESS}" | sed 's/^0x//')
jq --arg a "${admin_address}" --arg b "${ADMIN_BALANCE_WEI}" \
  '.alloc[$a] = {"balance": $b}' "${EL_GENESIS_ALLOC_FILE}" > tmp.json
mv tmp.json "${EL_GENESIS_ALLOC_FILE}"

# Add the EIP-2935 block hash history contract to the alloc field.
eip2935_address="0000F90827F1C53a10cb7A02335B175320002935"
eip2935_code="0x3373fffffffffffffffffffffffffffffffffffffffe14604657602036036042575f35600143038111604257611fff81430311604257611fff9006545f5260205ff35b5f5ffd5b5f35611fff60014303065500"
jq --arg a "${eip2935_address}" --arg c "${eip2935_code}" \
  '.alloc[$a] = {"balance": "0x0", "code": $c}' "${EL_GENESIS_ALLOC_FILE}" > tmp.json
mv tmp.json "${EL_GENESIS_ALLOC_FILE}"

# Add the canonical EIP-2470 / arachnid CREATE2 deployer to the alloc field.
# Forge's `new X{salt: y}` compiles to a CALL into this address; Bor genesis
# does not pre-deploy it, so without this entry CREATE2 broadcasts silently
# no-op (the script still computes predicted addresses in simulation, but no
# code ever lands on chain). The standard EIP-2470 bootstrap — fund the
# one-shot signer and broadcast the pre-signed legacy tx — cannot rescue
# this at runtime because the genesis sets `eip155Block: 0`, which rejects
# legacy txs without chain-id replay protection. Pre-allocating the runtime
# bytecode at genesis matches what Anvil does by default.
create2_address="4e59b44847b379578588920ca78fbf26c0b4956c"
create2_code="0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe03601600081602082378035828234f58015156039578182fd5b8082525050506014600cf3"
jq --arg a "${create2_address}" --arg c "${create2_code}" \
  '.alloc[$a] = {"balance": "0x0", "code": $c}' "${EL_GENESIS_ALLOC_FILE}" > tmp.json
mv tmp.json "${EL_GENESIS_ALLOC_FILE}"

# Add the state-sync gas oracle read by the Uburu StateReceiver, with its mainnet
# code and storage, at the addresses hardcoded in that StateReceiver. The mainnet
# owners (oracle owner, ProxyAdmin owner) are replaced by the admin address so the
# admin can call setGasLimit and upgrade the oracle on a devnet. The per-record gas
# limit is left at mainnet's 160000.
oracle_owner_slot="0x9016d09d72d40fdae2fd8ceac6b6234c7706214fd39c1cd1e609a0528c199300"
proxy_admin_owner_slot="0x0000000000000000000000000000000000000000000000000000000000000000"
admin_slot_value=$(printf "0x%064s" "${admin_address,,}" | tr ' ' '0')
jq --arg v "${admin_slot_value}" --arg os "${oracle_owner_slot}" --arg ps "${proxy_admin_owner_slot}" \
  '. | .["5e3a5eafd4501332c0bc2acfd38df3ebc5152147"].storage[$os] = $v
     | .["d0e888f8ccb701f5ed8db86495294ee2fd257765"].storage[$ps] = $v' \
  /opt/data/uburu/gas-oracle-alloc.json > oracle-alloc.json
jq --slurpfile o oracle-alloc.json '.alloc += $o[0]' \
  "${EL_GENESIS_ALLOC_FILE}" > tmp.json
mv tmp.json "${EL_GENESIS_ALLOC_FILE}"

# Add the alloc field to the temporary EL genesis to create the final EL genesis.
jq --arg key 'alloc' '. + {($key): input | .[$key]}' \
  "${EL_GENESIS_FILE}" "${EL_GENESIS_ALLOC_FILE}" > tmp.json
mv tmp.json "${EL_GENESIS_FILE}"

# Swap the StateReceiver code at the Uburu fork block, as bor's mainnet genesis does.
state_receiver_address="0000000000000000000000000000000000001001"
# The mainnet root setter is an immutable in its bytecode; replace it with the admin
# address so the admin can call setRootAndLeafCount and replayFailedStateSync.
mainnet_root_setter="eb1cd9e44ab6bfe5a55ee96c468086e51b1b873a"
state_receiver_hex=$(tr -d '\n' < /opt/data/uburu/state-receiver.hex)
grep -qi "${mainnet_root_setter}" <<< "${state_receiver_hex}" || {
  echo "Mainnet root setter not found in state-receiver.hex" >&2
  exit 1
}
state_receiver_code=$(sed "s/${mainnet_root_setter}/${admin_address,,}/Ig" <<< "${state_receiver_hex}")
jq --arg b "${UBURU_FORK_BLOCK}" --arg a "${state_receiver_address}" \
  --arg c "${state_receiver_code}" \
  '.config.bor.blockAlloc[$b][$a] = {"balance": "0x0", "code": $c}' \
  "${EL_GENESIS_FILE}" > tmp.json
mv tmp.json "${EL_GENESIS_FILE}"

# Add the genesis timestamp to the EL genesis.
timestamp=$(printf "0x%x" "$(date +%s)")
jq --arg t "${timestamp}" '.timestamp = $t' "${EL_GENESIS_FILE}" > tmp.json
mv tmp.json "${EL_GENESIS_FILE}"

# Verify and output the EL genesis file.
if [[ -s "${EL_GENESIS_FILE}" ]]; then
  echo "L2 EL genesis:"
  cat "${EL_GENESIS_FILE}"
else
  echo "Error: ${EL_GENESIS_FILE} does not exist or is empty."
fi
