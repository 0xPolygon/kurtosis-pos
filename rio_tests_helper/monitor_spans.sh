#!/bin/bash

trap "echo 'Stopping monitor_spans.sh'; exit" SIGINT

OUTPUT_FILE="spans_log.txt"

> "$OUTPUT_FILE"

# Initialize previous values
prev_id=""
prev_start_block=""
prev_end_block=""
prev_selected_producers=""

while true; do
  TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
  echo "[$TIMESTAMP]" >> "$OUTPUT_FILE"
  span_json=$(curl --silent $(kurtosis port print pos l2-cl-2-heimdall-v2-bor-validator http)/bor/spans/latest | jq '.span | {id, start_block, end_block, selected_producers: .selected_producers | map(.signer)}')
  echo "$span_json" >> "$OUTPUT_FILE"
  echo "---" >> "$OUTPUT_FILE"

  # Extract fields
  curr_id=$(echo "$span_json" | jq -r '.id')
  curr_start_block=$(echo "$span_json" | jq -r '.start_block')
  curr_end_block=$(echo "$span_json" | jq -r '.end_block')
  curr_selected_producers=$(echo "$span_json" | jq -c '.selected_producers')

  # Check condition
  if [[ "$curr_start_block" == "$prev_start_block" && "$curr_end_block" == "$prev_end_block" ]]; then
    if [[ "$curr_id" != "$prev_id" || "$curr_selected_producers" != "$prev_selected_producers" ]]; then
      echo "Change detected at [$TIMESTAMP]: start_block=$curr_start_block, end_block=$curr_end_block, id changed ($prev_id -> $curr_id) or selected_producers changed ($prev_selected_producers -> $curr_selected_producers)"
    fi
  fi

  # Update previous values
  prev_id="$curr_id"
  prev_start_block="$curr_start_block"
  prev_end_block="$curr_end_block"
  prev_selected_producers="$curr_selected_producers"

  sleep 10
done