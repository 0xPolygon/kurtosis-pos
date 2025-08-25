FROM debian:bullseye-slim AS soldity-builder
LABEL description="Solidity builder"
LABEL author="devtools@polygon.technology"

WORKDIR /opt/solidity
RUN apt-get update \
  && apt-get install --yes cmake cvc4 gcc g++ git libboost-all-dev z3 \
  && git clone --branch v0.5.17 --depth 1 https://github.com/ethereum/solidity.git . \
  && mkdir build \
  && cd build \
  && cmake .. \
  && make


FROM node:16-bookworm
LABEL description="MATIC (Polygon PoS) EL genesis builder image"
LABEL author="devtools@polygon.technology"

ARG GENESIS_CONTRACTS_BRANCH="master"
ARG GENESIS_CONTRACTS_TAG_OR_COMMIT_SHA="96a19dd"
# Note: We do not use the latest version of the genesis contracts, `244bc6a`, released on 2025/03/13,
# because it introduces a breaking change. The `StateReceiver` contract requires solc `0.6.12`,
# while all other contracts still rely on solc `0.5.17`.
# As a result, when generating the EL genesis, it attempts to compile all the contracts,
# including the `StateReceiver`. Since we only install solc `0.5.17` in the `pos-el-genesis-builder`
# image, the compilation fails. Removing the compilation of the `StateReceiver` contract does not
# work because the EL genesis alloc section will be incorrect for contract
# `0000000000000000000000000000000000001001`, as the code will be `0x`. Therefore, we opted to use
# a previous version, `96a19dd`, released on 2025/01/08.

ENV TRUFFLE_VERSION="5.11.5"
ENV DEFAULT_EL_CHAIN_ID="4927"
ENV DEFAULT_CL_CHAIN_ID="heimdall-4927"

COPY --from=soldity-builder /opt/solidity/build/solc /usr/local/bin/

# Prepare environment to build MATIC genesis file.
WORKDIR /opt/genesis-contracts
RUN apt-get update \
  && apt-get install --no-install-recommends --yes jq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && npm install --global truffle@${TRUFFLE_VERSION} \
  && git clone --branch ${GENESIS_CONTRACTS_BRANCH} https://github.com/0xPolygon/genesis-contracts.git . \
  && git checkout ${GENESIS_CONTRACTS_TAG_OR_COMMIT_SHA} \
  && git submodule init \
  && git submodule update \
  && npm install \
  && cd matic-contracts \
  && npm install \
  && npm run template:process -- --bor-chain-id ${DEFAULT_EL_CHAIN_ID} \
  && truffle compile \
  && cd .. \
  && node generate-borvalidatorset.js --bor-chain-id ${DEFAULT_EL_CHAIN_ID} --heimdall-chain-id ${DEFAULT_CL_CHAIN_ID} \
  && truffle compile
