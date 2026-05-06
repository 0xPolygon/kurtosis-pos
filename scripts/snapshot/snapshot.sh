#!/usr/bin/env bash
set -euo pipefail

# Source logging library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"

# Snapshot a kurtosis enclave running the ethereum-package.
# The script will generate a docker-compose and snapshot running containers, allowing to restore the devnet in a few seconds.
# WARNING: This script will stop the enclave!

##############################################################################
# UTILITY FUNCTIONS
##############################################################################

# Polls all L2 EL RPC endpoints until every node has reached the target block.
wait_for_rpcs_to_reach_block() {
  local enclave_name="$1"
  local target_block="$2"

  # Get all L2 EL service names (strip UUID suffix)
  mapfile -t l2_el_services < <(docker ps --filter "network=kt-$enclave_name" --format "{{.Names}}" |
    grep l2-el | sort | awk -F'--' '{print $1}')

  # Resolve RPC URLs once — they don't change between checks
  declare -A rpc_urls
  for service in "${l2_el_services[@]}"; do
    rpc_urls[$service]=$(kurtosis port print "$enclave_name" "$service" rpc)
  done

  # Poll each service until all have reached the target block
  local num_steps=50
  for step in $(seq 1 "$num_steps"); do
    log_info "Check ${step}/${num_steps}"
    local all_ready=true
    for service in "${l2_el_services[@]}"; do
      local block_number status
      block_number=$(cast bn --rpc-url "${rpc_urls[$service]}")
      if [[ "$block_number" -lt "$target_block" ]]; then
        status="NOT READY"
        all_ready=false
      else
        status="OK"
      fi
      log_info "- $service: $block_number/$target_block - $status"
    done

    if $all_ready; then
      log_info "All L2 RPCs reached block $target_block"
      return 0
    fi
    log_info "Not all L2 RPCs reached block $target_block, retrying in 10s..."
    sleep 10
  done
  log_error "Not all L2 RPCs reached block $target_block after $num_steps steps"
  return 1
}

##############################################################################
# UTILITY FUNCTIONS
##############################################################################

# List enclave containers, excluding kurtosis internals and ephemeral jobs.
# Usage: get_enclave_containers <enclave_name> [--all]
get_enclave_containers() {
  local enclave_name="$1"
  local extra_args="${2:-}"
  docker ps $extra_args --filter "network=kt-$enclave_name" --format "{{.Names}}" |
    grep -Ev "kurtosis|files-artifacts-expander|validator-key-generation|matic-to-pol-migration|validator-share-upgrade|el-genesis-timestamp|read|run|reader|deriver|deployer|generator|monitor"
}

##############################################################################
# DOCKER VOLUMES BACKUP
##############################################################################

