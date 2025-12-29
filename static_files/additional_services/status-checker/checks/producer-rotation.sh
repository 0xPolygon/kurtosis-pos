#!/usr/bin/env bash

# Check if there has been a producer rotation.

# shellcheck source=static_files/additional_services/status-checker/checks/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

function get_span_length() {
  local span_id="$1"
  local span=$(curl -s "$heimdall_api/bor/spans/$span_id" | jq -r '.span')
  local start_block=$(echo "${span}" | jq -r '.start_block')
  local end_block=$(echo "${span}" | jq -r '.end_block')
  local length=$((end_block - start_block + 1))
  echo "${length}"
}

function get_span_producer() {
  local span_id="$1"
  local span=$(curl -s "$heimdall_api/bor/spans/$span_id" | jq -r '.span')
  local producer=$(echo "${span}" | jq -r '.selected_producers[0].val_id')
  echo "${producer}"
}

function get_span_start_block() {
  local span_id="$1"
  local span=$(curl -s "$heimdall_api/bor/spans/$span_id" | jq -r '.span')
  local start_block=$(echo "${span}" | jq -r '.start_block')
  echo "${start_block}"
}

# key=$(echo "$L2_URLS" | jq -r 'keys[0]')
# heimdall_api=$(echo "$key" | jq -r '.heimdall')
heimdall_api="http://127.0.0.1:34235"

# Get latest span
# latest_span_id=$(curl -s "$heimdall_api/bor/spans/latest" | jq -r '.span.id')
last_producer=""
last_start_block=""
for i in {0..20}; do
  # span_id=$((latest_span_id - i))
  span_length=$(get_span_length "$i")
  span_producer=$(get_span_producer "$i")
  span_start_block=$(get_span_start_block "$i")
  echo "span $i: $span_length blocks (start: $span_start_block) - producer $span_producer"

  if [[ $span_start_block -le $last_start_block ]]; then
    echo "WARN: span $((i-1)) has been replaced by span $i"
    echo "WARN: producer $last_producer was replaced by producer $span_producer"
  fi
  last_start_block="${span_start_block}"

  if [[ $span_length -ne 128 ]]; then
    echo "WARN: span $i has length $span_length, expected 128"
  fi

  if [[ -z "${last_producer}" ]]; then
    last_producer="${span_producer}"
    last_start_block="${span_start_block}"
    continue
  fi
  
  if [[ $last_producer -eq 1 && $span_producer -ne 2 ]]; then
    echo "WARN: span $i has been produced by producer $span_producer, expected 2"
  elif [[ $last_producer -eq 2 && $span_producer -ne 3 ]]; then
    echo "WARN: span $i has been produced by producer $span_producer, expected 3"
  elif [[ $last_producer -eq 3 && $span_producer -ne 1 ]]; then
    echo "WARN: span $i has been produced by producer $span_producer, expected 1"
  fi
  last_producer="${span_producer}"
done
