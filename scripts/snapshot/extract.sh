#!/usr/bin/env bash
set -euo pipefail

# Source logging library
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/log.sh"

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
log_info "Files downloaded to $output_dir"

docker rm "$container_id" > /dev/null
log_info "Temporary container removed"

# Extract all volume archives in parallel
log_info "Extracting volume archives"
for f in "$volume_folder_path"/*.tar.gz; do
  (
    name=$(basename "$f" .tar.gz)
    mkdir -p "$volume_folder_path/$name"
    tar -xzf "$f" -C "$volume_folder_path/$name" --no-same-owner
    log_info "Extracted: $name"
    rm "$f"
  ) &
done
wait
log_info "Snapshot extracted to $output_dir"