backup_docker_volumes() {
  local enclave_name="$1"
  local volume_folder_path="$2"

  enclave_uuid=$(kurtosis enclave inspect "$enclave_name" --full-uuids | awk '/^UUID:/ {print $2}')
  mkdir -p "$volume_folder_path"

  # Build mapping: original_volume_name -> sanitized_volume_name
  declare -A volume_mapping
  local temp_mounts=$(mktemp)
  trap "rm -f '$temp_mounts'" EXIT

  # Get all containers (including stopped ones) for this enclave
  mapfile -t CONTAINERS < <(get_enclave_containers "$enclave_name" --all)

  # Extract volume mounts from all containers
  for container in "${CONTAINERS[@]}"; do
    # Get container's clean service name (remove UUID suffix)
    clean_service=$(echo "$container" | sed 's/--[a-f0-9]\{32\}$//')

    # Get all volume mounts for this container
    docker inspect "$container" --format '{{json .Mounts}}' | jq -r '.[] | select(.Type == "volume") | "\(.Name)|\(.Destination)"' | while IFS='|' read -r volume_name mount_path; do
      # Determine sanitized volume name based on volume type
      if [[ "$volume_name" == data-* ]]; then
        # L1 pattern: data-X-Y-Z--UUID -> enclave-X-Y-Z-data
        sanitized_name="${enclave_name}-${clean_service}-data"
      elif [[ "$volume_name" =~ -data--[a-f0-9]{32}$ ]]; then
        # L2 pattern: X-Y-Z-data--UUID -> enclave-X-Y-Z-data
        # Remove the UUID suffix to get the base name
        base_name=$(echo "$volume_name" | sed 's/--[a-f0-9]\{32\}$//')
        sanitized_name="${enclave_name}-${base_name}"
      elif [[ "$volume_name" == files-artifact-expansion-* ]]; then
        # files-artifact-expansion--UUID1--UUID2 -> enclave-service-mountpath
        clean_mount=$(echo "$mount_path" | sed 's|^/||' | sed 's|/|-|g')
        sanitized_name="${enclave_name}-${clean_service}-${clean_mount}"
      else
        # Fallback: remove UUID and prefix with enclave name
        base_name=$(echo "$volume_name" | sed 's/--[a-f0-9]\{32\}$//')
        sanitized_name="${enclave_name}-${base_name}"
      fi

      # Store mapping
      echo "${volume_name}|${sanitized_name}" >> "$temp_mounts"
    done
  done

  # Load mappings into associative array
  while IFS='|' read -r original sanitized; do
    volume_mapping["$original"]="$sanitized"
  done < "$temp_mounts"
  rm -f "$temp_mounts"

  # Alpine image pinned by digest so backup output is reproducible across runs.
  # Pull once before the parallel loop to avoid registry rate-limits.
  local alpine_image="alpine@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11"
  if ! docker image inspect "$alpine_image" > /dev/null 2>&1; then
    docker pull "$alpine_image"
  fi

  # Backup volumes using sanitized names.
  # cometBFT's addrbook.json is excluded: it captures peer IPs from the original kurtosis
  # network (172.16.0.x), but after restore the new docker-compose network assigns different
  # IPs (172.18.0.x). Dialing the stale entries fails. cometBFT bootstraps fine from
  # persistent_peers (resolved via Docker DNS aliases) when addrbook is absent.
  for v in "${!volume_mapping[@]}"; do
    (
      sanitized_v="${volume_mapping[$v]}"
      echo "$sanitized_v"
      backup_file="$volume_folder_path/$(echo "$sanitized_v" | sed 's/--/_/g').tar.gz"
      docker run --rm \
        -v "$v":/data:ro \
        -v "$volume_folder_path":/backup \
        "$alpine_image" tar czf /backup/$(basename "$backup_file") --exclude='./addrbook.json' -C /data .
    ) &
  done
  wait

  # The alpine container runs as root, so the tar.gz files are root-owned.
  # Fix ownership so they can be cleaned up without sudo.
  docker run --rm \
    -v "$volume_folder_path":/backup \
    "$alpine_image" chown -R "$(id -u):$(id -g)" /backup
}

##############################################################################
# DOCKER COMPOSE GENERATION AND SANITIZATION
##############################################################################

generate_docker_compose() {
  local enclave_name="$1"
  local docker_compose_file="$2"

  # Store container names in an array
  mapfile -t CONTAINERS < <(get_enclave_containers "$enclave_name" --all)

  # Generate docker-compose using docker-autocompose.
  # Use array expansion to pass each element as a separate argument
  # Otherwise bash performs word splitting on the result, and since each container name is on its own line
  # (separated by newlines), each becomes a separate argument
  docker run --rm \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    ghcr.io/red5d/docker-autocompose@sha256:4d878dbda37b77ec6babea06d398095ff46054b06ee507abbb3f1e71eef2e868 \
    "${CONTAINERS[@]}" > "$docker_compose_file"
}

configure_networks() {
  local docker_compose_file="$1"

  # Replace networks section with single network named after enclave
  yq --in-place --yaml-output \
    --arg new_network "$enclave_name" \
    '.networks = {($new_network): {name: $new_network}}' "$docker_compose_file"

  # Update all service network references to use enclave name
  yq --in-place --yaml-output \
    --arg new_network "$enclave_name" \
    '.services[].networks = [$new_network]' "$docker_compose_file"

  # Remove unnecessary fields from all services
  yq --in-place --yaml-output 'del(.version, .services[].ports, .services[].labels, .services[].logging, .services[].stdin_open, .services[].ipc, .services[].hostname)' "$docker_compose_file"
}

