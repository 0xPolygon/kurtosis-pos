#!/usr/bin/env bash

set -euo pipefail
cd "$(dirname "$0")"
# shellcheck source=lib.sh
source ./lib.sh

LAG_BLOCKS="${LAG_BLOCKS:-64}"
OUTAGE_WINDOW_S="${OUTAGE_WINDOW_S:-240}"

# Resolve services from the live enclave (tolerates -archive suffixes and validator-only
# or validator+rpc topologies). Prefer an RPC node as the target (disrupting it does not
# affect consensus); fall back to a validator. Explicit env vars win.
TARGET_BOR="${TARGET_BOR:-$(find_service '^l2-el-[0-9]+-bor-.*rpc')}"
[ -n "$TARGET_BOR" ] || TARGET_BOR="$(find_service '^l2-el-[0-9]+-bor-.*validator')"
TARGET_HEIMDALL="${TARGET_HEIMDALL:-$(heimdall_for "$TARGET_BOR")}"
PEER_BOR="${PEER_BOR:-$(other_validator "$TARGET_BOR")}"
[ -n "$PEER_BOR" ] || PEER_BOR="$(find_service '^l2-el-[0-9]+-bor-.*validator')"

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

  if [ -z "$TARGET_BOR" ] || [ -z "$TARGET_HEIMDALL" ] || [ -z "$PEER_BOR" ] || [ "$PEER_BOR" = "$TARGET_BOR" ]; then
    warn "could not resolve services from enclave '$ENCLAVE'"
    dump_enclave
    fail "resolve target/heimdall/peer (target=$TARGET_BOR heimdall=$TARGET_HEIMDALL peer=$PEER_BOR)"
    return 1
  fi

  local head0; head0="$(block_number "$PEER_BOR")"
  info "healthy peer head = $head0"

  local before_drops before_backoff before_spanfail
  before_drops="$(svc_logs "$TARGET_BOR" 2>/dev/null | grep -cE "$LOGSIG_INVALID_CHAIN_CTX" || true)"
  before_backoff="$(svc_logs "$TARGET_BOR" 2>/dev/null | grep -cE "$LOGSIG_CONSENSUS_BACKOFF" || true)"
  before_spanfail="$(svc_logs "$TARGET_BOR" 2>/dev/null | grep -cE "$LOGSIG_SPAN_FETCH_FAIL" || true)"
  info "baseline: invalid-chain(ctx-deadline) drops=$before_drops  consensus-backoffs=$before_backoff  span-fetch-fails=$before_spanfail"

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

  local after_drops after_backoff after_spanfail new_drops new_backoff new_spanfail
  after_drops="$(svc_logs "$TARGET_BOR" 2>/dev/null | grep -cE "$LOGSIG_INVALID_CHAIN_CTX" || true)"
  after_backoff="$(svc_logs "$TARGET_BOR" 2>/dev/null | grep -cE "$LOGSIG_CONSENSUS_BACKOFF" || true)"
  after_spanfail="$(svc_logs "$TARGET_BOR" 2>/dev/null | grep -cE "$LOGSIG_SPAN_FETCH_FAIL" || true)"
  new_drops=$(( after_drops - before_drops ))
  new_backoff=$(( after_backoff - before_backoff ))
  new_spanfail=$(( after_spanfail - before_spanfail ))
  local metric; metric="$(metric_value "$TARGET_BOR" eth_downloader_peer_response_consensus_unavailable 2>/dev/null || echo 0)"

  info "observed: span-fetch-fails=$new_spanfail  invalid-chain drops=$new_drops  consensus-backoffs=$new_backoff  metric=$metric"

  # The differential is only meaningful if the bug PRECONDITION was reached — i.e. the
  # target actually failed to fetch a span from its (down) Heimdall. Without that, buggy
  # and fixed bor are indistinguishable, so the result is INCONCLUSIVE (never a false PASS).
  if [ "$new_drops" -gt 0 ]; then
    warn "target dropped an honest peer $new_drops time(s) as invalid-chain during a Heimdall span-fetch failure"
    warn "this is the bug: a local Heimdall failure must not be blamed on the peer"
    info "=== RESULT: FAIL (bug reproduced — honest peer dropped) ==="
    return 1
  elif [ "$new_backoff" -gt 0 ] || awk "BEGIN{exit !($metric>0)}"; then
    pass "Heimdall span-fetch failure produced a consensus-data backoff; peer preserved"
    info "=== RESULT: PASS (fix verified) ==="
    return 0
  elif [ "$new_spanfail" -gt 0 ]; then
    warn "span-fetch failures occurred but neither a drop nor a backoff followed — investigate"
    info "=== RESULT: INCONCLUSIVE ==="
    return 2
  else
    warn "the target never hit a Heimdall span-fetch failure, so the bug condition was not exercised."
    warn "during healthy sync bor obtains spans from on-chain data; this bug needs a verifying node"
    warn "to require a span its Heimdall cannot serve (VeBlop performSpanCheck under a struggling"
    warn "producer). The bor unit tests (eth/downloader/peer_response_test.go) are the reliable gate."
    info "=== RESULT: INCONCLUSIVE (span-fetch path not exercised) ==="
    return 2
  fi
}

main "$@"
