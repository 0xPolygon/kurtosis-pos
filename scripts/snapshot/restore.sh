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

log_info "Use 'docker compose --file $docker_compose_file down --volumes' to remove the devnet"