sanitize_service_names() {
  local docker_compose_file="$1"

  # Remove UUID suffixes from service names and add enclave prefix
  yq --in-place --yaml-output \
    --arg enclave_prefix "${enclave_name}-" '
        .services |= (
            to_entries |
            map(.key |= ($enclave_prefix + (. | sub("--[a-f0-9]{32}$"; "")))) |
            from_entries
        )
    ' "$docker_compose_file"

  # Update container_name fields: remove UUID suffix and add enclave prefix
  yq --in-place --yaml-output \
    --arg enclave_prefix "${enclave_name}-" '
        .services[].container_name |= ($enclave_prefix + (. | sub("--[a-f0-9]{32}$"; "")))
    ' "$docker_compose_file"
}

sanitize_volume_names() {
  local docker_compose_file="$1"

  # Remove UUID suffixes from top-level volume names and add enclave prefix
  yq --in-place --yaml-output \
    --arg enclave_prefix "${enclave_name}-" '
        .volumes |= (
            to_entries |
            map(.key |= ($enclave_prefix + (. | sub("--[a-f0-9]{32}$"; "")))) |
            from_entries
        )
    ' "$docker_compose_file"

  # Update volume references in service volume mounts
  yq --in-place --yaml-output \
    --arg enclave_prefix "${enclave_name}-" '
        .services[].volumes[]? |= (
            if contains(":") then
                (split(":") | .[0] |= ($enclave_prefix + (. | sub("--[a-f0-9]{32}$"; "")))) | join(":")
            elif contains("files-artifact-expansion_") then
                sub("files-artifact-expansion_[a-f0-9]{32}_[a-f0-9]{32}"; $enclave_prefix + "files-artifact")
            else
                .
            end
        )
    ' "$docker_compose_file"

  # Rename file-artifact volumes based on service name and mount path
  rename_file_artifact_volumes "$docker_compose_file"

  # Rename L1 data volumes to move -data suffix to end
  rename_data_volumes "$docker_compose_file"

  # Sort volumes alphabetically
  yq --in-place --yaml-output '.volumes = (.volumes | to_entries | sort_by(.key) | from_entries)' "$docker_compose_file"
}

rename_file_artifact_volumes() {
  local docker_compose_file="$1"

  mapping_file=$(mktemp)
  yq '.services | to_entries[] | .key as $service | .value.volumes[]? | select(. | type == "string" and contains("files-artifact-expansion")) | split(":") | "\(.[0])|\($service)|\(.[1])"' "$docker_compose_file" | tr -d '"' > "$mapping_file"

  declare -A volume_mapping
  while IFS='|' read -r old_volume service mount_path; do
    if [[ -n "${volume_mapping[$old_volume]:-}" ]]; then
      continue
    fi
    clean_path=$(echo "$mount_path" | sed 's|^/||' | sed 's|/|-|g')
    new_volume="${service}-${clean_path}"
    volume_mapping["$old_volume"]="$new_volume"
  done < "$mapping_file"

  for old_vol in "${!volume_mapping[@]}"; do
    new_vol="${volume_mapping[$old_vol]}"
    yq --in-place --yaml-output \
      --arg old "$old_vol" \
      --arg new "$new_vol" '
            .volumes = (.volumes | to_entries | map(if .key == $old then {key: $new, value: .value} else . end) | from_entries)
        ' "$docker_compose_file"
    sed -i "s|${old_vol}:|${new_vol}:|g" "$docker_compose_file"
  done
  rm -f "$mapping_file"
}

rename_data_volumes() {
  local docker_compose_file="$1"

  for old_vol in $(yq '.volumes | keys | .[] | select(startswith("'${enclave_name}'-data-"))' "$docker_compose_file" | tr -d '"'); do
    new_vol=$(echo "$old_vol" | sed "s/^${enclave_name}-data-/${enclave_name}-/" | sed 's/$/-data/')
    yq --in-place --yaml-output \
      --arg old "$old_vol" \
      --arg new "$new_vol" '
            .volumes = (.volumes | to_entries | map(if .key == $old then {key: $new, value: .value} else . end) | from_entries)
        ' "$docker_compose_file"
    sed -i "s|${old_vol}:|${new_vol}:|g" "$docker_compose_file"
  done
}

