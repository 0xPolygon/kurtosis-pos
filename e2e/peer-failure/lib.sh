# shellcheck shell=bash

set -euo pipefail

ENCLAVE="${ENCLAVE:-pos}"

BOR_VALIDATOR_0="${BOR_VALIDATOR_0:-l2-el-0-bor-heimdall-v2-validator}"
BOR_VALIDATOR_1="${BOR_VALIDATOR_1:-l2-el-1-bor-heimdall-v2-validator}"
BOR_RPC_0="${BOR_RPC_0:-l2-el-0-bor-heimdall-v2-rpc}"
BOR_RPC_1="${BOR_RPC_1:-l2-el-1-bor-heimdall-v2-rpc}"
HEIMDALL_RPC_0="${HEIMDALL_RPC_0:-l2-cl-0-heimdall-v2-bor-rpc}"
HEIMDALL_RPC_1="${HEIMDALL_RPC_1:-l2-cl-1-heimdall-v2-bor-rpc}"

_ts()   { date -u +%H:%M:%S; }
log()   { printf '[%s] %s\n' "$(_ts)" "$*" >&2; }
info()  { log "INFO  $*"; }
warn()  { log "WARN  $*"; }
pass()  { log "PASS  $*"; }
fail()  { log "FAIL  $*"; return 1; }

host_port() {
  local svc="$1" port_id="$2" url
  url="$(kurtosis port print "$ENCLAVE" "$svc" "$port_id")" \
    || { warn "no host port for $svc/$port_id"; return 1; }
  echo "${url#*://}"
}

rpc_url()     { echo "http://$(host_port "$1" rpc)"; }
metrics_url() { echo "http://$(host_port "$1" metrics)/debug/metrics/prometheus"; }

svc_logs() { kurtosis service logs "$ENCLAVE" "$@"; }

svc_stop()  { info "stopping  $1";  kurtosis service stop  "$ENCLAVE" "$1"; }
svc_start() { info "starting  $1";  kurtosis service start "$ENCLAVE" "$1"; }

block_number() {
  local url; url="$(rpc_url "$1")"
  local hex
  hex="$(curl -fsS -X POST -H 'content-type: application/json' \
    --data '{"jsonrpc":"2.0","id":1,"method":"eth_blockNumber","params":[]}' \
    "$url" | sed -E 's/.*"result":"(0x[0-9a-fA-F]+)".*/\1/')"
  printf '%d\n' "$hex"
}

enode() {
  local url; url="$(rpc_url "$1")"
  curl -fsS -X POST -H 'content-type: application/json' \
    --data '{"jsonrpc":"2.0","id":1,"method":"admin_nodeInfo","params":[]}' \
    "$url" 2>/dev/null \
    | grep -oE 'enode://[0-9a-f]{128}@[^"]+' | head -n1
}

_ALL_SERVICES=""
all_services() {
  if [ -z "$_ALL_SERVICES" ]; then
    # Node services end in -validator or -rpc; drop helper services (-config, -keys,
    # -keys-generator-config, etc.). Indexing is 1-based and sequential across kinds
    # (validators 1..N, then RPCs N+1..), so patterns must stay index-agnostic.
    _ALL_SERVICES="$(kurtosis enclave inspect "$ENCLAVE" 2>/dev/null \
      | grep -oE 'l2-(el|cl)-[0-9]+-[a-z0-9-]+' \
      | grep -E '(validator|rpc)$' | sort -u || true)"
  fi
  printf '%s\n' "$_ALL_SERVICES"
}

find_service() { all_services | grep -E "$1" | head -n1 || true; }

heimdall_for() {
  local bor="$1" idx role
  idx="$(printf '%s' "$bor" | sed -E 's/^l2-el-([0-9]+)-.*/\1/')"
  case "$bor" in
    *validator*) role='validator' ;;
    *rpc*)       role='rpc' ;;
    *)           role='' ;;
  esac
  find_service "^l2-cl-${idx}-heimdall.*${role}"
}

other_validator() {
  all_services | grep -E '^l2-el-[0-9]+-bor-.*validator' | grep -vx "$1" | head -n1 || true
}

dump_enclave() {
  warn "discovered l2 services: $(all_services | tr '\n' ' ')"
  warn "raw 'kurtosis enclave inspect $ENCLAVE':"
  kurtosis enclave inspect "$ENCLAVE" 2>&1 | sed 's/^/    /' | head -n 100 >&2 || true
}

metric_value() {
  local svc="$1" name="$2" url
  url="$(metrics_url "$svc")" || { echo 0; return; }
  curl -fsS "$url" 2>/dev/null \
    | awk -v n="$name" '$1==n {v=$2} END {print (v==""?0:v)}'
}

wait_until() {
  local timeout="$1"; shift
  local deadline=$(( $(date +%s) + timeout ))
  until "$@"; do
    if [ "$(date +%s)" -ge "$deadline" ]; then
      return 1
    fi
    sleep 2
  done
}

assert_log_contains() {
  local svc="$1" pat="$2" desc="$3"
  if svc_logs "$svc" | grep -qE "$pat"; then
    pass "$desc"
  else
    fail "$desc — expected bor log matching /$pat/ on $svc"
  fi
}

assert_log_absent() {
  local svc="$1" pat="$2" desc="$3"
  if svc_logs "$svc" | grep -qE "$pat"; then
    fail "$desc — unexpected bor log matching /$pat/ on $svc"
  else
    pass "$desc"
  fi
}

LOGSIG_DROP='Synchronisation failed, dropping peer'
LOGSIG_JAIL='Downloader: locally jailing peer'
LOGSIG_BACKOFF='Downloader: backing off peer'
LOGSIG_CONSENSUS_BACKOFF='local consensus data unavailable'
LOGSIG_INVALID_CHAIN_CTX='retrieved hash chain is invalid: .*context deadline exceeded'
LOGSIG_SPAN_FETCH_FAIL='Unable to fetch span|error while trying fetching from Heimdall'
