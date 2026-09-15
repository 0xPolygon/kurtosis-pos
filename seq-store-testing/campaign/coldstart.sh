#!/usr/bin/env bash
# Measure ingress / gateway cold-start (replay) time vs topic size.
# Restarts the service with a recorded tartarus stop (5 s hold), then polls the
# ops /metrics until <role>_ready == 1, printing elapsed seconds and the
# replay counters. usage: coldstart.sh <service> <label>
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
svc="${1:?service}"; label="${2:?label}"
role=$([[ $svc == *ingress* ]] && echo ingress || echo gateway)
refresh_nodes; p=$(port "$svc" 9600)
size=$(metric "$(port seqstore-gateway-0 9600)" seqstore_gateway_position)
echo "### coldstart $svc  $(date -u +%FT%TZ)  topic_position=$size"
tartarus fault run --kind stop --enclave "$E" --node "$svc" --for 5s --id "cold-$label" --note "cold start measurement at position $size" 2>/dev/null > "$CAMPAIGN_DIR/records/cold-$label.json"
stopped=$(jq -r .data.stopped_at "$CAMPAIGN_DIR/records/cold-$label.json"); t0=$(date -u -d "$stopped" +%s.%N)
refresh_nodes; p=$(port "$svc" 9600)
for i in $(seq 1 600); do
  m=$(curl -s --max-time 1 "127.0.0.1:$p/metrics" 2>/dev/null); r=$(awk -v k="seqstore_${role}_ready" '$1==k{print $2}' <<<"$m")
  if [[ "$r" == "1" ]]; then t1=$(date +%s.%N); printf 'ready after %.1f s (from container start)  replay_entries=%s replay_seconds=%s\n' "$(echo "$t1 - $t0" | bc)" "$(awk '$1~/replay_entries/{print $2}' <<<"$m")" "$(awk '$1~/replay_seconds_sum/{print $2}' <<<"$m")"; exit 0; fi
  sleep 0.5
done
echo "NOT READY after 300 s"; exit 1