add_network_aliases() {
  local docker_compose_file="$1"

  yq --in-place --yaml-output \
    --arg new_network "$enclave_name" \
    --arg enclave_prefix "${enclave_name}-" '
        .services |= with_entries(
            .value.networks = {
                ($new_network): {
                    aliases: [.key | sub("^" + $enclave_prefix; "")]
                }
            }
        )
    ' "$docker_compose_file"
}

configure_service_dependencies() {
  local docker_compose_file="$1"

  # L2: CL (validator) depends on its paired RabbitMQ.
  # L2: CL (rpc/archive) depends on a validator CL — forces RPCs to start AFTER validators
  # are healthy, so Docker's embedded DNS has registered every l2-cl-* alias by the time
  # cometBFT on the RPC tries to resolve persistent_peers. Without this, RPC nodes hit
  # "server misbehaving" DNS errors at startup, never retry, and stay peerless forever.
  yq --in-place --yaml-output \
    --arg enclave_name "$enclave_name" '
        (.services | keys) as $all_services |
        # Find a reference validator CL (the one paired with rabbitmq-1 if available, else any with a rabbitmq)
        ([$all_services[] | select(test("^" + $enclave_name + "-l2-cl-[0-9]+-") and (test("rabbitmq") | not))
          | . as $cl
          | (capture("^" + $enclave_name + "-l2-cl-(?<idx>[0-9]+)-")) as $m
          | select($all_services | index($enclave_name + "-l2-cl-" + $m.idx + "-rabbitmq"))
         ] | .[0]) as $ref_validator_cl |
        .services |= with_entries(
            if (.key | test("^" + $enclave_name + "-l2-cl-[0-9]+-")) and (.key | test("rabbitmq") | not) then
                (.key | capture("^" + $enclave_name + "-l2-cl-(?<idx>[0-9]+)-")) as $match |
                ($enclave_name + "-l2-cl-" + $match.idx + "-rabbitmq") as $rmq |
                if ($all_services | index($rmq)) then
                    .value.depends_on = {($rmq): {"condition": "service_healthy"}}
                elif $ref_validator_cl != null and .key != $ref_validator_cl then
                    .value.depends_on = {($ref_validator_cl): {"condition": "service_healthy"}}
                else . end
            else . end
        )
    ' "$docker_compose_file"

  # L2: EL depends on CL with matching index
  yq --in-place --yaml-output \
    --arg enclave_name "$enclave_name" '
        (.services | keys) as $all_services |
        .services |= with_entries(
            if .key | test("^" + $enclave_name + "-l2-el-[0-9]+-") then
                (.key | capture("^" + $enclave_name + "-l2-el-(?<idx>[0-9]+)-")) as $match |
                ($all_services[] | select((test("^" + $enclave_name + "-l2-cl-" + $match.idx + "-")) and (test("rabbitmq") | not))) as $cl_service |
                .value.depends_on = {($cl_service): {"condition": "service_healthy"}}
            else . end
        )
    ' "$docker_compose_file"
}

