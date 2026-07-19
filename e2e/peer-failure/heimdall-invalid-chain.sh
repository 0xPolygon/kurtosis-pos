#!/usr/bin/env bash

set -euo pipefail
cd "$(dirname "$0")"
# shellcheck source=lib.sh
source ./lib.sh

TARGET_BOR="${TARGET_BOR:-$BOR_RPC_0}"
TARGET_HEIMDALL="${TARGET_HEIMDALL:-$HEIMDALL_RPC_0}"
PEER_BOR="${PEER_BOR:-$BOR_VALIDATOR_0}"
LAG_BLOCKS="${LAG_BLOCKS:-64}"
OUTAGE_WINDOW_S="${OUTAGE_WINDOW_S:-240}"

_peer_reached() { [ "$(block_number "$PEER_BOR")" -ge "$1" ]; }
_span_failing() { svc_logs "$TARGET_BOR" 2>/dev/null | grep -qE "Unable to fetch span|waiting for new span|context deadline exceeded"; }

restored=0
restore() {
  [ "$restored" = 1 ] && return 0
  restored=1
  warn "restoring devnet: starting $TARGET_HEIMDALL and $TARGET_BOR"
  svc_start "$TARGET_HEIMDALL" || true
  svc_start "$TARGET_BOR" || true
}
trap restore EXIT

main() {
  info "=== Heimdall-outage invalid-chain differential test ==="
  info "target bor=$TARGET_BOR  target heimdall=$TARGET_HEIMDALL  healthy peer=$PEER_BOR"

  local head0; head0="$(block_number "$PEER_BOR")"
  info "healthy peer head = $head0"

  local before_drops before_backoff
  before_drops="$(svc_logs "$TARGET_BOR" 2>/dev/null | grep -cE "$LOGSIG_INVALID_CHAIN_CTX" || true)"
  before_backoff="$(svc_logs "$TARGET_BOR" 2>/dev/null | grep -cE "$LOGSIG_CONSENSUS_BACKOFF" || true)"
  info "baseline: invalid-chain(ctx-deadline) drops=$before_drops  consensus-backoffs=$before_backoff"

  svc_stop "$TARGET_HEIMDALL"
  svc_stop "$TARGET_BOR"

  local want=$(( head0 + LAG_BLOCKS ))
  info "waiting for healthy peer to advance to >= $want so the target falls behind..."
  wait_until 300 _peer_reached "$want" \
    || { fail "healthy peer did not advance $LAG_BLOCKS blocks — is the devnet producing?"; return 1; }

  svc_start "$TARGET_BOR"
  info "target restarted with Heimdall DOWN; observing for ${OUTAGE_WINDOW_S}s..."

  if ! wait_until "$OUTAGE_WINDOW_S" _span_failing; then
    warn "did not observe span-fetch failures within the window; the outage may not have engaged the downloader"
  fi

  sleep 30

  local after_drops after_backoff new_drops new_backoff
  after_drops="$(svc_logs "$TARGET_BOR" 2>/dev/null | grep -cE "$LOGSIG_INVALID_CHAIN_CTX" || true)"
  after_backoff="$(svc_logs "$TARGET_BOR" 2>/dev/null | grep -cE "$LOGSIG_CONSENSUS_BACKOFF" || true)"
  new_drops=$(( after_drops - before_drops ))
  new_backoff=$(( after_backoff - before_backoff ))
  local metric; metric="$(metric_value "$TARGET_BOR" eth_downloader_peer_response_consensus_unavailable 2>/dev/null || echo 0)"

  info "observed: new invalid-chain(ctx-deadline) drops=$new_drops  new consensus-backoffs=$new_backoff  consensus_unavailable_metric=$metric"

  local rc=0

  if [ "$new_drops" -eq 0 ]; then
    pass "no honest peer was dropped as invalid-chain during the Heimdall outage"
  else
    warn "FAIL  target dropped an honest peer $new_drops time(s) as 'invalid chain: context deadline exceeded'"
    warn "      this is the bug — a local Heimdall outage must not be blamed on the peer"
    rc=1
  fi

  if [ "$new_backoff" -gt 0 ] || awk "BEGIN{exit !($metric>0)}"; then
    pass "fixed behaviour present: consensus-data backoff (log x$new_backoff, metric=$metric)"
  else
    warn "no consensus-data backoff signal seen (expected on a pre-fix build)"
  fi

  if [ "$rc" -eq 0 ]; then
    info "=== RESULT: PASS (peer preserved during Heimdall outage) ==="
  else
    info "=== RESULT: FAIL (peer dropped — invalid-chain bug present) ==="
  fi
  return "$rc"
}

main "$@"
