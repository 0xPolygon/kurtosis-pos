#!/usr/bin/env bash
# Transaction-level preconfirmation oracle.
# Sends counter() calls through the RPC consumer node (el-9 by default) with
# --wait-for-receipt so polycli returns the FIRST receipt the node serves,
# which for a store consumer is the preconfirmation (blockHash null,
# "preconfirmation": true). Records one JSON line per tx:
#   {"t":"<utc>","tx":..,"dur":ms,"idx":<counter log topic>,"bn":<receipt blockNumber>,"bh":<blockHash or null>}
# into probes/preconfs-<label>.jsonl. Verify later with preconf-check.py.
#   usage: preconf-oracle.sh <label> [rate=20] [concurrency=20] [rpc-service=l2-el-9-bor-heimdall-v2-rpc]
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
source "$CAMPAIGN_DIR/../bootstrap.env"
label="${1:?label}"; rate="${2:-20}"; conc="${3:-20}"; svc="${4:-l2-el-9-bor-heimdall-v2-rpc}"
out="$CAMPAIGN_DIR/probes/preconfs-$label.jsonl"
while true; do
  refresh_nodes; p=$(port "$svc" 8545)
  [[ -z "$p" ]] && { echo "$(date -u +%FT%TZ) $svc down, retry" >> "$out.err"; sleep 5; continue; }
  polycli loadtest --rpc-url "http://127.0.0.1:$p" --send-only --mode cc \
    --rate-limit "$rate" --concurrency "$conc" --requests 100000000 \
    --wait-for-receipt --receipt-poll-interval 50ms --verbosity 700 \
    --contract-address "$counter_address" --calldata 0x --gas-limit 50000 \
    --gas-price 30gwei --priority-gas-price 30gwei \
    --sending-accounts-file "${ORACLE_KEYS:-$CAMPAIGN_DIR/../private-keys.txt}" --pretty-logs=false 2>&1 \
    | jq -rRc --unbuffered 'fromjson? | select(.txHash != null) | {t: .time, tx: .txHash, dur: .durationMs, idx: .receipt.logs[0].topics[0], bn: .receipt.blockNumber, bh: .receipt.blockHash, pre: .receipt.preconfirmation, st: .receipt.status, nl: (.receipt.logs|length)}' >> "$out"
  echo "$(date -u +%FT%TZ) polycli exited, restarting" >> "$out.err"; sleep 3
done
