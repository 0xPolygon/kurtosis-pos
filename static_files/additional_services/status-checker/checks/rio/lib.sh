# shellcheck shell=bash
# This file defines common utility functions used by multiple bash-based status
# checks. It does NOT include a shebang so that the status-checker skips
# executing this file directly.

function get_latest_span_id() {
  local latest_span_id=$(curl -s "${heimdall_api}/bor/spans/latest" | jq -r '.span.id')
  echo "${latest_span_id}"
}

function get_span() {
  local span_id="$1"
  local span=$(curl -s "${heimdall_api}/bor/spans/${span_id}" | jq -r '.span')
  echo "${span}"
}
