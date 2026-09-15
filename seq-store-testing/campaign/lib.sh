#!/usr/bin/env bash
# Shared helpers for the tartarus chaos campaign against the `pos` enclave.
# Source this file:  source campaign/lib.sh
export TARTARUS_OUTPUT=json
export E=pos
CAMPAIGN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export TARTARUS_STATE_DIR="$CAMPAIGN_DIR/store"
export NODES_JSON="$CAMPAIGN_DIR/nodes.json"

# Service names by role.
EL=(x l2-el-1-bor-heimdall-v2-validator l2-el-2-bor-heimdall-v2-validator l2-el-3-bor-heimdall-v2-validator l2-el-4-bor-heimdall-v2-validator l2-el-5-bor-heimdall-v2-validator l2-el-6-bor-heimdall-v2-validator l2-el-7-bor-heimdall-v2-validator l2-el-8-bor-heimdall-v2-rpc-archive l2-el-9-bor-heimdall-v2-rpc)
CL=(x l2-cl-1-heimdall-v2-bor-validator l2-cl-2-heimdall-v2-bor-validator l2-cl-3-heimdall-v2-bor-validator l2-cl-4-heimdall-v2-bor-validator l2-cl-5-heimdall-v2-bor-validator l2-cl-6-heimdall-v2-bor-validator l2-cl-7-heimdall-v2-bor-validator l2-cl-8-heimdall-v2-bor-rpc-archive l2-cl-9-heimdall-v2-bor-rpc)

# refresh_nodes: re-read the cluster (ports move when a container restarts).
refresh_nodes() { tartarus cluster nodes --enclave "$E" 2>/dev/null > "$NODES_JSON.tmp" && mv -f "$NODES_JSON.tmp" "$NODES_JSON"; }

# port SERVICE CONTAINER_PORT -> host port (empty if the node is down)
port() {
  jq -r --arg n "$1" --argjson p "$2" \
    '.data.nodes[]|select(.name==$n)|.ports[]|select(.container_port==$p and .host_ip=="0.0.0.0")|.host_port' "$NODES_JSON"
}

rpc_call() { # rpc_call PORT METHOD [PARAMS_JSON]
  curl -s --max-time 1 -X POST -H 'content-type: application/json' \
    --data "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"$2\",\"params\":${3:-[]}}" "http://127.0.0.1:$1/"
}

# head_of PORT -> "number hash" of the latest block, or "down -"
head_of() {
  local r; r="$(rpc_call "$1" eth_getBlockByNumber '["latest",false]')" || true
  local n h; n="$(jq -r '.result.number // empty' <<<"$r")"; h="$(jq -r '.result.hash // empty' <<<"$r")"
  [[ -n "$n" ]] && printf '%d %s\n' "$n" "${h:0:14}" || echo "down -"
}

author() { rpc_call "$1" bor_getAuthor '["latest"]' | jq -r '.result // "?"'; }

# Heimdall REST helpers (archive RPC heimdall by default).
hport() { port l2-cl-1-heimdall-v2-bor-validator 1317; }
milestone() { curl -s --max-time 1 "127.0.0.1:$(hport)/milestones/latest" | jq -r '.milestone.end_block // "?"'; }
checkpoint_count() { curl -s --max-time 1 "127.0.0.1:$(hport)/checkpoints/count" | jq -r '.ack_count // "?"'; }
# latest *registered* span (usually the next one, not the one at head)
span_producer() { curl -s --max-time 1 "127.0.0.1:$(hport)/bor/spans/latest" | jq -r '.span | "\(.id):\(.start_block)-\(.end_block):v\(.selected_producers[0].val_id)"'; }

# in_turn -> node index (1..7) of the validator that sealed the latest block on el-8
# (signer 0xNNNN... is validator N, which is l2-el-N / l2-cl-N)
in_turn() { author "$(port l2-el-8-bor-heimdall-v2-rpc-archive 8545)" | cut -c3 ; }

