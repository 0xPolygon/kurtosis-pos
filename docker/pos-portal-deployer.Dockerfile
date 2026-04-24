# ---- builder: clone pos-portal, install node deps, forge build ---------------
FROM node:20-slim AS builder
LABEL description="pos-portal deployer builder"

# pos-portal is low-churn (1 contract commit in 2025); pinning to a known-good revision.
ARG POS_PORTAL_BRANCH="master"
ARG POS_PORTAL_TAG_OR_COMMIT_SHA="3402faa"

ENV FOUNDRY_VERSION="stable"

WORKDIR /opt/pos-portal
RUN apt-get update \
  && apt-get install --no-install-recommends --yes bash ca-certificates curl git g++ make python3 \
  && rm -rf /var/lib/apt/lists/* \
  && curl --location --proto "=https" https://foundry.paradigm.xyz --output /tmp/foundry-install.sh \
  && bash /tmp/foundry-install.sh \
  && bash /root/.foundry/bin/foundryup --install ${FOUNDRY_VERSION} \
  && cp /root/.foundry/bin/* /usr/local/bin \
  && rm /tmp/foundry-install.sh \
  && git clone --branch ${POS_PORTAL_BRANCH} https://github.com/maticnetwork/pos-portal . \
  && git checkout ${POS_PORTAL_TAG_OR_COMMIT_SHA} \
  && git submodule update --init --recursive --depth 1 \
  && find . -name .git -exec rm -rf {} + 2>/dev/null || true \
  && npm install \
  && npm run generate:interfaces \
  # Grant our deploy scripts read-write on contractAddresses.json.
  && sed -i 's|fs_permissions = \[|fs_permissions = [{ access = "read-write", path = "./contractAddresses.json" }, |' foundry.toml \
  && forge build

# ---- runtime: forge/cast + compiled artifacts + deploy scripts ---------------
FROM debian:bookworm-slim
LABEL description="Polygon PoS bridge (pos-portal) deployment image"
LABEL author="devtools@polygon.technology"

RUN apt-get update \
  && apt-get install --no-install-recommends --yes bash ca-certificates curl jq \
  && rm -rf /var/lib/apt/lists/*

# Foundry binaries required at runtime (forge for script, cast for the cross-chain wiring).
COPY --from=builder /usr/local/bin/forge /usr/local/bin/forge
COPY --from=builder /usr/local/bin/cast /usr/local/bin/cast

# Minimum project surface required for `forge script` to compile the .s.sol wrappers and
# execute `deployCode` against the pre-built artifacts. No contracts/ sources, no
# node_modules — everything needed already lives in out/.
WORKDIR /opt/pos-portal
COPY --from=builder /opt/pos-portal/foundry.toml ./foundry.toml
COPY --from=builder /opt/pos-portal/lib/forge-std ./lib/forge-std
COPY --from=builder /opt/pos-portal/out ./out

# Orchestration scripts (forge deploy scripts + bash wrappers).
RUN mkdir -p scripts/deployment-scripts
COPY static_files/contracts/deployPosPortalRoot.s.sol scripts/deployment-scripts/deployPosPortalRoot.s.sol
COPY static_files/contracts/deployPosPortalChild.s.sol scripts/deployment-scripts/deployPosPortalChild.s.sol
