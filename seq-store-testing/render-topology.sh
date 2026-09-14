#!/usr/bin/env bash
# Render topology.d2 to SVG and PNG with the official d2 image; no local install.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
d2() {
  docker run --rm -u "$(id -u):$(id -g)" -v "$PWD":/work -w /work terrastruct/d2 \
    --layout elk "$@"
}
d2 topology.d2 topology.svg
d2 topology.d2 topology.png
echo "wrote $PWD/topology.svg and topology.png"
