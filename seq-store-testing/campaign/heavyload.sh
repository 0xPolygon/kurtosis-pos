#!/usr/bin/env bash
# Fire-and-forget load to grow the store: polycli send-only counter calls via
# nginx at <rate> tx/s for <minutes>. No receipts, so it does not compete with
# the preconf oracle's account set beyond nonce use (both use private-keys.txt;
# run the oracle on a disjoint account range if both run at once).
#   usage: heavyload.sh <rate> <minutes> [accounts-file]
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"; source "$CAMPAIGN_DIR/../bootstrap.env"
rate="${1:-400}"; mins="${2:-25}"; keys="${3:-$CAMPAIGN_DIR/../private-keys.txt}"
# HEAVY_CALLDATA_BYTES>0 sends that many random bytes of calldata per tx (grows store bytes fast)
cd=0x; gl=50000; if (( ${HEAVY_CALLDATA_BYTES:-0} > 0 )); then cd=0x$(head -c "$HEAVY_CALLDATA_BYTES" /dev/urandom | xxd -p | tr -d "\n"); gl=$(( 40000 + HEAVY_CALLDATA_BYTES * 45 )); fi
refresh_nodes; np=$(port nginx 8545)
echo "$(date -u +%FT%TZ) heavyload start rate=$rate mins=$mins calldata_bytes=${HEAVY_CALLDATA_BYTES:-0} gas=$gl via nginx:$np" >> "$CAMPAIGN_DIR/probes/heavyload.log"
timeout "$((mins*60))" polycli loadtest --rpc-url "http://127.0.0.1:$np" --send-only --mode cc \
  --rate-limit "$rate" --concurrency 200 --requests $((rate*mins*60)) \
  --contract-address "$counter_address" --calldata "$cd" --gas-limit "$gl" \
  --gas-price 30gwei --priority-gas-price 30gwei --sending-accounts-file "$keys" \
  --pretty-logs=false 2>&1 | jq -rRc 'fromjson? | select(.level=="error" or .level=="warn" or .message=="Finished") | "\(.time) \(.level) \(.message) \(.error // "")"' >> "$CAMPAIGN_DIR/probes/heavyload.log"
echo "$(date -u +%FT%TZ) heavyload end" >> "$CAMPAIGN_DIR/probes/heavyload.log"
