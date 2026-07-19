#!/usr/bin/env bash

set -euo pipefail
cd "$(dirname "$0")"
# shellcheck source=lib.sh
source ./lib.sh

TARGET_BOR="${TARGET_BOR:-$(find_service '^l2-el-[0-9]+-bor-.*rpc')}"
[ -n "$TARGET_BOR" ] || TARGET_BOR="$(find_service '^l2-el-[0-9]+-bor-.*validator')"
DURATION="${DURATION:-30s}"
BIN="./fake-peer/fake-peer"

ALL_SCENARIOS=(valid flood baddata stall emptyheaders badheaders disconnect)
LOGSIG_P2P_REMOVE='Removing p2p peer'

build_bin() {
  info "building fake-peer..."
  ( cd fake-peer && go build -o fake-peer . )
}

discover_target() {
  if [ -z "$TARGET_BOR" ]; then
    warn "no bor service resolved from enclave '$ENCLAVE'"
    dump_enclave
    fail "resolve a bor service to target"; return 1
  fi
  ENODE="$(enode "$TARGET_BOR")"
  [ -n "$ENODE" ] || { fail "could not scrape enode from $TARGET_BOR logs"; return 1; }
  DIAL="$(host_port "$TARGET_BOR" discovery)"
  [ -n "$DIAL" ] || { fail "could not resolve host-mapped p2p port for $TARGET_BOR"; return 1; }
  info "target enode=${ENODE%%@*}@... dial=$DIAL"
}

run_one() {
  local scn="$1" rc=0
  info "----- scenario: $scn -----"

  local head_before removes_before; head_before="$(block_number "$TARGET_BOR")"
  removes_before="$(svc_logs "$TARGET_BOR" 2>/dev/null | grep -cE "$LOGSIG_P2P_REMOVE" || true)"

  local obs
  obs="$("$BIN" -enode "$ENODE" -dial "$DIAL" -scenario "$scn" -duration "$DURATION" 2>&1)" || true
  echo "$obs" | sed 's/^/    fake-peer| /'

  sleep 5
  local head_after removes_after new_removes
  head_after="$(block_number "$TARGET_BOR")"
  removes_after="$(svc_logs "$TARGET_BOR" 2>/dev/null | grep -cE "$LOGSIG_P2P_REMOVE" || true)"
  new_removes=$(( removes_after - removes_before ))

  if [ "$head_after" -gt "$head_before" ]; then
    pass "$scn: target survived and advanced ($head_before -> $head_after)"
  else
    warn "$scn: target did NOT advance ($head_before -> $head_after) — possible stall/crash"
    rc=1
  fi

  case "$scn" in
    valid)
      if echo "$obs" | grep -qi "stayed connected"; then
        pass "valid: healthy peer was not penalised (control)"
      else
        warn "valid: control peer did not remain connected — possible false positive"
        rc=1
      fi ;;
    baddata)
      if echo "$obs" | grep -qiE "disconnected us|closed"; then
        pass "baddata: target rejected the malformed message (disconnected us)"
      else
        warn "baddata: target did not disconnect on a malformed message"
      fi ;;
    disconnect)
      info "disconnect: peer connected then dropped; node unaffected" ;;
    *)
      if [ "$new_removes" -gt 0 ] || echo "$obs" | grep -qiE "disconnected us|stopped accepting"; then
        info "$scn: target dropped/stopped-accepting the abuser (p2p removes=$new_removes)"
      else
        info "$scn: target tolerated the abuser without dropping (survived)"
      fi ;;
  esac

  local hint
  hint="$(svc_logs "$TARGET_BOR" 2>/dev/null \
      | grep -E "$LOGSIG_DROP|$LOGSIG_BACKOFF|stalling|empty header|bad peer|invalid" \
      | tail -n2 || true)"
  [ -n "$hint" ] && echo "$hint" | sed 's/^/    hint| /'

  return "$rc"
}

main() {
  build_bin
  discover_target

  local scenarios=("$@")
  [ "${#scenarios[@]}" -eq 0 ] && scenarios=("${ALL_SCENARIOS[@]}")

  local failed=0
  for s in "${scenarios[@]}"; do
    run_one "$s" || failed=1
  done

  if [ "$failed" -eq 0 ]; then
    info "=== RESULT: PASS (target survived and handled all scenarios) ==="
  else
    info "=== RESULT: FAIL (see WARN lines above) ==="
  fi
  return "$failed"
}

main "$@"
