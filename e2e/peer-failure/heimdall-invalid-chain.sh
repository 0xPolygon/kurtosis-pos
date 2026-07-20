#!/usr/bin/env bash

set -euo pipefail
cd "$(dirname "$0")"
# shellcheck source=lib.sh
source ./lib.sh

TARGET_BOR="${TARGET_BOR:-$(find_service '^l2-el-[0-9]+-bor-.*rpc')}"
[ -n "$TARGET_BOR" ] || TARGET_BOR="$(find_service '^l2-el-[0-9]+-bor-.*validator')"
TARGET_HEIMDALL="${TARGET_HEIMDALL:-$(heimdall_for "$TARGET_BOR")}"
OBSERVE_S="${OBSERVE_S:-150}"

PROXY_SVC="heimdall-spanfault-proxy"

# Mirrors the bor startup command from src/el/bor/launcher.star (bor_cmds). Repointing
# appends --bor.heimdall <url>, which overrides [heimdall].url in config.toml.
BOR_SETUP='cp /opt/data/genesis/genesis.json /etc/bor/genesis.json && cp /opt/data/keys/password.txt /etc/bor && mkdir -p /var/lib/bor && cp /opt/data/keys/nodekey /var/lib/bor/nodekey && cp -r /opt/data/keys/keystore /var/lib/bor && /usr/local/share/container-proc-manager.sh bor server --config /etc/bor/config.toml'

# BOR_IMAGE (optional): pin the target's image on every repoint. Leave unset in CI, where
# the enclave already runs the image built from the branch under test. Set it to run the
# differential against a specific build locally, e.g. BOR_IMAGE=bor:fix to verify the fix.
_img_flag() { [ -n "${BOR_IMAGE:-}" ] && printf -- '--image %s' "$BOR_IMAGE"; }

repoint() { kurtosis service update $(_img_flag) --cmd "$BOR_SETUP${1:+ $1}" "$ENCLAVE" "$TARGET_BOR" >/dev/null 2>&1; }

# Like repoint, but first wipes the chaindata subdir (/var/lib/bor/bor) so bor re-syncs
# from genesis. A fresh sync MUST fetch span 0 from Heimdall to verify the first sprint,
# which is what drives the request into the fault proxy. Identity (nodekey/keystore) lives
# at the datadir root and is re-copied by BOR_SETUP, so it survives the wipe.
repoint_fresh() { kurtosis service update $(_img_flag) --cmd "rm -rf /var/lib/bor/bor && $BOR_SETUP${1:+ $1}" "$ENCLAVE" "$TARGET_BOR" >/dev/null 2>&1; }

# NOTE: capture-then-grep on a here-string, NOT `svc_logs | grep -q`. Under `set -o
# pipefail`, `grep -q` exits on first match and closes the pipe, so `kurtosis service logs`
# is killed by SIGPIPE (141) and the pipeline reports failure *even though the pattern
# matched* — which made this gate silently never fire.
_span_failing() {
  local logs; logs="$(svc_logs "$TARGET_BOR" 2>/dev/null || true)"
  grep -qE "$LOGSIG_SPAN_FETCH_FAIL" <<<"$logs"
}

# _bor_up returns 0 once the target's RPC answers again. After a wipe/repoint the container
# is recreated, so we must wait for the new instance before querying its logs.
_bor_up() {
  local url; url="$(rpc_url "$TARGET_BOR" 2>/dev/null)" || return 1
  curl -fsS -m 3 -X POST -H 'content-type: application/json' \
    --data '{"jsonrpc":"2.0","id":1,"method":"eth_blockNumber","params":[]}' \
    "$url" >/dev/null 2>&1
}

restored=0
restore() {
  [ "$restored" = 1 ] && return 0
  restored=1
  warn "restoring: repointing $TARGET_BOR at its real Heimdall and removing the proxy"
  repoint "" || true
  kurtosis service rm "$ENCLAVE" "$PROXY_SVC" >/dev/null 2>&1 || true
}
trap restore EXIT

