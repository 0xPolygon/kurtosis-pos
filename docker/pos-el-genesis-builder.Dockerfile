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

# 13/03/2025
ARG GENESIS_CONTRACTS_BRANCH="master"
ARG GENESIS_CONTRACTS_TAG_OR_COMMIT_SHA="244bc6a"

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
  && git clone --branch ${GENESIS_CONTRACTS_BRANCH} https://github.com/maticnetwork/genesis-contracts.git . \
  && git checkout ${GENESIS_CONTRACTS_TAG_OR_COMMIT_SHA} \
  # Delete the StateReceiver contract because it is based on solc 0.6.12 and the rest of the contracts
  # use solc 0.5.17. It is not important because it is not needed to generate the EL genesis.
  && rm contracts/StateReceiver.sol \
  # Remove the use of solc-select inside generate-genesis.js as it is not needed.
  && sed -i 's/solc-select use ${solcVersion} \&\& //' generate-genesis.js \
  # Remove the compilation of the StateReceiver contract.
  && sed -i '/\[/{N;N;N;N;/borStateReceiverContract/{N;d;};}' generate-genesis.js \
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
