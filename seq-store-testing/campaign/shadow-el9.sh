#!/usr/bin/env bash
# Shadow reader: tails a preconf jsonl produced by preconf-oracle.sh against
# some OTHER node (e.g. the in-turn producer) and, for each new tx hash, polls
# the consumer RPC (el-9) every 250 ms for up to 30 s, recording the FIRST
# receipt el-9 serves: {t, tx, seen_after_ms, pre, idx, bn, bh} or none.
# This is "what did a client of el-9 see for a tx that entered elsewhere".
#   usage: shadow-el9.sh <source jsonl> <label>
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
src="${1:?source}"; label="${2:?label}"; out="$CAMPAIGN_DIR/probes/shadow-$label.jsonl"
refresh_nodes; p9=$(port l2-el-9-bor-heimdall-v2-rpc 8545)
tail -n0 -F "$src" | while read -r line; do
  tx=$(jq -r '.tx // empty' <<<"$line"); [[ -z "$tx" ]] && continue
  (
    t0=$(date +%s%3N)
    for i in $(seq 1 120); do
      r=$(rpc_call "$p9" eth_getTransactionReceipt "[\"$tx\"]" | jq -c '.result // empty')
      if [[ -n "$r" ]]; then
        jq -c --arg t "$(date -u +%FT%TZ)" --arg tx "$tx" --argjson ms $(( $(date +%s%3N) - t0 )) '{t: $t, tx: $tx, seen_after_ms: $ms, pre: .preconfirmation, idx: .logs[0].topics[0], bn: .blockNumber, bh: .blockHash}' <<<"$r" >> "$out"; exit 0
      fi
      sleep 0.25
    done
    echo "{\"t\":\"$(date -u +%FT%TZ)\",\"tx\":\"$tx\",\"seen_after_ms\":null}" >> "$out"
  ) &
  # bound concurrency
  while (( $(jobs -rp | wc -l) > 200 )); do sleep 0.1; done
done
