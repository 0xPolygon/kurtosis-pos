# Compilers built once by pos-solc.Dockerfile and published by publish-images.yaml.
ARG POS_SOLC_IMAGE="ghcr.io/0xpolygon/pos-solc:0.0.1"
FROM ${POS_SOLC_IMAGE} AS solc


FROM node:26.12.1-bookworm
LABEL description="MATIC (Polygon PoS) EL genesis builder image"
LABEL author="devtools@polygon.technology"

ARG GENESIS_CONTRACTS_BRANCH="master"
ARG GENESIS_CONTRACTS_TAG_OR_COMMIT_SHA="5c006e2"

# Chain ids are baked into the image at build time: the matic-contracts
# ChainIdMixin template is rendered with EL_CHAIN_ID, and the genesis is
# generated once with EL_CHAIN_ID and CL_CHAIN_ID to check that every contract
# compiles. The compiled bytecode ends up in the L2 genesis alloc.
# Custom chain ids at runtime are NOT supported — to change them, rebuild
# this image with different EL_CHAIN_ID / CL_CHAIN_ID build args.
ENV EL_CHAIN_ID="4927"
ENV CL_CHAIN_ID="heimdall-4927"

# generate-genesis.js compiles each contract with `solc-select use <version> && solc ...`.
# solc-select would download amd64-only binaries, so this stand-in switches `solc`
# between the compilers of the pos-solc image, with no network access at runtime.
COPY --from=solc /opt/solc/ /opt/solc/
RUN printf '%s\n' \
    '#!/bin/sh' \
    'set -eu' \
    'if [ "${1:-}" != "use" ] || [ ! -x "/opt/solc/solc-${2:-}" ]; then' \
    '  echo "usage: solc-select use <version>, available: $(ls /opt/solc | sed s/solc-// | tr "\\n" " ")" >&2' \
    '  exit 1' \
    'fi' \
    'ln -sf "/opt/solc/solc-$2" /usr/local/bin/solc' \
    > /usr/local/bin/solc-select \
  && chmod +x /usr/local/bin/solc-select

# Prepare environment to build MATIC genesis file.
# Only the matic-contracts submodule is needed: the other ones hold the foundry
# test and gas oracle dependencies, which generate-genesis.js does not compile.
WORKDIR /opt/genesis-contracts
RUN apt-get update \
  && apt-get install --no-install-recommends --yes jq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && git clone --branch ${GENESIS_CONTRACTS_BRANCH} https://github.com/0xPolygon/genesis-contracts.git . \
  && git checkout ${GENESIS_CONTRACTS_TAG_OR_COMMIT_SHA} \
  && git submodule update --init matic-contracts \
  && npm install \
  && cd matic-contracts \
  && npm install \
  && npm run template:process -- --bor-chain-id ${EL_CHAIN_ID} \
  && cd .. \
  && node generate-genesis.js --bor-chain-id ${EL_CHAIN_ID} --heimdall-chain-id ${CL_CHAIN_ID} \
  && rm genesis.json