add_health_checks() {
  local docker_compose_file="$1"

  # RabbitMQ health check
  yq --in-place --yaml-output \
    --arg enclave_name "$enclave_name" '
        .services |= with_entries(
            if .key | test("^" + $enclave_name + "-l2-cl-[0-9]+-rabbitmq") then
                .value.healthcheck = {
                    "test": ["CMD", "rabbitmqctl", "status"],
                    "interval": "5s",
                    "timeout": "10s",
                    "retries": 5,
                    "start_period": "10s"
                }
            else . end
        )
    ' "$docker_compose_file"

  # Heimdall health check
  yq --in-place --yaml-output \
    --arg enclave_name "$enclave_name" '
        .services |= with_entries(
            if .key | test("^" + $enclave_name + "-l2-cl-[0-9]+-heimdall") then
                .value.healthcheck = {
                    "test": ["CMD", "wget", "--spider", "-q", "-T", "5", "http://localhost:1317/bor/spans/latest"],
                    "interval": "5s",
                    "timeout": "10s",
                    "retries": 10,
                    "start_period": "20s"
                }
            else . end
        )
    ' "$docker_compose_file"

  # Bor (L2 EL) health check — bor image ships wget but not curl or bash.
  yq --in-place --yaml-output \
    --arg enclave_name "$enclave_name" '
        .services |= with_entries(
            if (.key | test("^" + $enclave_name + "-l2-el-[0-9]+-")) and (.key | test("bor")) then
                .value.healthcheck = {
                    "test": ["CMD-SHELL", "wget --quiet --timeout=5 --post-data=\"{\\\"method\\\":\\\"eth_blockNumber\\\",\\\"params\\\":[],\\\"id\\\":1,\\\"jsonrpc\\\":\\\"2.0\\\"}\" --header=\"Content-Type: application/json\" --output-document=- http://localhost:8545 | grep -q result"],
                    "interval": "5s",
                    "timeout": "10s",
                    "retries": 12,
                    "start_period": "30s"
                }
            else . end
        )
    ' "$docker_compose_file"

  # Erigon (L2 EL) health check — erigon image has bash but no wget/curl, so probe via /dev/tcp.
  # This only verifies the JSON-RPC port is listening, not that it returns valid responses.
  yq --in-place --yaml-output \
    --arg enclave_name "$enclave_name" '
        .services |= with_entries(
            if (.key | test("^" + $enclave_name + "-l2-el-[0-9]+-")) and (.key | test("erigon")) then
                .value.healthcheck = {
                    "test": ["CMD-SHELL", "bash -c \"exec 3<>/dev/tcp/localhost/8545 && exec 3>&-\""],
                    "interval": "5s",
                    "timeout": "10s",
                    "retries": 12,
                    "start_period": "30s"
                }
            else . end
        )
    ' "$docker_compose_file"
}

configure_ports() {
  local docker_compose_file="$1"

  # L1 CL (consensus layer) - beacon API on port 4000 + (index - 1)
  yq --in-place --yaml-output \
    --arg enclave_name "$enclave_name" '
        .services |= with_entries(
            if (.key | test("^" + $enclave_name + "-cl-[0-9]+-")) and (.key | test("-l2-") | not) then
                (.key | capture("^" + $enclave_name + "-cl-(?<idx>[0-9]+)-")) as $match |
                .value.ports = [(($match.idx | tonumber) + 4000 - 1 | tostring) + ":4000"]
            else . end
        )
    ' "$docker_compose_file"

  # L1 EL (execution layer) - JSON-RPC on port 8545 + (index - 1)
  yq --in-place --yaml-output \
    --arg enclave_name "$enclave_name" '
        .services |= with_entries(
            if (.key | test("^" + $enclave_name + "-el-[0-9]+-")) and (.key | test("-l2-") | not) then
                (.key | capture("^" + $enclave_name + "-el-(?<idx>[0-9]+)-")) as $match |
                .value.ports = [(($match.idx | tonumber) + 8545 - 1 | tostring) + ":8545"]
            else . end
        )
    ' "$docker_compose_file"

  # L2 CL (consensus layer) - both the REST API (port 1317) and the cometBFT
  # RPC (port 26657) are mapped to the host. REST is what bridge tests and
  # checkpoint/milestone monitors hit; cometBFT RPC is what the heimdall
  # block-height monitor hits (it parses .result.sync_info.latest_block_height
  # from /status, only available on cometBFT RPC). Each port range is offset
  # by (idx - 1).
  yq --in-place --yaml-output \
    --arg enclave_name "$enclave_name" '
        .services |= with_entries(
            if (.key | test("^" + $enclave_name + "-l2-cl-[0-9]+-")) and (.key | test("rabbitmq") | not) then
                (.key | capture("^" + $enclave_name + "-l2-cl-(?<idx>[0-9]+)-")) as $match |
                .value.ports = [
                    (($match.idx | tonumber) + 1317 - 1 | tostring) + ":1317",
                    (($match.idx | tonumber) + 26657 - 1 | tostring) + ":26657"
                ]
            else . end
        )
    ' "$docker_compose_file"

  # L2 EL (execution layer) - JSON-RPC on port 9545 + (index - 1)
  yq --in-place --yaml-output \
    --arg enclave_name "$enclave_name" '
        .services |= with_entries(
            if .key | test("^" + $enclave_name + "-l2-el-[0-9]+-") then
                (.key | capture("^" + $enclave_name + "-l2-el-(?<idx>[0-9]+)-")) as $match |
                .value.ports = [(($match.idx | tonumber) + 9545 - 1 | tostring) + ":8545"]
            else . end
        )
    ' "$docker_compose_file"
}

