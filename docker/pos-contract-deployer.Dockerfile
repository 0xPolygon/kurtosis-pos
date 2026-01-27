FROM node:20-slim
LABEL description="Polygon PoS contracts deployment image"
LABEL author="devtools@polygon.technology"

ARG POS_CONTRACTS_BRANCH="anvil-pos"
ARG POS_CONTRACTS_TAG_OR_COMMIT_SHA="d96d592"

ENV FOUNDRY_VERSION="stable"
ENV DEFAULT_EL_CHAIN_ID="4927"

# Prepare Polygon PoS smart contracts for deployment by compiling them
# For reference: https://github.com/0xPolygon/pos-contracts
WORKDIR /opt/pos-contracts
RUN apt-get update \
  # Install dependencies
  && apt-get install --no-install-recommends --yes bash ca-certificates curl git jq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  # Install foundry
  && curl --location --proto "=https" https://foundry.paradigm.xyz --output /tmp/foundry-install.sh \
  && bash /tmp/foundry-install.sh \
  && bash /root/.foundry/bin/foundryup --install ${FOUNDRY_VERSION} \
  && cp /root/.foundry/bin/* /usr/local/bin \
  && rm /tmp/foundry-install.sh \
  # Prepare pos contracts (shallow clone with submodules)
  && git clone --branch ${POS_CONTRACTS_BRANCH} --depth 1 --recurse-submodules --shallow-submodules https://github.com/0xPolygon/pos-contracts . \
  && git checkout ${POS_CONTRACTS_TAG_OR_COMMIT_SHA} \
  && find . -name .git -exec rm -rf {} + 2>/dev/null || true \
  # Remove [etherscan] section from foundry.toml
  && sed -i '/^\[etherscan\]/,/^$/d' foundry.toml \
  # Pre-build for default chain ID (most common case)
  && npm install \
  && npm run template:process -- --bor-chain-id ${DEFAULT_EL_CHAIN_ID} \
  && npm run generate:interfaces \
  && forge build \
  # Clean up to reduce image size while keeping dependencies needed for forge script
  && npm prune --production \
  && npm cache clean --force
