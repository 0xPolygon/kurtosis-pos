#!/usr/bin/env bash
# Steady background workload: 5 tx/s of counter() calls via nginx, so the
# sequence store has entries to carry and tx-inclusion liveness is observable.
# Restarts polycli if it exits (e.g. nginx moved or a batch of sends failed).
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
source "$CAMPAIGN_DIR/../bootstrap.env"
out="$CAMPAIGN_DIR/probes/loadtest.log"
while true; do
  refresh_nodes
  np=$(port nginx 8545)
  echo "$(date -u +%FT%TZ) starting polycli loadtest via nginx :$np" >> "$out"
  polycli loadtest --rpc-url "http://127.0.0.1:$np" --private-key "$PRIVATE_KEY" \
    --mode cc --contract-address "$counter_address" --calldata 0x \
    --rate-limit 5 --requests 1000000000 --concurrency 1 \
    --gas-price 30gwei --priority-gas-price 30gwei --pretty-logs=false 2>&1 \
    | jq -rc --unbuffered 'select(.level!="trace" and .level!="debug") | "\(.time) \(.level) \(.message) \(.txhash // "") \(.error // "")"' >> "$out"
  echo "$(date -u +%FT%TZ) polycli exited, restarting in 5s" >> "$out"; sleep 5
done