# Heimdall RPC/archive containers run init steps (heimdalld init, cp genesis/keys) before heimdalld start.
# These steps fail on a second boot because /tmp/init-data/config/genesis.json already exists.
# After restore, all init outputs already live in /etc/heimdall, so we guard the init prefix on
# whether the restored state file exists. First boot (no state) → init+start; restored boot → start only.
make_heimdall_commands_idempotent() {
  local docker_compose_file="$1"
  yq --in-place --yaml-output '
        .services |= with_entries(
            if (.value.command | type == "array")
               and (.value.command | length == 1)
               and (.value.command[0] | type == "string")
               and (.value.command[0] | test("heimdalld init"))
            then
                (.value.command[0] | capture("(?<start>/usr/local/share/container-proc-manager.sh heimdalld start.*$)").start) as $start_cmd |
                .value.command = [
                    "[ -f /etc/heimdall/data/priv_validator_state.json ] && " + $start_cmd
                    + " || ( " + .value.command[0] + " )"
                ]
            else . end
        )
    ' "$docker_compose_file"
}

# Add restart: on-failure to all services so transient startup races (Docker DNS not yet
# warmed, dependency container still booting) recover automatically instead of leaving
# a dead container that needs manual intervention.
add_restart_policy() {
  local docker_compose_file="$1"
  yq --in-place --yaml-output '.services[] |= (.restart = "on-failure")' "$docker_compose_file"
}

# Strip the Polygon-private GAR cache prefix from image references.
#
# In CI, .github/actions/kurtosis/setup/add-registry-prefix.py rewrites public
# Docker Hub images in constants.star to point at our private GAR "virtual"
# cache (europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/virtual/...)
# to dodge Docker Hub rate-limiting. docker-autocompose then captures those
# rewritten names from the running enclave, so the compose embedded in the
# published snapshot ends up referencing a registry only Polygon engineers
# can pull from. Strip the prefix here so external consumers of the public
# snapshot get plain Docker Hub coordinates.
#
# Only the GAR `virtual/` prefix is stripped — `public/` GAR images and any
# other registry refs are passed through untouched. ghcr.io images that were
# rewritten upstream lose their original ghcr.io/ prefix in the process and
# would resolve to Docker Hub here; this is fine today because the long-lived
# services captured in the snapshot (bor, heimdall, client-go, lighthouse,
# rabbitmq) all originate on Docker Hub. Revisit if a ghcr.io image becomes
# part of the running set.
strip_private_registry_prefix() {
  local docker_compose_file="$1"
  local gar_prefix="europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/virtual/"
  yq --in-place --yaml-output \
    --arg prefix "$gar_prefix" '
        .services[] |= (
            if (.image | startswith($prefix)) then
                .image |= sub("^" + $prefix; "")
            else
                .
            end
        )
    ' "$docker_compose_file"
}

sanitize_docker_compose() {
  local docker_compose_file="$1"
  configure_networks "$docker_compose_file"
  sanitize_service_names "$docker_compose_file"
  sanitize_volume_names "$docker_compose_file"
  add_network_aliases "$docker_compose_file"
  configure_service_dependencies "$docker_compose_file"
  add_health_checks "$docker_compose_file"
  configure_ports "$docker_compose_file"
  make_heimdall_commands_idempotent "$docker_compose_file"
  add_restart_policy "$docker_compose_file"
  strip_private_registry_prefix "$docker_compose_file"
}

##############################################################################
# MAIN WORKFLOW
##############################################################################

default_enclave_name="pos"
enclave_name=${1:-"$default_enclave_name"}
if [[ -z "$enclave_name" ]]; then
  log_error "Enclave name cannot be empty"
  exit 1