metric() { # metric PORT NAME -> value (first sample)
  curl -s --max-time 1 "http://127.0.0.1:$1/metrics" | awk -v n="$2" '$1==n {print $2; exit}'
}
# bor_metric PORT NAME [LABELS]   (bor prints `name {labels} value` with a space)
bor_metric() {
  curl -s --max-time 1 "http://127.0.0.1:$1/debug/metrics/prometheus" \
    | awk -v n="$2" -v l="$3" '$1==n && ((l=="" && $2 !~ /^\{/) || $2==l) {print $NF; exit}'
}
# producer_metrics PORT -> "state=<n> barrier=<n> failed=<n> redial=<n> seal_p50_ms=<n>"
producer_metrics() {
  curl -s --max-time 1 "http://127.0.0.1:$1/debug/metrics/prometheus" | awk '
    $1=="sequencer_publish_state" {s=$NF}
    $1=="sequencer_publish_barriertimeout" {b=$NF}
    $1=="sequencer_publish_failed" {f=$NF}
    $1=="sequencer_publish_redial" {r=$NF}
    $1=="sequencer_publish_muted" {m=$NF}
    $1=="eth_seal2broadcast" && $2=="{quantile=\"0.5\"}" {sl=$NF/1e3}
    END {printf "state=%s barrier=%s failed=%s redial=%s muted=%s seal_p50_us=%.0f", s, b, f, r, m, sl}'
}

# window_logs ID SERVICE -> writes bor/heimdall logs between record started_at-30s and now+0
window_logs() {
  local id="$1" svc="$2" rec since
  rec="$(tartarus fault inspect "$id" 2>/dev/null)"
  since=$(( $(date -u -d "$(jq -r .data.started_at <<<"$rec")" +%s) - 30 ))
  local until; until=$(( $(date -u -d "$(jq -r '.data.stopped_at // .data.started_at' <<<"$rec")" +%s) + 75 ))
  local cid; cid="$(docker ps -a --filter "name=^${svc}--" --format '{{.ID}}' | head -1)"
  [[ -n "$cid" ]] && docker logs --since "$since" --until "$until" "$cid" > "$CAMPAIGN_DIR/records/$id-$svc.log" 2>&1
}

# anomalies FILE -> summary of interesting lines in a log file
# seal_summary FILE -> distribution of "Successfully sealed new block elapsed="
seal_summary() {
  grep -oE 'Successfully sealed new block.*elapsed=[0-9.]+(ms|s|µs)' "$1" | grep -oE 'elapsed=.*' \
    | sed -E 's/elapsed=//' | awk '
      /µs$/ {v=(substr($0,1,length($0)-3)+0)/1000}
      /ms$/ {v=substr($0,1,length($0)-2)+0}
      /[0-9]s$/ {v=(substr($0,1,length($0)-1)+0)*1000}
      {n++; if (v>=100) slow++; if (v>max) max=v; sum+=v}
      END {if (n) printf "seals=%d slow(>=100ms)=%d max_ms=%.0f mean_ms=%.1f\n", n, slow, max, sum/n; else print "no seals"}'
}

anomalies() {
  seal_summary "$1"
  sed -E 's/\x1b\[[0-9;]*m//g' "$1" \
    | grep -E 'ERROR|WARN| ERR | WRN |WARNING:|Rewind|reorg|Reorg|panic|fork|Imported new chain segment.*blocks=[0-9]{2,}' \
    | sed -E 's/^\[[^]]*\] //; s/\[[0-9-]+\|[0-9:.]+\]//; s/^[0-9]{4}-[0-9-]+T[0-9:.]+Z //; s/[0-9]{4}\/[0-9]{2}\/[0-9]{2} [0-9:]{8} //; s/task_[0-9a-f-]+/task_X/g; s/height=[0-9]+/height=N/g' \
    | cut -c1-140 | sort | uniq -c | sort -rn | head -25
}

