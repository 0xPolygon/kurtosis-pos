#!/usr/bin/env bash
set -euo pipefail

# This script performs multiple checks on spans:
# - Producer rotation detection
# - Overlapping spans detection
# - Span length is equal to 128 blocks
# - Selected producers count is equal to 1

# shellcheck source=static_files/additional_services/status-checker/checks/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"

# shellcheck source=static_files/additional_services/status-checker/checks/rio/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

heimdall_api="$(kurtosis port print pos l2-cl-1-heimdall-v2-bor-validator http)"

# Retrieve the last span checked from a temp file
temp_file="/tmp/producer_rotation_check.log"
last_checked_span_id=-1
previous_span_end_block=""
if [[ -f "${temp_file}" ]]; then
  last_checked_span_id=$(cat "${temp_file}" || echo -1)
  last_checked_span=$(get_span "${last_checked_span_id}")
  last_checked_span_end_block=$(echo "${last_checked_span}" | jq -r '.end_block')
  previous_span_end_block="${last_checked_span_end_block}"
fi
echo "INFO: Last checked span id: ${last_checked_span_id}"

# Get the latest span
latest_span_id="$(get_latest_span_id)"

# Skip the check if there are no new spans to check
if [[ "${latest_span_id}" -eq "${last_checked_span_id}" ]]; then
  echo "INFO: No new spans to check (latest: ${latest_span_id})"
  exit 0
fi

# Determine the range to check
start_span_id=$((last_checked_span_id + 1))
end_span_id="${latest_span_id}"
if [[ ${start_span_id} -eq ${end_span_id} ]]; then
  echo "INFO: Checking span ${start_span_id}"
else
  echo "INFO: Checking spans from id ${start_span_id} to ${end_span_id}"
fi

# Check spans for producer rotation
for ((i = start_span_id; i <= end_span_id; i++)); do
  current_span=$(get_span "$i")
  current_span_start_block=$(echo "${current_span}" | jq -r '.start_block')
  current_span_end_block=$(echo "${current_span}" | jq -r '.end_block')
  current_span_length=$((current_span_end_block - current_span_start_block + 1))
  current_span_selected_producers_count=$(echo "${current_span}" | jq -r '.selected_producers | length')

  # Only check for producer rotations and overlaps if we have a previous span to compare against
  if [[ -n "${previous_span_end_block}" ]]; then
    # Check for producer rotation
    # A span has ended normally if the start block of the next span is equal to the end block of the current span + 1.
    # If not, the current span has been replaced by the next span at its start block, also called a rotation.
    expected_start_block=$((previous_span_end_block + 1))
    if [[ ${current_span_start_block} -ne ${expected_start_block} ]]; then
      echo "WARN: Producer rotation detected! span $((i-1)) was replaced by span ${i} (expected start: ${expected_start_block}, actual: ${current_span_start_block})"
    fi

    # Check for overlapping spans
    if [[ ${current_span_start_block} -le ${previous_span_end_block} ]]; then
      echo "ERROR: Overlapping spans detected! span $((i-1)) (end: ${previous_span_end_block}) overlaps with span ${i} (start: ${current_span_start_block})"
    fi
  fi

  # Check if the span length is as expected
  expected_span_length=128
  if [[ ${current_span_length} -lt ${expected_span_length} ]]; then
    echo "ERROR: Span ${i} is shorter than expected (length: ${current_span_length}, expected: ${expected_span_length})"
  elif [[ ${current_span_length} -gt ${expected_span_length} ]]; then
    echo "WARN: Span ${i} is longer than expected (length: ${current_span_length}, expected: ${expected_span_length})"
  fi

  # Check if there is only one selected producer
  if [[ ${current_span_selected_producers_count} -ne 1 ]]; then
    echo "ERROR: Span ${i} has ${current_span_selected_producers_count} selected producers (expected: 1)"
  fi

  # Update previous span end block for the next iteration
  previous_span_end_block="${current_span_end_block}"
done

# Save the latest span checked
echo "${latest_span_id}" >"${temp_file}"