fi
log_info "Using enclave name: $enclave_name"

target_block=256 # Rio HF activation block
log_info "Waiting for L2 to reach block $target_block"
wait_for_rpcs_to_reach_block "$enclave_name" "$target_block"

# Wait for heimdall's view of L1 checkpoint acks to catch up with L1's
# actual `currentHeaderBlock`. There's a race window where L1 has emitted
# `NewHeaderBlock(N)` but heimdall's bridge listener hasn't yet polled the
# emitting block, so heimdall's `ack_count` lags L1 by one. Snapshotting
# in that window leaves the restored chain unable to ever observe ack #N
# (the listener resumes from past the emission block and never replays
# old events), permanently breaking checkpoint progression.
wait_for_checkpoint_quiescence() {
  local enclave_name="$1"

  local cl_api_url root_chain_proxy l1_rpc_url cl_service
  # Pick the first L2 CL validator regardless of el/cl flavour or archive suffix.
  # `validator` is a `kind`, so the suffix is always `-validator` or `-validator-archive`.
  cl_service=$(docker ps --filter "network=kt-$enclave_name" --format "{{.Names}}" |
    awk -F'--' '{print $1}' |
    grep -E '^l2-cl-[0-9]+-.*-validator(-archive)?$' |
    sort | head -n1)
  if [[ -z "$cl_service" ]]; then
    log_error "No L2 CL validator service found in enclave '$enclave_name'"
    return 1
  fi
  cl_api_url=$(kurtosis port print "$enclave_name" "$cl_service" http)
  # `l1_backend` chooses between a single-node `anvil` service and the
  # ethereum-package's `el-1-geth-lighthouse`. Both expose `rpc`. Probe
  # the anvil name first; only one of the two services exists in any
  # given enclave.
  l1_rpc_url=$(kurtosis port print "$enclave_name" anvil rpc 2> /dev/null ||
    kurtosis port print "$enclave_name" el-1-geth-lighthouse rpc)
  root_chain_proxy=$(kurtosis files inspect "$enclave_name" pos-contract-addresses contractAddresses.json |
    sed -n '/^{/,$p' | jq -r '.root.RootChainProxy')

  local num_steps=60
  for step in $(seq 1 "$num_steps"); do
    # `currentHeaderBlock()` returns the next-slot id (multiples of
    # ChildChainBlockInterval=10000); divide to get the count of acks on L1.
    local l1_header_block l1_acks heimdall_acks
    l1_header_block=$(cast call --rpc-url "$l1_rpc_url" "$root_chain_proxy" "currentHeaderBlock()(uint256)" 2> /dev/null | head -n 1 | awk '{print $1}')
    l1_acks=$((l1_header_block / 10000))
    heimdall_acks=$(curl -sf "$cl_api_url/checkpoints/count" 2> /dev/null | jq -r '.ack_count // 0')

    log_info "Checkpoint quiescence check ${step}/${num_steps}: L1 acks=${l1_acks}, heimdall ack_count=${heimdall_acks}"
    # The L1 contract counter advances *before* heimdall sees the ack;
    # quiescent means heimdall has caught up to the L1 truth.
    if [[ "${heimdall_acks}" -ge 1 && "${heimdall_acks}" -ge "${l1_acks}" ]]; then
      log_info "Checkpoint flow is quiescent (L1 acks=${l1_acks}, heimdall ack_count=${heimdall_acks})"
      return 0
    fi
    sleep 10
  done
  log_error "Checkpoint flow did not reach quiescence within $num_steps steps"
  return 1
}

log_info "Waiting for heimdall's checkpoint ack_count to catch up with L1"
wait_for_checkpoint_quiescence "$enclave_name"

