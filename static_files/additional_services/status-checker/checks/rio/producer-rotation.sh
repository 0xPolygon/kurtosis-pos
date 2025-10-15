#!/usr/bin/env bash
set -euo pipefail

# Check if a producer has been rotated before the end of its span by comparing the start and end blocks of consecutive spans.
# Under normal conditions, a producer should produce for the entire span length.
# If a producer is not active, behind, has crashed or is producing blocks after the threshold, etc, it may be replaced by another producer, also called a rotation.
# A span has ended normally if the start block of the next span is equal to the end block of the current span + 1.
# If not, the current span has been replaced by the next span at its start block.

# shellcheck source=static_files/additional_services/status-checker/checks/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"

# shellcheck source=static_files/additional_services/status-checker/checks/rio/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

heimdall_api="$(kurtosis port print pos l2-cl-1-heimdall-v2-bor-validator http)"

# Retrieve the last span checked from a temp file.
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

  # Only check for rotation if we have a previous span to compare against
  if [[ -n "${previous_span_end_block}" ]]; then
    expected_start_block=$((previous_span_end_block + 1))
    if [[ ${current_span_start_block} -ne ${expected_start_block} ]]; then
      echo "WARN: Producer rotation detected! span $((i-1)) was replaced by span ${i} (expected start: ${expected_start_block}, actual: ${current_span_start_block})"
    fi
  fi
  previous_span_end_block="${current_span_end_block}"
done

# Save the latest span checked
echo "${latest_span_id}" >"${temp_file}"
