FROM node:20-slim
LABEL description="Polygon sPOL (LST) contracts deployment image"
LABEL author="devtools@polygon.technology"

ARG SPOL_CONTRACTS_BRANCH="main"
ARG SPOL_CONTRACTS_TAG_OR_COMMIT_SHA="main"

ENV FOUNDRY_VERSION="stable"

# Prepare Polygon sPOL smart contracts for deployment by compiling them
# For reference: https://github.com/0xPolygon/spol-contracts
WORKDIR /opt/spol-contracts
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
  # Prepare spol contracts (shallow clone at pinned ref)
  && git clone --branch ${SPOL_CONTRACTS_BRANCH} --depth 1 https://github.com/0xPolygon/spol-contracts . \
  && git checkout ${SPOL_CONTRACTS_TAG_OR_COMMIT_SHA} \
  && find . -name .git -exec rm -rf {} + 2>/dev/null || true

# Overlay kurtosis-specific mocks and validator-setup script into script/mock/.
# These files compile alongside the upstream sPOL source during the forge build below,
# and are referenced by name at deploy time by deploy-lst-contracts.sh in kurtosis-pos.
COPY spol-mocks/ script/mock/

# Pre-install soldeer deps and compile so the runtime container only needs to run
# the deploy scripts — no cold forge build on every kurtosis run.
RUN forge soldeer install \
  && forge build
