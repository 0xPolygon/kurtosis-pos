#!/usr/bin/env bash
set -euo pipefail

# Source logging library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"

# Alpine image pinned by digest so the extract tooling is reproducible and
# not affected by an upstream `alpine:latest` rebase. Must match restore.sh.
ALPINE_IMAGE="alpine@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11"

# Parse arguments
image_name="${1:-""}"
if [[ -z "$image_name" ]]; then
  log_error "Image name is required"
  exit 1
fi
log_info "Using image: $image_name"

default_output_dir="./tmp"
output_dir="${2:-$default_output_dir}"
if [[ -z "$output_dir" ]]; then
  log_error "Output directory is required"
  exit 1
fi
log_info "Using output directory: $output_dir"

# Create output directory
mkdir -p "$output_dir"
volume_folder_path="$output_dir/volumes"
mkdir -p "$volume_folder_path"

# Create a temporary container from the snapshot image to copy files out
log_info "Downloading snapshot files from image"
container_id=$(docker create "$image_name" /bin/true)
docker cp "$container_id:/volumes/." "$volume_folder_path/"
docker cp "$container_id:/docker-compose.yaml" "$output_dir/docker-compose.yaml"
docker cp "$container_id:/contractAddresses.json" "$output_dir/contractAddresses.json"
docker cp "$container_id:/l2-genesis.json" "$output_dir/l2-genesis.json"
log_info "Files downloaded to $output_dir"

docker rm "$container_id" > /dev/null
log_info "Temporary container removed"

# Extract each `.tar.gz` into its own directory under $volume_folder_path/.
# Run the extraction inside an alpine container so it executes as root: the
# archives include directories with modes like `0600` (no execute bit) — on
# the lighthouse VC's `secrets/` dir — and host-side tar as a non-root user
# would silently fail to write files into them, corrupting the validator's
# keystore/secret pairing.
log_info "Extracting volume archives"
abs_volume_folder_path="$(realpath "$volume_folder_path")"
for f in "$volume_folder_path"/*.tar.gz; do
  (
    name=$(basename "$f" .tar.gz)
    mkdir -p "$volume_folder_path/$name"
    docker run --rm \
      -v "$abs_volume_folder_path":/backup \
      -v "$abs_volume_folder_path/$name":/out \
      "$ALPINE_IMAGE" sh -c "tar xzf /backup/$(basename "$f") -C /out && chown -R $(id -u):$(id -g) /out"
    log_info "Extracted: $name"
    rm "$f"
  ) &
done
wait
log_info "Snapshot extracted to $output_dir"
