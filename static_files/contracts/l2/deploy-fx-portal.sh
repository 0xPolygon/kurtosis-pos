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

# deploy <rpc> <contract> [constructor-sig args...]
deploy() {
  local rpc="$1" contract="$2"
  shift 2
  local bytecode
  bytecode=$(jq -r '.bytecode.object' "out/${contract}.sol/${contract}.json")
  cast send --rpc-url "${rpc}" --private-key "${PRIVATE_KEY}" --legacy --json \
    --create "${bytecode}" "$@" | jq -re '.contractAddress'
}

send() {
  local rpc="$1"
  shift
  cast send --rpc-url "${rpc}" --private-key "${PRIVATE_KEY}" --legacy "$@" > /dev/null
}

checkpoint_manager=$(jq -re '.root.RootChainProxy' contractAddresses.json)
state_sender=$(jq -re '.root.StateSender' contractAddresses.json)

echo "Deploying FxChild and token templates on L2..."
fx_child=$(deploy "${L2_RPC_URL}" FxChild)
erc20_template=$(deploy "${L2_RPC_URL}" FxERC20)
erc721_template=$(deploy "${L2_RPC_URL}" FxERC721)
erc1155_template=$(deploy "${L2_RPC_URL}" FxERC1155)

if [[ "${SKIP_L1_WIRING:-0}" == "1" ]]; then
  fx_root=$(jq -re '.root.fxPortal.FxRoot' contractAddresses.json)
  state_root_tunnel=$(jq -re '.root.fxPortal.FxStateRootTunnel' contractAddresses.json)
  erc20_root_tunnel=$(jq -re '.root.fxPortal.FxERC20RootTunnel' contractAddresses.json)
  erc721_root_tunnel=$(jq -re '.root.fxPortal.FxERC721RootTunnel' contractAddresses.json)
  erc1155_root_tunnel=$(jq -re '.root.fxPortal.FxERC1155RootTunnel' contractAddresses.json)
else
  echo "Deploying FxRoot and root tunnels on L1..."
  fx_root=$(deploy "${L1_RPC_URL}" FxRoot "constructor(address)" "${state_sender}")
  state_root_tunnel=$(deploy "${L1_RPC_URL}" FxStateRootTunnel \
    "constructor(address,address)" "${checkpoint_manager}" "${fx_root}")
  erc20_root_tunnel=$(deploy "${L1_RPC_URL}" FxERC20RootTunnel \
    "constructor(address,address,address)" "${checkpoint_manager}" "${fx_root}" "${erc20_template}")
  erc721_root_tunnel=$(deploy "${L1_RPC_URL}" FxERC721RootTunnel \
    "constructor(address,address,address)" "${checkpoint_manager}" "${fx_root}" "${erc721_template}")
  erc1155_root_tunnel=$(deploy "${L1_RPC_URL}" FxERC1155RootTunnel \
    "constructor(address,address,address)" "${checkpoint_manager}" "${fx_root}" "${erc1155_template}")
fi

echo "Deploying child tunnels on L2..."
state_child_tunnel=$(deploy "${L2_RPC_URL}" FxStateChildTunnel "constructor(address)" "${fx_child}")
erc20_child_tunnel=$(deploy "${L2_RPC_URL}" FxERC20ChildTunnel \
  "constructor(address,address)" "${fx_child}" "${erc20_template}")
erc721_child_tunnel=$(deploy "${L2_RPC_URL}" FxERC721ChildTunnel \
  "constructor(address,address)" "${fx_child}" "${erc721_template}")
erc1155_child_tunnel=$(deploy "${L2_RPC_URL}" FxERC1155ChildTunnel \
  "constructor(address,address)" "${fx_child}" "${erc1155_template}")

echo "Wiring L2..."
send "${L2_RPC_URL}" "${fx_child}" "setFxRoot(address)" "${fx_root}"
send "${L2_RPC_URL}" "${state_child_tunnel}" "setFxRootTunnel(address)" "${state_root_tunnel}"
send "${L2_RPC_URL}" "${erc20_child_tunnel}" "setFxRootTunnel(address)" "${erc20_root_tunnel}"
send "${L2_RPC_URL}" "${erc721_child_tunnel}" "setFxRootTunnel(address)" "${erc721_root_tunnel}"
send "${L2_RPC_URL}" "${erc1155_child_tunnel}" "setFxRootTunnel(address)" "${erc1155_root_tunnel}"

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
else
  echo "Wiring L1..."
  send "${L1_RPC_URL}" "${fx_root}" "setFxChild(address)" "${fx_child}"
  # StateSender.syncState only accepts registered (sender, receiver) pairs.
  send "${L1_RPC_URL}" "${state_sender}" "register(address,address)" "${fx_root}" "${fx_child}"
  send "${L1_RPC_URL}" "${state_root_tunnel}" "setFxChildTunnel(address)" "${state_child_tunnel}"
  send "${L1_RPC_URL}" "${erc20_root_tunnel}" "setFxChildTunnel(address)" "${erc20_child_tunnel}"
  send "${L1_RPC_URL}" "${erc721_root_tunnel}" "setFxChildTunnel(address)" "${erc721_child_tunnel}"
  send "${L1_RPC_URL}" "${erc1155_root_tunnel}" "setFxChildTunnel(address)" "${erc1155_child_tunnel}"
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
