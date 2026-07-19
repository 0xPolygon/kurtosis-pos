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
  svc_logs "$1" \
    | grep -oE 'enode://[0-9a-f]{128}@[0-9.]+:[0-9]+' \
    | tail -n1
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
