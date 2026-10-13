#!/usr/bin/env bash
set -euxo pipefail

# Deploy the fx-portal bridge (FxRoot/FxChild + state, ERC20, ERC721 and ERC1155
# tunnels) on both chains and wire them together. Deploy order matters: the L1
# root tunnels derive child token addresses from the L2 token templates, and the
# L2 child tunnels need the L1 root tunnel addresses.

CONTRACT_ADDRESSES_FILE="/opt/contracts/contractAddresses.json"

for v in PRIVATE_KEY L1_RPC_URL L2_RPC_URL; do
  if [[ -z "${!v:-}" ]]; then
    echo "Error: ${v} is not set"
    exit 1
  fi
done

cd /opt/fx-portal
mkdir -p /opt/contracts
cp /opt/data/addresses/contractAddresses.json contractAddresses.json

# On the cl-el-genesis redeploy path the L1 side already exists: reuse it and only
# rebuild the L2 side, which lands at the same addresses via CREATE-nonce determinism.
if [[ "${SKIP_L1_WIRING:-0}" == "1" ]]; then
  if [[ "$(jq -r '.root.fxPortal.FxRoot // empty' contractAddresses.json)" == "" ]]; then
    echo "SKIP_L1_WIRING=1 and no .root.fxPortal in contractAddresses.json — skipping fx-portal."
    cp contractAddresses.json "${CONTRACT_ADDRESSES_FILE}"
    exit 0
  fi
fi

deployer=$(cast wallet address --private-key "${PRIVATE_KEY}")
declare -A rpc=([l1]="${L1_RPC_URL}" [l2]="${L2_RPC_URL}") nonce pending
for chain in l1 l2; do
  nonce[${chain}]=$(cast nonce --rpc-url "${rpc[${chain}]}" --block pending "${deployer}")
  pending[${chain}]=""
done

# Transactions are sent without waiting, with explicit nonces, then confirmed in
# one pass: a deployed address is a pure function of (deployer, nonce), so every
# address is known before anything is mined. Wiring calls target contracts that
# may not be mined yet, so gas estimation cannot be used for them (fixed gas limit).
send_async() {
  local chain="$1"
  shift
  local hash
  hash=$(cast send --rpc-url "${rpc[${chain}]}" --private-key "${PRIVATE_KEY}" --legacy \
    --async --nonce "${nonce[${chain}]}" "$@")
  pending[${chain}]+=" ${hash}"
  nonce[${chain}]=$((nonce[${chain}] + 1))
}

# deploy <l1|l2> <address-var> <contract> [constructor-sig args...]
deploy() {
  local chain="$1" var="$2" contract="$3"
  shift 3
  local bytecode address
  bytecode=$(jq -r '.bytecode.object' "out/${contract}.sol/${contract}.json")
  address=$(cast compute-address "${deployer}" --nonce "${nonce[${chain}]}" | awk '{print $NF}')
  send_async "${chain}" --create "${bytecode}" "$@"
  printf -v "${var}" '%s' "${address}"
}

wire() {
  local chain="$1"
  shift
  send_async "${chain}" --gas-limit 200000 "$@"
}

confirm() {
  local chain="$1" hash status
  for hash in ${pending[${chain}]}; do
    # A dropped tx would make cast receipt poll forever.
    if ! status=$(timeout 120 cast receipt --rpc-url "${rpc[${chain}]}" --json "${hash}" | jq -r '.status'); then
      echo "ERROR: no receipt for ${chain} transaction ${hash} after 120s" >&2
      exit 1
    fi
    if [[ "${status}" != "0x1" && "${status}" != "1" ]]; then
      echo "ERROR: ${chain} transaction ${hash} failed (status ${status})" >&2
      exit 1
    fi
  done
  pending[${chain}]=""
}

checkpoint_manager=$(jq -re '.root.RootChainProxy' contractAddresses.json)
state_sender=$(jq -re '.root.StateSender' contractAddresses.json)

echo "Sending FxChild and token templates on L2..."
deploy l2 fx_child FxChild
deploy l2 erc20_template FxERC20
deploy l2 erc721_template FxERC721
deploy l2 erc1155_template FxERC1155

if [[ "${SKIP_L1_WIRING:-0}" == "1" ]]; then
  fx_root=$(jq -re '.root.fxPortal.FxRoot' contractAddresses.json)
  state_root_tunnel=$(jq -re '.root.fxPortal.FxStateRootTunnel' contractAddresses.json)
  erc20_root_tunnel=$(jq -re '.root.fxPortal.FxERC20RootTunnel' contractAddresses.json)
  erc721_root_tunnel=$(jq -re '.root.fxPortal.FxERC721RootTunnel' contractAddresses.json)
  erc1155_root_tunnel=$(jq -re '.root.fxPortal.FxERC1155RootTunnel' contractAddresses.json)
else
  echo "Sending FxRoot and root tunnels on L1..."
  deploy l1 fx_root FxRoot "constructor(address)" "${state_sender}"
  deploy l1 state_root_tunnel FxStateRootTunnel \
    "constructor(address,address)" "${checkpoint_manager}" "${fx_root}"
  deploy l1 erc20_root_tunnel FxERC20RootTunnel \
    "constructor(address,address,address)" "${checkpoint_manager}" "${fx_root}" "${erc20_template}"
  deploy l1 erc721_root_tunnel FxERC721RootTunnel \
    "constructor(address,address,address)" "${checkpoint_manager}" "${fx_root}" "${erc721_template}"
  deploy l1 erc1155_root_tunnel FxERC1155RootTunnel \
    "constructor(address,address,address)" "${checkpoint_manager}" "${fx_root}" "${erc1155_template}"
