#!/usr/bin/env bash
# Resource monitor for flapping tests: every 10 s, one line per process with
# goroutines, open fds, RSS for the seqstore services and the three producers'
# bor + the two RPC bors. Output: probes/leakmon-<label>.log
#   usage: leakmon.sh <label>
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
label="${1:?label}"; out="$CAMPAIGN_DIR/probes/leakmon-$label.log"
# bor runs under container-proc-manager.sh (PID 1); find the bor process itself
borpid() { docker exec "$1" sh -c 'pidof bor 2>/dev/null || for p in /proc/[0-9]*; do [ "$(cat $p/comm 2>/dev/null)" = bor ] && basename $p; done' 2>/dev/null | head -1; }
fds() { local pid; pid=$(borpid "$1"); docker exec "$1" sh -c "ls /proc/${pid:-1}/fd 2>/dev/null | wc -l" 2>/dev/null || echo "?"; }
rss_kb() { local pid; pid=$(borpid "$1"); docker exec "$1" sh -c "awk '/VmRSS/ {print \$2}' /proc/${pid:-1}/status" 2>/dev/null || echo "?"; }
while true; do
  refresh_nodes; now=$(date -u +%FT%TZ)
  for svc in seqstore-ingress seqstore-gateway-0 seqstore-gateway-1 seqstore-gateway-2 seqstore-auditor; do
    p=$(port "$svc" 9600); cid=$(docker ps --format '{{.ID}} {{.Names}}' | grep " $svc--" | cut -d' ' -f1)
    [[ -z "$p" || -z "$cid" ]] && { echo "$now $svc down" >> "$out"; continue; }
    m=$(curl -s --max-time 2 "127.0.0.1:$p/metrics")
    echo "$now $svc goroutines=$(awk '$1=="go_goroutines"{print $2}' <<<"$m") fds=$(awk '$1=="process_open_fds"{print $2}' <<<"$m") rss_mb=$(awk '$1=="process_resident_memory_bytes"{printf "%.0f", $2/1048576}' <<<"$m") streams=$(awk '$1=="seqstore_gateway_streams"||$1=="seqstore_ingress_publisher_streams"{print $2}' <<<"$m")" >> "$out"
  done
  for n in 1 2 3 8 9; do
    svc="${EL[$n]}"; pp=$(port "$svc" 6060); cid=$(docker ps --format '{{.ID}} {{.Names}}' | grep " $svc--" | cut -d' ' -f1)
    [[ -z "$pp" || -z "$cid" ]] && { echo "$now el-$n down" >> "$out"; continue; }
    g=$(curl -s --max-time 2 "127.0.0.1:$pp/debug/pprof/goroutine?debug=1" | head -1 | awk '{print $4}')
    echo "$now el-$n goroutines=$g fds=$(fds $cid) rss_mb=$(( $(rss_kb $cid | tr -dc 0-9 || echo 0) / 1024 ))" >> "$out"
  done
  sleep 10
done
