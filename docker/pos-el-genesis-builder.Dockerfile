FROM debian:bookworm-slim AS solidity-builder
LABEL description="Solidity builder"
LABEL author="devtools@polygon.technology"

# The solc versions generate-genesis.js compiles with. These old releases ship no
# linux/arm64 binary, so they are built from source on every platform.
# gcc 12 breaks these sources: they build with -Werror, which fails on its new
# warnings, and some headers miss the <limits> include its libstdc++ no longer pulls in.
# The version string ends up in the bytecode metadata hash. An empty prerelease.txt
# drops the build date, and commit_hash.txt skips the dirty tree check that would add
# ".mod" after the -Werror edit, so the bytecode matches the official binaries.
ENV SOLIDITY_VERSIONS="0.5.17 0.6.12"

WORKDIR /opt/solidity
RUN apt-get update \
  && apt-get install --yes cmake g++ git libboost-all-dev make \
  && for version in ${SOLIDITY_VERSIONS}; do \
    git clone --branch "v${version}" --depth 1 https://github.com/ethereum/solidity.git "${version}" \
    && cd "${version}" \
    && touch prerelease.txt \
    && git rev-parse --short=8 HEAD > commit_hash.txt \
    && grep -rl -- '-Werror' cmake CMakeLists.txt | xargs sed -i 's/-Werror//g' \
    && cmake -S . -B build -DUSE_Z3=OFF -DUSE_CVC4=OFF -DTESTS=OFF -DCMAKE_CXX_FLAGS="-include limits" \
    && cmake --build build --target solc --parallel "$(nproc)" \
    && install -D build/solc/solc "/opt/solc/solc-${version}" \
    && cd .. \
    || exit 1; \
  done


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
# between the compilers built above, with no network access at runtime.
COPY --from=solidity-builder /opt/solc/ /opt/solc/
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