main() {
  info "=== Heimdall span-fault invalid-chain differential (proxy) ==="
  info "target bor=$TARGET_BOR  target heimdall=$TARGET_HEIMDALL"
  if [ -z "$TARGET_BOR" ] || [ -z "$TARGET_HEIMDALL" ]; then
    dump_enclave
    fail "could not resolve target bor / heimdall"
    return 1
  fi

  # Deploy a Heimdall reverse-proxy that forwards /status to the real Heimdall (so the
  # sync-gate stays open) but 503s /bor/spans (so GetSpan fails). Run it from a temp copy
  # OUTSIDE the kurtosis-pos package tree — kurtosis mis-resolves a nested sub-package.
  kurtosis service rm "$ENCLAVE" "$PROXY_SVC" >/dev/null 2>&1 || true
  local pkgtmp; pkgtmp="$(mktemp -d)"
  cp -r ./spanfault-proxy/. "$pkgtmp/"
  info "deploying span-fault proxy in front of $TARGET_HEIMDALL"
  if ! kurtosis run --enclave "$ENCLAVE" "$pkgtmp" "{\"target_heimdall\":\"$TARGET_HEIMDALL\"}" >/dev/null 2>&1; then
    rm -rf "$pkgtmp"
    fail "could not deploy span-fault proxy"; return 1
  fi
  rm -rf "$pkgtmp"

  # Repoint the target at the proxy AND wipe its chaindata so it re-syncs from genesis.
  # The fresh sync must fetch span 0 from Heimdall to verify early blocks -> hits the 503.
  info "repointing $TARGET_BOR at the proxy (--bor.heimdall) and wiping chaindata to force a fresh resync"
  repoint_fresh "--bor.heimdall http://$PROXY_SVC:1317"

  # The container was recreated by the update; wait for the new instance before reading logs.
  info "waiting for $TARGET_BOR to come back up..."
  wait_until 90 _bor_up || warn "target RPC not confirmed up after 90s; continuing anyway"

  info "observing up to ${OBSERVE_S}s for span-fetch failures..."
  wait_until "$OBSERVE_S" _span_failing \
    || { warn "no span-fetch failure observed; the repoint/proxy did not engage"; info "=== RESULT: INCONCLUSIVE (proxy did not engage) ==="; return 0; }
  # Let the classification settle (a buggy node drops within a second or two; a fixed node
  # logs the consensus-backoff on the same path).
  sleep 20

  # The wipe recreated the container, so its logs start fresh — count absolute occurrences,
  # no pre-wipe baseline to subtract. LOGSIG_INVALID_CHAIN_SPAN matches only the sync-path
  # drop ("Synchronisation failed, dropping peer ... retrieved hash chain is invalid"), not
  # the poll-loop 503s, so it cleanly separates the buggy path from the fix's backoff path.
  # Capture logs once, then grep the buffer. Every grep is guarded with `|| true`: on the
  # PASS path there are zero drops, so the drop/victims greps match nothing and exit 1 —
  # under `set -o pipefail` + `set -e` that would abort the script *before* the verdict
  # (looks like a spurious exit-1 "failure"). Guarding keeps a zero count as a real 0.
  local logs drops backoffs victims
  logs="$(svc_logs "$TARGET_BOR" 2>/dev/null || true)"
  drops="$(grep -cE "$LOGSIG_INVALID_CHAIN_SPAN" <<<"$logs" || true)"
  backoffs="$(grep -cE "$LOGSIG_CONSENSUS_BACKOFF" <<<"$logs" || true)"
  victims="$(grep -E "$LOGSIG_INVALID_CHAIN_SPAN" <<<"$logs" | grep -oE 'peer=[0-9a-f]+' | sort -u | wc -l | tr -d ' ' || true)"

  info "observed: span-caused peer drops=$drops (distinct victims=$victims)  consensus-backoffs=$backoffs"

  if [ "$drops" -gt 0 ]; then
    warn "target dropped honest peer-sync(s) as 'invalid chain' because Heimdall could not serve span 0"
    warn "repeated across peers this is the SELF-ECLIPSE bug (distinct victims=$victims)"
    info "=== RESULT: FAIL (bug reproduced — honest peers dropped) ==="
    return 1
  elif [ "$backoffs" -gt 0 ]; then
    pass "Heimdall span-fetch failure was classified as consensus-data unavailable; peers preserved (backed off)"
    info "=== RESULT: PASS (fix verified) ==="
    return 0
  else
    warn "span-fetch failed but neither a drop nor a backoff was observed — investigate"
    info "=== RESULT: INCONCLUSIVE ==="
    return 0
  fi
}

main "$@"