# Extract kurtosis file artifacts that post-restore e2e tests need.
# `kurtosis files inspect` only works on a live enclave, so we have to grab
# them now and ship them inside the snapshot image alongside the volumes and
# compose. Two artifacts are needed:
#   - pos-contract-addresses/contractAddresses.json: every L1/L2 bridge,
#     predicate, and dummy-token address (used by every bridge/withdraw test).
#   - l2-el-genesis/genesis.json: contains config.bor.stateReceiverContract
#     (L2_STATE_RECEIVER_ADDRESS, used by state-sync helpers).
contract_addresses_tmp=$(mktemp)
l2_genesis_tmp=$(mktemp)
trap "rm -f '$contract_addresses_tmp' '$l2_genesis_tmp'" EXIT
log_info "Extracting kurtosis file artifacts"
# kurtosis files inspect prepends a "File contents:" banner. Strip everything
# before the first '{' and re-format with jq so the output is canonical JSON.
kurtosis files inspect "$enclave_name" pos-contract-addresses contractAddresses.json |
  sed -n '/^{/,$p' | jq . > "$contract_addresses_tmp"
kurtosis files inspect "$enclave_name" l2-el-genesis genesis.json |
  sed -n '/^{/,$p' | jq . > "$l2_genesis_tmp"
log_info "File artifacts extracted (contractAddresses.json: $(wc -c < "$contract_addresses_tmp") bytes, l2-genesis.json: $(wc -c < "$l2_genesis_tmp") bytes)"

# Stop containers in dependency order to avoid app/store divergence:
# 1. L2 CL (heimdall) first — stops block production at consensus layer
# 2. L2 EL (bor/erigon) second — bor flushes its head-pointer atomically with no new blocks arriving
# 3. Everything else last (rabbitmq, L1, vc, init/migration jobs)
# Within each tier, stop in parallel; wait for the tier to fully drain before moving on.
stop_tier() {
  local tier_name="$1"
  shift
  local containers=("$@")
  [[ ${#containers[@]} -eq 0 ]] && return
  log_info "Stopping ${tier_name} (${#containers[@]} containers)"
  for c in "${containers[@]}"; do
    docker stop --timeout=120 "$c" &
  done
  wait
  log_info "${tier_name} stopped"
}

mapfile -t all_containers < <(get_enclave_containers "$enclave_name")

cl_containers=()
el_containers=()
other_containers=()
for c in "${all_containers[@]}"; do
  case "$c" in
    *l2-cl-*heimdall*) cl_containers+=("$c") ;;
    *l2-el-*) el_containers+=("$c") ;;
    *) other_containers+=("$c") ;;
  esac
done

stop_tier "L2 CL (heimdall)" "${cl_containers[@]}"
stop_tier "L2 EL (bor/erigon)" "${el_containers[@]}"
stop_tier "remaining containers" "${other_containers[@]}"
log_info "All containers stopped"

log_info "Stopping the kurtosis enclave"
kurtosis enclave stop "$enclave_name"
log_info "Kurtosis enclave stopped"

# Create a temporary directory to store snapshot data
tmp_dir=$(mktemp -d)
log_info "Created temporary directory: $tmp_dir"

log_info "Backing up docker volumes"
volume_folder_path="$tmp_dir/volumes"
backup_docker_volumes "$enclave_name" "$volume_folder_path"
log_info "Backups completed"

# Move the previously-extracted file artifacts into the snapshot tree.
mv "$contract_addresses_tmp" "$tmp_dir/contractAddresses.json"
mv "$l2_genesis_tmp" "$tmp_dir/l2-genesis.json"

log_info "Generating docker-compose"
docker_compose_file_path="$tmp_dir/docker-compose.yaml"
generate_docker_compose "$enclave_name" "$docker_compose_file_path"
sleep 5 # Wait for file to be fully written before moving it
sanitize_docker_compose "$docker_compose_file_path"
log_info "Docker-compose generated and sanitized"

log_info "Packaging snapshot into docker image"
# Create a Dockerfile
pushd "$tmp_dir"
cat > "Dockerfile" << 'EOF'
FROM scratch
COPY volumes/*.tar.gz /volumes/
COPY docker-compose.yaml /docker-compose.yaml
COPY contractAddresses.json /contractAddresses.json
COPY l2-genesis.json /l2-genesis.json
EOF
# Build the docker image
image_name="pos-devnet"
docker build --tag "$image_name" .
popd
log_info "Snapshot image built: $image_name"

log_info "Cleaning up temporary folder"
rm -rf "$tmp_dir"
log_info "Temporary folder cleaned up"
