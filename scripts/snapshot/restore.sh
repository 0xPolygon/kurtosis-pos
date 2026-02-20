#!/usr/bin/env bash
set -euo pipefail

# Source logging library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"

# Restore a PoS devnet from a kurtosis-pos snapshot.

##############################################################################
# DOCKER VOLUMES RESTORE
############################################################################

restore_docker_volumes() {
    local volume_folder_path="$1"

    # Restore from archives (.tar.gz)
    for v in "$volume_folder_path"/*.tar.gz; do
        [[ -f "$v" ]] || continue
        (
            volume_name=$(basename "$v" .tar.gz | sed 's/_/--/g')
            echo "$volume_name"
            docker volume create "$volume_name" >/dev/null
            docker run --rm \
                -v "$volume_name":/data \
                -v "$volume_folder_path":/backup \
                alpine tar xzf /backup/$(basename "$v") -C /data
        ) &
    done

    # Restore from directories
    for d in "$volume_folder_path"/*/; do
        [[ -d "$d" ]] || continue
        (
            volume_name=$(basename "$d" | sed 's/_/--/g')
            echo "$volume_name"
            docker volume create "$volume_name" >/dev/null
            docker run --rm \
                -v "$volume_name":/data \
                -v "$(realpath "$d")":/backup \
                alpine sh -c "cd /backup && tar cf - . | tar xf - -C /data"
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
docker compose --file "$docker_compose_file" up --detach
log_info "Devnet started"

log_info "Use 'docker compose --file $docker_compose_file down --volumes' to remove the devnet"
