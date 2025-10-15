#!/usr/bin/env bash
set -euo pipefail

# Log span information for debugging purposes.

# shellcheck source=static_files/additional_services/status-checker/checks/rio/lib.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib.sh"

heimdall_api="$(kurtosis port print pos l2-cl-1-heimdall-v2-bor-validator http)"

# Retrieve the last span checked from a temp file.
temp_file="/tmp/logger.log"
last_checked_span_id=-1
if [[ -f "${temp_file}" ]]; then
  last_checked_span_id=$(cat "${temp_file}" || echo -1)
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

# Log span information
for ((i = start_span_id; i <= end_span_id; i++)); do
  current_span=$(get_span "$i")
  current_span_start_block=$(echo "${current_span}" | jq -r '.start_block')
  current_span_end_block=$(echo "${current_span}" | jq -r '.end_block')
  current_span_length=$((current_span_end_block - current_span_start_block + 1))
  current_span_producer=$(echo "${current_span}" | jq -r '.selected_producers[0].val_id')
  echo "INFO: span $i start_block=${current_span_start_block}, end_block=${current_span_end_block}, length=${current_span_length}, producer=${current_span_producer}"
done

# Save the latest span checked
echo "${latest_span_id}" >"${temp_file}"