# episode ID [--logs "svc1 svc2"] [--post SECS] -- <tartarus fault run args>
#   runs the fault, saves records/ID.json, waits POST seconds for recovery,
#   refreshes ports, runs analyze.py, saves windowed logs + anomaly summary.
episode() {
  local id="$1"; shift
  (( ${#id} <= 64 )) || { echo "episode: id '$id' is ${#id} chars; tartarus max is 64"; return 2; }
  local logs="" post=75
  while [[ "$1" != "--" ]]; do
    case "$1" in --logs) logs="$2"; shift 2;; --post) post="$2"; shift 2;; *) echo "bad arg $1"; return 2;; esac
  done; shift
  echo "### $id  $(date -u +%FT%TZ)  in_turn=v$(in_turn)  head=$(head_of "$(port l2-el-8-bor-heimdall-v2-rpc-archive 8545)")  next_span=$(span_producer)"
  tartarus fault run --enclave "$E" --id "$id" "$@" > "$CAMPAIGN_DIR/records/$id.json" 2> "$CAMPAIGN_DIR/records/$id.stderr"
  local rc=$?
  jq -c '{ok, state: .data.state, note: .data.note, error: .error.code, started: .data.started_at, applied: .data.applied_at, stopped: .data.stopped_at, inst: [.data.instances[]? | {target, apply, recovery}], endpoint_changes: (.data.endpoint_changes // [] | length), observations: (.data.observations // [] | length), warnings: [.warnings[]? | select(startswith("endpoint changed")|not)]}' "$CAMPAIGN_DIR/records/$id.json"
  (( rc == 0 )) || { echo "fault run exited $rc"; jq '.error' "$CAMPAIGN_DIR/records/$id.json"; [[ "$(jq -r '.data.started_at // empty' "$CAMPAIGN_DIR/records/$id.json")" ]] || return "$rc"; }
  echo "--- post-fault observation ${post}s"; sleep "$post"
  refresh_nodes
  echo "--- after: in_turn=v$(in_turn) heads:"; for n in 1 2 3 4 5 6 7 8 9; do p=$(port "${EL[$n]}" 8545); printf ' el-%s=%s' "$n" "$([[ -n "$p" ]] && head_of "$p" | tr ' ' ':' || echo down)"; done; echo
  python3 "$CAMPAIGN_DIR/analyze.py" "$id"
  echo "--- author trail (el-8 canonical, sampled): $(awk -v a="$(jq -r .data.started_at "$CAMPAIGN_DIR/records/$id.json" | cut -c1-19)Z" -v b="$(date -u +%FT%TZ)" '$1>=a && $1<=b {for(i=1;i<=NF;i++) if($i ~ /^el-8=/){split($i,x,"[=:]"); h=x[2]} if ($2!=p) {printf "%s@%s ", $2, h; p=$2}}' "$CAMPAIGN_DIR/probes/oracle.log")"
  for svc in $logs; do
    window_logs "$id" "$svc"
    echo "--- anomalies $svc ($(wc -l < "$CAMPAIGN_DIR/records/$id-$svc.log") lines)"; anomalies "$CAMPAIGN_DIR/records/$id-$svc.log"
  done
  echo "--- active faults: $(tartarus fault list | jq -c '[.data.records[].id]')"
}

# pc_episode ID [episode args...] -- <tartarus args>
#   episode + preconf verification of the window [started_at-30s, now] against el-8.
pc_episode() {
  local id="$1"
  episode "$@"
  local started; started=$(jq -r '.data.started_at // empty' "$CAMPAIGN_DIR/records/$id.json")
  [[ -n "$started" ]] || return 0
  local since; since=$(date -u -d "$(date -u -d "$started" +%s | awk '{print $1-30}' | xargs -I{} date -u -d @{} +%FT%TZ)" +%FT%TZ)
  echo "--- preconf check window since $since (file: ${PRECONF_FILE:-campaign/probes/preconfs-base.jsonl})"
  python3 "$CAMPAIGN_DIR/preconf-check.py" "${PRECONF_FILE:-$CAMPAIGN_DIR/probes/preconfs-base.jsonl}" --since "$since" || true
}
