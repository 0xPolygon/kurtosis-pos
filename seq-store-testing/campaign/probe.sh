#!/usr/bin/env bash
# 1 Hz oracle. One line per second:
#   <utc> author=vN ms=<milestone end> cp=<checkpoint count> ing=<ingress ok entries> gw0=<gateway-0 position> | el-1=<n>:<hash> ... el-9=<n>:<hash> | p1: <producer publish metrics> | p2: ... | p3: ...
# Ports are re-read every 15 s so restarted containers are picked up.
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
out="$CAMPAIGN_DIR/probes/oracle.log"
tick=0
while true; do
  if (( tick % 15 == 0 )); then refresh_nodes; ip=$(port seqstore-ingress 9600); gp=$(port seqstore-gateway-0 9600); fi
  line="$(date -u +%FT%TZ) author=v$(in_turn) ms=$(milestone) cp=$(checkpoint_count) ing=$(metric "$ip" 'seqstore_ingress_entries_total{status="ok"}') gw0=$(metric "$gp" seqstore_gateway_position) |"
  for n in 1 2 3 4 5 6 7 8 9; do
    p=$(port "${EL[$n]}" 8545)
    if [[ -z "$p" ]]; then line+=" el-$n=down"; else read -r num hash <<<"$(head_of "$p")"; line+=" el-$n=$num:$hash"; fi
  done
  for n in 1 2 3; do mp=$(port "${EL[$n]}" 7071); [[ -n "$mp" ]] && line+=" | p$n: $(producer_metrics "$mp")"; done
  echo "$line" >> "$out"
  tick=$((tick+1)); sleep 1
done
