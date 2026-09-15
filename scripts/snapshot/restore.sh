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

  # Each volume lives as an extracted directory under $volume_folder_path
  # (extract.sh produced these inside an alpine container so restrictive
  # modes like `0600` on lighthouse VC's `secrets/` dir are preserved
  # correctly). Pack each directory back into its target docker volume.
  # The pack+unpack happens inside an alpine container as root so we can
  # read the host-owned files (where the user may have edited configs)
  # and write into volumes that expect root-owned content.
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
docker_server_version=$(docker version --format '{{.Server.Version}}' 2> /dev/null || echo "")
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
# Bring everything up detached without --wait. `compose up --wait` aborts the
# moment any service container exits, even if `restart: unless-stopped` will
# bring it back. Some services (heimdall, bor) panic on first boot post-restore
# and self-heal after one or two restarts. Polling for healthy ourselves rides
# through the restart cycle.
docker compose --file "$docker_compose_file" up --detach

# Poll until every healthcheck-bearing service is healthy, or hit the deadline.
wait_deadline=$(($(date +%s) + 120))
all_services=$(docker compose --file "$docker_compose_file" config --services)
log_info "Waiting for services to become healthy (timeout: 120s)"
while :; do
  unhealthy_or_pending=""
  for svc in $all_services; do
    cid=$(docker compose --file "$docker_compose_file" ps --quiet "$svc" 2> /dev/null)
    [[ -z "$cid" ]] && {
      unhealthy_or_pending="$svc(missing)"
      continue
    }
    health=$(docker inspect --format '{{if .State.Health}}{{.State.Health.Status}}{{else}}none{{end}}' "$cid" 2> /dev/null)
    case "$health" in
      healthy | none) ;; # ok — `none` means no healthcheck declared
      *) unhealthy_or_pending="$svc($health)" ;;
    esac
  done
  [[ -z "$unhealthy_or_pending" ]] && break
  if (($(date +%s) >= wait_deadline)); then
    log_error "Timed out waiting for services to become healthy. Still pending: $unhealthy_or_pending"
    exit 1
  fi
  sleep 1
done
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
