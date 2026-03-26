#!/usr/bin/env bash
set -euo pipefail

RPC_URL="${1:?Usage: $0 <rpc_url> [n_blocks]}"
N="${2:-10}"
CONTRACT="0x0000F90827F1C53a10cb7A02335B175320002935"

latest=$(cast block-number --rpc-url "$RPC_URL")
start=$((latest - N))
if [ "$start" -lt 1 ]; then
  start=1
fi

pass=0
fail=0

for block in $(seq "$start" "$((latest - 1))"); do
  padded=$(printf "0x%064x" "$block")
  contract_hash=$(cast call "$CONTRACT" "$padded" --rpc-url "$RPC_URL")
  node_hash=$(cast block "$block" --field hash --rpc-url "$RPC_URL")

  if [ "$contract_hash" = "$node_hash" ]; then
    echo "Block $block: OK"
    pass=$((pass + 1))
  else
    echo "Block $block: MISMATCH"
    echo "  contract: $contract_hash"
    echo "  node:     $node_hash"
    fail=$((fail + 1))
  fi
done

echo ""
echo "Results: $pass passed, $fail failed (checked blocks $start to $((latest - 1)))"