fi

# The child tunnel constructors require the token template to already hold code,
# so their gas estimation reverts until the templates are mined.
echo "Waiting for the L2 token templates..."
confirm l2

echo "Sending child tunnels on L2..."
deploy l2 state_child_tunnel FxStateChildTunnel "constructor(address)" "${fx_child}"
deploy l2 erc20_child_tunnel FxERC20ChildTunnel \
  "constructor(address,address)" "${fx_child}" "${erc20_template}"
deploy l2 erc721_child_tunnel FxERC721ChildTunnel \
  "constructor(address,address)" "${fx_child}" "${erc721_template}"
deploy l2 erc1155_child_tunnel FxERC1155ChildTunnel \
  "constructor(address,address)" "${fx_child}" "${erc1155_template}"

if [[ "${SKIP_L1_WIRING:-0}" != "1" ]]; then
  echo "Wiring L1..."
  wire l1 "${fx_root}" "setFxChild(address)" "${fx_child}"
  # StateSender.syncState only accepts registered (sender, receiver) pairs.
  wire l1 "${state_sender}" "register(address,address)" "${fx_root}" "${fx_child}"
  wire l1 "${state_root_tunnel}" "setFxChildTunnel(address)" "${state_child_tunnel}"
  wire l1 "${erc20_root_tunnel}" "setFxChildTunnel(address)" "${erc20_child_tunnel}"
  wire l1 "${erc721_root_tunnel}" "setFxChildTunnel(address)" "${erc721_child_tunnel}"
  wire l1 "${erc1155_root_tunnel}" "setFxChildTunnel(address)" "${erc1155_child_tunnel}"
fi

echo "Wiring L2..."
wire l2 "${fx_child}" "setFxRoot(address)" "${fx_root}"
wire l2 "${state_child_tunnel}" "setFxRootTunnel(address)" "${state_root_tunnel}"
wire l2 "${erc20_child_tunnel}" "setFxRootTunnel(address)" "${erc20_root_tunnel}"
wire l2 "${erc721_child_tunnel}" "setFxRootTunnel(address)" "${erc721_root_tunnel}"
wire l2 "${erc1155_child_tunnel}" "setFxRootTunnel(address)" "${erc1155_root_tunnel}"

echo "Waiting for confirmations..."
confirm l2
confirm l1

if [[ "${SKIP_L1_WIRING:-0}" == "1" ]]; then
  # The L1 tunnels are pinned to the previous L2 addresses: fail loud on drift.
  for pair in \
    "${fx_root}:fxChild():${fx_child}" \
    "${state_root_tunnel}:fxChildTunnel():${state_child_tunnel}" \
    "${erc20_root_tunnel}:fxChildTunnel():${erc20_child_tunnel}" \
    "${erc721_root_tunnel}:fxChildTunnel():${erc721_child_tunnel}" \
    "${erc1155_root_tunnel}:fxChildTunnel():${erc1155_child_tunnel}"; do
    IFS=':' read -r target getter expected <<< "${pair}"
    current=$(cast call --rpc-url "${L1_RPC_URL}" "${target}" "${getter}(address)")
    if [[ "${current,,}" != "${expected,,}" ]]; then
      echo "ERROR: ${target}.${getter} is ${current} on L1 but L2 now has ${expected}." >&2
      exit 1
    fi
  done
fi

jq \
  --arg fxRoot "${fx_root}" \
  --arg stateRoot "${state_root_tunnel}" \
  --arg erc20Root "${erc20_root_tunnel}" \
  --arg erc721Root "${erc721_root_tunnel}" \
  --arg erc1155Root "${erc1155_root_tunnel}" \
  --arg fxChild "${fx_child}" \
  --arg erc20Template "${erc20_template}" \
  --arg erc721Template "${erc721_template}" \
  --arg erc1155Template "${erc1155_template}" \
  --arg stateChild "${state_child_tunnel}" \
  --arg erc20Child "${erc20_child_tunnel}" \
  --arg erc721Child "${erc721_child_tunnel}" \
  --arg erc1155Child "${erc1155_child_tunnel}" \
  '.root.fxPortal = {
     FxRoot: $fxRoot,
     FxStateRootTunnel: $stateRoot,
     FxERC20RootTunnel: $erc20Root,
     FxERC721RootTunnel: $erc721Root,
     FxERC1155RootTunnel: $erc1155Root
   }
   | .child.fxPortal = {
     FxChild: $fxChild,
     FxERC20Template: $erc20Template,
     FxERC721Template: $erc721Template,
     FxERC1155Template: $erc1155Template,
     FxStateChildTunnel: $stateChild,
     FxERC20ChildTunnel: $erc20Child,
     FxERC721ChildTunnel: $erc721Child,
     FxERC1155ChildTunnel: $erc1155Child
   }' contractAddresses.json > "${CONTRACT_ADDRESSES_FILE}"

echo "fx-portal deploy complete. Final contractAddresses.json:"
cat "${CONTRACT_ADDRESSES_FILE}"
