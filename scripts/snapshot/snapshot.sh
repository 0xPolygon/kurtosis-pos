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

wait_for_block() {
    local enclave_name="$1"
    local target_block="$2"

    local l2_el_node=$(docker ps --filter "network=kt-$enclave_name" --format "{{.Names}}" | grep l2-el | sort | head -n 1 | awk -F'--' '{print $1}')
    local l2_rpc_url=$(kurtosis port print $enclave_name "$l2_el_node" rpc)
    log_info "Using RPC URL: $l2_rpc_url"

    while true; do
        block_number=$(cast bn --rpc-url "$l2_rpc_url")
        log_info "L2 block: $block_number/$target_block"
        if [[ $block_number -ge $target_block ]]; then
            break
        fi
        sleep 5
    done
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
    mapfile -t CONTAINERS < <(docker ps --all --filter "network=kt-$enclave_name" --format "{{.Names}}" \
        | grep -Ev "kurtosis|files-artifacts-expander|validator-key-generation|read|run|reader|deriver|deployer|generator|monitor")

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

    # Backup volumes using sanitized names
    for v in "${!volume_mapping[@]}"; do
        (
            sanitized_v="${volume_mapping[$v]}"
            echo "$sanitized_v"
            backup_file="$volume_folder_path/$(echo "$sanitized_v" | sed 's/--/_/g').tar.gz"
            docker run --rm \
                -v "$v":/data:ro \
                -v "$volume_folder_path":/backup \
                alpine tar czf /backup/$(basename "$backup_file") -C /data .
        ) &
    done
    wait
}

##############################################################################
# DOCKER COMPOSE GENERATION AND SANITIZATION
##############################################################################

generate_docker_compose() {
    local enclave_name="$1"
    local docker_compose_file="$2"

    # Store container names in an array
    mapfile -t CONTAINERS < <(docker ps --all --filter "network=kt-$enclave_name" --format "{{.Names}}" \
        | grep -Ev "kurtosis|files-artifacts-expander|validator-key-generation|read|run|reader|deriver|deployer|generator|monitor")

    # Generate docker-compose using autocompose.
    # Use array expansion to pass each element as a separate argument
    # Otherwise bash performs word splitting on the result, and since each container name is on its own line
    # (separated by newlines), each becomes a separate argument
    docker_compose_folder="$HOME/Documents/external/os/docker-autocompose"
    pushd "$docker_compose_folder"
    poetry run autocompose "${CONTAINERS[@]}" > "$docker_compose_file"

    # Copy docker-compose to current directory
    popd
    mv "$docker_compose_folder/$docker_compose_file" .
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
    # TODO: Check if we can remove hostnames?
    yq --in-place --yaml-output 'del(.version, .services[].ports, .services[].labels, .services[].logging, .services[].stdin_open, .services[].ipc)' "$docker_compose_file"
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

    # L2: CL depends on RabbitMQ with matching index
    yq --in-place --yaml-output \
        --arg enclave_name "$enclave_name" '
        .services |= with_entries(
            if (.key | test("^" + $enclave_name + "-l2-cl-[0-9]+-")) and (.key | test("rabbitmq") | not) then
                (.key | capture("^" + $enclave_name + "-l2-cl-(?<idx>[0-9]+)-")) as $match |
                .value.depends_on = {($enclave_name + "-l2-cl-" + $match.idx + "-rabbitmq"): {"condition": "service_healthy"}}
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

    # L2 CL (consensus layer) - REST API on port 1317 + (index - 1)
    yq --in-place --yaml-output \
        --arg enclave_name "$enclave_name" '
        .services |= with_entries(
            if (.key | test("^" + $enclave_name + "-l2-cl-[0-9]+-")) and (.key | test("rabbitmq") | not) then
                (.key | capture("^" + $enclave_name + "-l2-cl-(?<idx>[0-9]+)-")) as $match |
                .value.ports = [(($match.idx | tonumber) + 1317 - 1 | tostring) + ":1317"]
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

sanitize_docker_compose() {
    local docker_compose_file="$1"
    configure_networks "$docker_compose_file"
    sanitize_service_names "$docker_compose_file"
    sanitize_volume_names "$docker_compose_file"
    add_network_aliases "$docker_compose_file"
    configure_service_dependencies "$docker_compose_file"
    add_health_checks "$docker_compose_file"
    configure_ports "$docker_compose_file"
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

target_block=50
log_info "Waiting for L2 to reach block $target_block"
wait_for_block "$enclave_name" "$target_block"
log_info "L2 has reached block $target_block"

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

log_info "Generating docker-compose"
docker_compose_file_path="$tmp_dir/docker-compose.yaml"
generate_docker_compose "$enclave_name" "$docker_compose_file_path"
sleep 5 # Wait for file to be fully written before moving it
sanitize_docker_compose "$docker_compose_file_path"
log_info "Docker-compose generated and sanitized"

log_info "Packaging snapshot into docker image"
# Create a Dockerfile
pushd "$tmp_dir"
cat > "Dockerfile" <<'EOF'
FROM scratch
COPY volumes/*.tar.gz /volumes/
COPY docker-compose.yaml /docker-compose.yaml
EOF
# Build the docker image
image_name="pos-devnet"
docker build --tag "$image_name" .
popd
log_info "Snapshot image built: $image_name"

log_info "Cleaning up temporary folder"
rm -rf "$tmp_dir"
log_info "Temporary folder cleaned up"
