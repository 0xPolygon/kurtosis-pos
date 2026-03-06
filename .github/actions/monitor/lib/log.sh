#!/bin/bash

# Logging library
# Usage: source /path/to/log.sh
#
# Set log level via LOG_LEVEL environment variable:
# - LOG_LEVEL=DEBUG  - Show all logs
# - LOG_LEVEL=INFO   - Show INFO, WARN, ERROR (default)
# - LOG_LEVEL=WARN   - Show WARN, ERROR
# - LOG_LEVEL=ERROR  - Show ERROR only

# All logs go to stderr to not interfere with stdout data streams

# Default log level
: "${LOG_LEVEL:=INFO}"

# Normalize log level to uppercase
LOG_LEVEL="${LOG_LEVEL^^}"

# Log level values (higher = more severe)
declare -A _LOG_LEVELS=([DEBUG]=0 [INFO]=1 [WARN]=2 [ERROR]=3)

timestamp() { date +"%Y-%m-%d %H:%M:%S"; }

# Helper function to check if we should log at this level
_should_log() {
  local level=$1
  local current_level_value=${_LOG_LEVELS[$LOG_LEVEL]:-1}
  local message_level_value=${_LOG_LEVELS[$level]:-0}
  [[ $message_level_value -ge $current_level_value ]]
}

# Helper function to format key=value pairs
_format_fields() {
  local msg="$1"
  shift
  local fields=""
  for arg in "$@"; do
    fields="$fields $arg"
  done
  echo "$msg$fields"
}

log_debug() {
  if _should_log DEBUG; then
    echo "$(timestamp) DEBUG $(_format_fields "$@")" >&2
  fi
}

log_info() {
  if _should_log INFO; then
    echo "$(timestamp) INFO $(_format_fields "$@")" >&2
  fi
}

log_warn() {
  if _should_log WARN; then
    echo "$(timestamp) WARN $(_format_fields "$@")" >&2
  fi
}

log_error() {
  if _should_log ERROR; then
    echo "$(timestamp) ERROR $(_format_fields "$@")" >&2
  fi
}

# Log a block of text with a border for better visibility
log_block() {
  local line="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" # 110 characters - half of the size of my screen
  echo "${line}" >&2
  echo "${line}" >&2

  # Highlight specific log level patterns
  echo "$*" | sed \
    -e 's/"lvl":\s*"\(error\)"/"lvl": "\x1b[31m\1\x1b[0m"/g' \
    -e 's/"level":\s*"\(ERROR\)"/"level": "\x1b[31m\1\x1b[0m"/g' \
    -e 's/"lvl":\s*"\(warn\)"/"lvl": "\x1b[33m\1\x1b[0m"/g' \
    -e 's/"level":\s*"\(WARN\)"/"level": "\x1b[33m\1\x1b[0m"/g' >&2

  echo "${line}" >&2
  echo "${line}" >&2
}
