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
  # The volumes already exist at this point (`docker compose create`). Creating
  # one here for a folder compose does not declare would leave an unlabelled
  # volume that `down --volumes` never removes.
  for d in "$volume_folder_path"/*/; do
    [[ -d "$d" ]] || continue
    volume_name=$(basename "$d" | sed 's/_/--/g')
    if ! jq -e --arg v "$volume_name" 'any(.[]; .name == $v)' <<< "$compose_volumes_json" > /dev/null; then
      log_warn "Skipping folder $(basename "$d"): no volume '$volume_name' in the compose file"
      continue
    fi
    (
      echo "$volume_name"
      docker run --rm \
        -v "$volume_name":/data \
        -v "$(realpath "$d")":/backup \
        "$ALPINE_IMAGE" sh -c "cd /backup && tar cf - . | tar xf - -C /data"
    ) &
  done

  wait
}

##############################################################################
# L1 LIVENESS
##############################################################################

# Print the `result` field of one JSON-RPC call, or nothing if the node does
# not answer. Never fails, so callers under `set -e` can poll a node that is
# still starting.
l1_rpc() {
  local url="$1" method="$2" params="$3"
  curl --silent --fail --max-time 2 --header "Content-Type: application/json" \
    --data "{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"$method\",\"params\":$params}" "$url" 2> /dev/null |
    jq -r '.result // empty' 2> /dev/null || true
}

# The L1 services carry no healthcheck, so "Devnet started" says nothing about
# whether L1 produces blocks. A geth + lighthouse snapshot restored long after
# it was built does not: its beacon chain keeps the genesis time it was built
# with, and a lone lighthouse with no peers never counts itself synced once the
# wall clock is far ahead of its head slot, so it never proposes. bor and
# heimdall still come up healthy and the devnet looks fine until the first
# checkpoint or bridge call hangs. Fail fast instead, with the way out.
# The check is backend-agnostic (the head must advance), so a healthy anvil L1
# with 1 s blocks passes within seconds and any other stuck L1 is caught too.
wait_for_l1_progress() {
  local docker_compose_file="$1"
  local timeout=90

  if [[ "${POS_DEVNET_SKIP_L1_CHECK:-}" == "1" ]]; then
    log_warn "POS_DEVNET_SKIP_L1_CHECK=1: not checking that L1 produces blocks"
    return 0
  fi

  # The L1 JSON-RPC service: anvil, or the first L1 EL node (snapshot.sh binds
  # `-el-N-` services that are not `-l2-` to host 8545 + N - 1). Read the host
  # port compose actually bound rather than assuming 8545: the published ports
  # may have been rewritten to avoid a collision.
  local l1_service
  l1_service=$(docker compose --file "$docker_compose_file" config --format json |
    jq -r '.services | keys[] | select(test("-anvil$") or (test("-el-1-") and (test("-l2-") | not)))' | head -n 1)
  if [[ -z "$l1_service" ]]; then
    log_warn "No L1 JSON-RPC service found in $docker_compose_file: not checking that L1 produces blocks"
    return 0
  fi
  local host_port
  host_port=$(docker compose --file "$docker_compose_file" port "$l1_service" 8545 2> /dev/null || true)
  host_port="${host_port##*:}"
  if [[ -z "$host_port" ]]; then
    log_warn "Service $l1_service publishes no host port for 8545: not checking that L1 produces blocks"
    return 0
  fi
  local l1_url="http://127.0.0.1:${host_port}"

  log_info "Waiting for L1 to produce a block (service: $l1_service, rpc: $l1_url, timeout: ${timeout}s)"
  local deadline=$(($(date +%s) + timeout))
  local first="" current="" reply=""
  while (($(date +%s) < deadline)); do
    reply=$(l1_rpc "$l1_url" eth_blockNumber "[]")
    if [[ -n "$reply" ]]; then
      current="$reply"
      if [[ -z "$first" ]]; then
        first="$current"
      elif ((current > first)); then
        log_info "L1 is advancing (block $((first)) → $((current)))"
        return 0
      fi
    fi
    sleep 2
  done

  local head_line
  local head_timestamp
  head_timestamp=$(l1_rpc "$l1_url" eth_getBlockByNumber '["latest",false]' | jq -r '.timestamp // empty' 2> /dev/null || true)
  if [[ -n "$current" && -n "$head_timestamp" ]]; then
    local age=$(($(date +%s) - head_timestamp))
    head_line="L1 head block $((current)) is $((age / 3600))h $((age % 3600 / 60))m old and did not advance in ${timeout}s"
  else
    head_line="L1 at $l1_url did not answer eth_blockNumber/eth_getBlockByNumber within ${timeout}s, so its head is unknown"
  fi
  log_error "$head_line"
  if [[ "$l1_service" != *-anvil ]]; then
    log_error "With the geth + lighthouse L1: these snapshots carry their beacon genesis time; a lone lighthouse with no peers never counts itself synced once the wall clock is far ahead, so it never proposes; these snapshots only restore within minutes of being built."
    log_error "Use the pos-devnet-<size>:<tag>-anvil image, which has no slot clock, or set POS_DEVNET_SKIP_L1_CHECK=1 to keep this devnet up anyway."
  else
    log_error "Check the $l1_service logs (docker compose --file $docker_compose_file logs $l1_service), or set POS_DEVNET_SKIP_L1_CHECK=1 to keep this devnet up anyway."
  fi
  exit 1
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

docker_compose_file="$snapshot_folder/docker-compose.yaml"
compose_volumes_json=$(docker compose --file "$docker_compose_file" config --format json | jq -c '[.volumes // {} | .[] | {name, external: (.external // false)}]')

# Volumes are unpacked over whatever they already hold, so a leftover volume
# from a previous devnet would mix its data into this one.
mapfile -t existing_volumes < <(jq -r '.[].name' <<< "$compose_volumes_json" |
  while read -r v; do docker volume inspect "$v" > /dev/null 2>&1 && echo "$v"; done)
if [[ ${#existing_volumes[@]} -gt 0 ]]; then
  log_error "${#existing_volumes[@]} volumes of this devnet already exist (e.g. ${existing_volumes[0]})"
  log_error "Remove the previous devnet first: docker compose --file $docker_compose_file down --volumes"
  log_error "Volumes of snapshots built before compose managed them are not removed by that; delete them with: docker volume rm <name>"
  exit 1
fi

# Seed the anvil L1 backend's captured state. snapshot.sh baked the live
# post-deploy anvil state (captured via the `anvil_dumpState` RPC) into the
# image as /anvil-state.hex, which extract.sh wrote out to the snapshot folder.
# anvil's own `--dump-state` writes only on SIGINT (not the SIGTERM the stop
# sequence sends), so the on-disk state isn't otherwise captured. Decode it into
# the `/opt/anvil/genesis.json` that anvil boots with `--load-state`, before the
# volumes are restored, rather than replaying it over RPC after start-up:
# - anvil caps HTTP request bodies at 2 MiB, and a devnet's state dump outgrows
#   that (anvil_loadState then fails with -32600 before the body is parsed).
# - heimdall and bor come up against an L1 that already has the deployed
#   contracts, instead of a genesis-only L1 until the replay lands.
# The file is present only for anvil-backend snapshots; absent under the
# ethereum-package backend, where this is a no-op.
anvil_state_file="$snapshot_folder/anvil-state.hex"
if [[ -s "$anvil_state_file" ]]; then
  anvil_volume=$(docker compose --file "$docker_compose_file" config --format json |
    jq -r '[.services[].volumes[]? | select(.target == "/opt/anvil") | .source] | first // empty')
  # restore_docker_volumes maps a folder name to its volume by `_` -> `--`.
  anvil_volume_dir="$snapshot_folder/volumes/${anvil_volume//--/_}"
  if [[ -z "$anvil_volume" || ! -d "$anvil_volume_dir" ]]; then
    log_error "Could not find the snapshot volume mounted at /opt/anvil (volume: '${anvil_volume}')"
    exit 1
  fi
  log_info "Seeding captured anvil state into ${anvil_volume}:/opt/anvil/genesis.json"
  # The dump is hex-encoded gzipped JSON, the same state format `--load-state`
  # reads. Decode inside alpine: the extracted volume folder is root-owned.
  docker run --rm \
    -v "$(realpath "$anvil_volume_dir")":/data \
    -v "$(realpath "$anvil_state_file")":/anvil-state.hex:ro \
    "$ALPINE_IMAGE" sh -c 'tr -d "[:space:]" < /anvil-state.hex | sed "s/^0x//" | xxd -r -p | gunzip > /data/genesis.json'
fi

log_info "Creating devnet containers and volumes"
# Snapshots built before compose managed the volumes declare them `external`.
jq -r '.[] | select(.external) | .name' <<< "$compose_volumes_json" |
  while read -r v; do docker volume create "$v" > /dev/null; done
docker compose --file "$docker_compose_file" create

log_info "Restoring docker volumes"
volume_folder_path="$(realpath "$snapshot_folder/volumes")"
restore_docker_volumes "$volume_folder_path"
log_info "Docker volumes restored"

log_info "Starting devnet using docker-compose"
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

# Printed before the L1 check so it is on screen when the check fails: the
# containers are left up for inspection.
log_info "Use 'docker compose --file $docker_compose_file down --volumes' to remove the devnet"

wait_for_l1_progress "$docker_compose_file"
