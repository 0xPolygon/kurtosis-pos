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

restore_docker_volumes() {
  local volume_folder_path="$1"

  # Restore from archives (.tar.gz)
  for v in "$volume_folder_path"/*.tar.gz; do
    [[ -f "$v" ]] || continue
    (
      volume_name=$(basename "$v" .tar.gz | sed 's/_/--/g')
      echo "$volume_name"
      docker volume create "$volume_name" > /dev/null
      docker run --rm \
        -v "$volume_name":/data \
        -v "$volume_folder_path":/backup \
        "$ALPINE_IMAGE" tar xzf /backup/$(basename "$v") -C /data
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

# Sanity check: snapshot layout must exist before we try to restore.
if [[ ! -d "$snapshot_folder/volumes" ]]; then
  log_error "Volumes directory not found: $snapshot_folder/volumes"
  log_error "Did you run extract.sh first?"
  exit 1
fi
if [[ ! -f "$snapshot_folder/docker-compose.yaml" ]]; then
  log_error "docker-compose.yaml not found in $snapshot_folder"
  exit 1
fi

# The generated compose uses `healthcheck.start_interval`, which requires
# Docker Engine 25+ (Nov 2023). Older versions reject the field with an
# opaque schema error. Surface a clear message instead.
docker_server_version=$(docker version --format '{{.Server.Version}}' 2>/dev/null || echo "")
docker_major="${docker_server_version%%.*}"
if [[ -z "$docker_major" || "$docker_major" -lt 25 ]]; then
  log_error "Docker Engine 25+ required (found: ${docker_server_version:-unknown})"
  log_error "The snapshot's compose uses healthcheck.start_interval, added in Docker 25."
  exit 1
fi

log_info "Restoring docker volumes"
volume_folder_path="$(realpath "$snapshot_folder/volumes")"
restore_docker_volumes "$volume_folder_path"
log_info "Docker volumes restored"

log_info "Starting devnet using docker-compose"
docker_compose_file="$snapshot_folder/docker-compose.yaml"
# `--wait` blocks until every service with a healthcheck is healthy. With the
# tuned healthchecks emitted by snapshot.sh (start_interval=250ms) and the
# dropped validator→rabbit dependency, this completes in ~5s on the small
# devnet — and covers every L2 EL/CL node, not just bor-1.
docker compose --file "$docker_compose_file" up --detach --wait
log_info "Devnet started"

log_info "Use 'docker compose --file $docker_compose_file down --volumes' to remove the devnet"
