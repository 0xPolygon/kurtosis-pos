# shellcheck shell=bash
# This file defines common utility functions used by multiple bash-based status
# checks. It does NOT include a shebang so that the status-checker skips
# executing this file directly.

set -euo pipefail
set -o errtrace
trap 'echo "Error in ${BASH_SOURCE[0]} at line ${LINENO}." >&2' ERR
