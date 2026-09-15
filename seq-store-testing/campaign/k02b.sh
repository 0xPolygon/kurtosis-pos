#!/usr/bin/env bash
# k02b: grow the store until the gateway window cap (256 MB) evicts, sampling
# window bytes / entries / RSS every 30 s; then cold-start a gateway at the
# larger size and check consumers re-anchor. usage: k02b.sh <rate> <max_minutes>
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"
rate="${1:-400}"; maxmin="${2:-30}"; out="$CAMPAIGN_DIR/probes/k02b.log"
sample() { refresh_nodes; local l="$(date -u +%FT%TZ)"; for g in 0 1 2; do m=$(curl -s --max-time 3 "127.0.0.1:$(port seqstore-gateway-$g 9600)/metrics"); l+=" gw$g:entries=$(awk '$1=="seqstore_gateway_window_entries"{print $2}' <<<"$m") bytes_mb=$(awk '$1=="seqstore_gateway_window_bytes"{printf "%.0f",$2/1048576}' <<<"$m") evicted=$(awk '$1=="seqstore_gateway_window_evicted_total"{print $2}' <<<"$m") rss_mb=$(awk '$1=="process_resident_memory_bytes"{printf "%.0f",$2/1048576}' <<<"$m") heap_mb=$(awk '$1=="go_memstats_heap_inuse_bytes"{printf "%.0f",$2/1048576}' <<<"$m")"; done; echo "$l" >> "$out"; echo "$l"; }
echo "### k02b start $(date -u +%FT%TZ) rate=$rate" >> "$out"; sample
(campaign/heavyload.sh "$rate" "$maxmin" "$CAMPAIGN_DIR/keys-heavy.txt" &) 
for i in $(seq 1 $((maxmin*2))); do sleep 30; s=$(sample); ev=$(grep -oE 'gw0:[^ ]* [^ ]* evicted=[0-9]+' <<<"$s" | grep -oE 'evicted=[0-9]+' | cut -d= -f2); if [[ -n "$ev" && "$ev" != 0 ]]; then echo "EVICTION observed at $(date -u +%FT%TZ)" | tee -a "$out"; break; fi; done
echo "### heavy load phase done $(date -u +%FT%TZ)" >> "$out"
