#!/usr/bin/env bash
set -euo pipefail

# Source logging library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"

# Restore a PoS devnet from a kurtosis-pos snapshot.

##############################################################################
# DOCKER VOLUMES RESTORE
############################################################################

# Alpine image pinned by digest — same as snapshot.sh — so the restore tooling
# is reproducible and not affected by an upstream `alpine:latest` rebase.
ALPINE_IMAGE="alpine@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11"
ALPINE_ZSTD_IMAGE="kurtosis-pos-alpine-zstd:local"

# Build the zstd-enabled alpine image once. Matches the snapshot-side derivation
# so a snapshot built on one host can be restored on another without depending
# on a pre-built image being present.
ensure_alpine_zstd_image() {
  if ! docker image inspect "$ALPINE_ZSTD_IMAGE" > /dev/null 2>&1; then
    docker build --quiet --tag "$ALPINE_ZSTD_IMAGE" - << EOF > /dev/null
FROM $ALPINE_IMAGE
RUN apk add --no-cache zstd
EOF
  fi
}

restore_docker_volumes() {
  local volume_folder_path="$1"

  ensure_alpine_zstd_image

  # Restore from archives (.tar.zst)
  for v in "$volume_folder_path"/*.tar.zst; do
    [[ -f "$v" ]] || continue
    (
      volume_name=$(basename "$v" .tar.zst | sed 's/_/--/g')
      echo "$volume_name"
      docker volume create "$volume_name" > /dev/null
      docker run --rm \
        -v "$volume_name":/data \
        -v "$volume_folder_path":/backup \
        "$ALPINE_ZSTD_IMAGE" sh -c "zstd -d -q -c /backup/$(basename "$v") | tar xf - -C /data"
    ) &
  done

  # Restore from directories
  for d in "$volume_folder_path"/*/; do
    [[ -d "$d" ]] || continue
    (
      volume_name=$(basename "$d" | sed 's/_/--/g')
      echo "$volume_name"
      docker volume create "$volume_name" > /dev/null
      docker run --rm \
        -v "$volume_name":/data \
        -v "$(realpath "$d")":/backup \
        "$ALPINE_IMAGE" sh -c "cd /backup && tar cf - . | tar xf - -C /data"
    ) &
  done

  wait
}

##############################################################################
# MAIN WORKFLOW
##############################################################################

# Parse arguments
default_snapshot_folder="./tmp"
snapshot_folder="${1:-$default_snapshot_folder}"
if [[ -z "$snapshot_folder" ]]; then
  log_error "Snapshot folder is required"
  exit 1
fi
log_info "Using snapshot folder: $snapshot_folder"

log_info "Restoring docker volumes"
volume_folder_path="$snapshot_folder/volumes"
restore_docker_volumes "$volume_folder_path"
log_info "Docker volumes restored"

log_info "Starting devnet using docker-compose"
docker_compose_file="$snapshot_folder/docker-compose.yaml"
docker compose --file "$docker_compose_file" up --detach --wait
log_info "Devnet started"

# Re-apply the anvil L1 backend's captured state. snapshot.sh baked the live
# post-deploy anvil state (captured via the `anvil_dumpState` RPC) into the
# image as /anvil-state.hex, which extract.sh wrote out to the snapshot folder.
# anvil's own `--dump-state` writes only on SIGINT (not the SIGTERM the stop
# sequence sends), so the on-disk state isn't otherwise captured. Replay the hex
# via `anvil_loadState` so the restored devnet has the deployed L1 contracts.
# The file is present only for anvil-backend snapshots; absent under the
# ethereum-package backend, where this is a no-op. snapshot.sh::configure_ports
# binds anvil to host 8545.
anvil_state_file="$snapshot_folder/anvil-state.hex"
if [[ -s "$anvil_state_file" ]]; then
  anvil_rpc_url="http://127.0.0.1:8545"
  log_info "Re-applying captured anvil state via ${anvil_rpc_url} (anvil_loadState)"
  # `up --wait` gates on anvil's container healthcheck, which doesn't exercise
  # the JSON-RPC; poll until the RPC actually answers before loading state.
  deadline=$((SECONDS + 60))
  until curl -fsSL -X POST -H 'Content-Type: application/json' \
    --data '{"jsonrpc":"2.0","method":"web3_clientVersion","id":1}' \
    "$anvil_rpc_url" > /dev/null 2>&1; do
    if [[ "$SECONDS" -gt "$deadline" ]]; then
      log_error "anvil RPC at ${anvil_rpc_url} did not respond within 60s"
      exit 1
    fi
    sleep 1
  done
  # Assemble the JSON-RPC body in a file: the hex blob is multi-MB and exceeds
  # ARG_MAX as a command-line argument, so it goes through file redirection.
  anvil_body_file=$(mktemp)
  {
    printf '{"jsonrpc":"2.0","method":"anvil_loadState","params":["'
    # Strip any whitespace (a stray trailing newline embedded mid-string would
    # make the JSON-RPC body invalid); the hex itself has no internal spaces.
    tr -d '[:space:]' < "$anvil_state_file"
    printf '"],"id":1}'
  } > "$anvil_body_file"
  anvil_load_response=$(curl -fsSL -X POST -H 'Content-Type: application/json' \
    --data-binary "@${anvil_body_file}" "$anvil_rpc_url")
  rm -f "$anvil_body_file"
  if ! printf '%s' "$anvil_load_response" | jq -e '.result == true' > /dev/null 2>&1; then
    log_error "anvil_loadState rejected the captured state: ${anvil_load_response}"
    exit 1
  fi
  log_info "anvil L1 state restored"
fi

log_info "Use 'docker compose --file $docker_compose_file down --volumes' to remove the devnet"
