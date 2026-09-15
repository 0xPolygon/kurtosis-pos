#!/usr/bin/env bash
# Flapping loop: N x (kill <service> for <down>s, then wait <gap>s). One tartarus
# record per cycle (ids <label>-NN). Logs to probes/flap-<label>.log.
#   usage: flap.sh <service> <label> <cycles> <down_s> <gap_s>
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
svc="${1:?svc}"; label="${2:?label}"; n="${3:-30}"; down="${4:-5}"; gap="${5:-20}"
out="$CAMPAIGN_DIR/probes/flap-$label.log"
echo "$(date -u +%FT%TZ) START flap $svc x$n down=${down}s gap=${gap}s" >> "$out"
for i in $(seq -w 1 "$n"); do
  r=$(tartarus fault run --kind kill --enclave "$E" --node "$svc" --for "${down}s" --id "$label-$i" --note "flap $i/$n" 2>/dev/null)
  echo "$(date -u +%FT%TZ) cycle $i ok=$(jq -r .ok <<<"$r") state=$(jq -r .data.state <<<"$r") recovery=$(jq -r '.data.instances[0].recovery' <<<"$r") ports_moved=$(jq -r '(.data.endpoint_changes // []) | length' <<<"$r")" >> "$out"
  sleep "$gap"
done
echo "$(date -u +%FT%TZ) END flap $svc" >> "$out"
