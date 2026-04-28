FROM node:20-slim AS builder
LABEL description="pos-contract-deployer builder"

# pos-contracts - 2025-08-01
ARG POS_CONTRACTS_BRANCH="anvil-pos"
ARG POS_CONTRACTS_TAG_OR_COMMIT_SHA="d96d5929"
# pos-portal - 2025-10-24
ARG POS_PORTAL_BRANCH="master"
ARG POS_PORTAL_TAG_OR_COMMIT_SHA="3402faa"
# spol-contracts - 2026-04-16
ARG SPOL_CONTRACTS_BRANCH="main"
ARG SPOL_CONTRACTS_TAG_OR_COMMIT_SHA="3c4bdf6c"

ENV FOUNDRY_VERSION="stable"
# Baked at image-build time. Custom chain IDs are NOT supported — redeploy with a
# different default here if you genuinely need another L2 chain id.
ENV EL_CHAIN_ID="4927"

RUN apt-get update \
  && apt-get install --no-install-recommends --yes bash ca-certificates curl git g++ jq make python3 \
  && rm -rf /var/lib/apt/lists/* \
  && curl --location --proto "=https" https://foundry.paradigm.xyz --output /tmp/foundry-install.sh \
  && bash /tmp/foundry-install.sh \
  && bash /root/.foundry/bin/foundryup --install ${FOUNDRY_VERSION} \
  && cp /root/.foundry/bin/* /usr/local/bin \
  && rm /tmp/foundry-install.sh

# pos-contracts.
WORKDIR /opt/pos-contracts
RUN git clone --branch ${POS_CONTRACTS_BRANCH} https://github.com/0xPolygon/pos-contracts . \
  && git checkout ${POS_CONTRACTS_TAG_OR_COMMIT_SHA} \
  && git submodule update --init --recursive --depth 1 \
  && find . -name .git -exec rm -rf {} + 2>/dev/null || true \
  && sed -i '/^\[etherscan\]/,/^$/d' foundry.toml \
  && npm install \
  && npm run template:process -- --bor-chain-id ${EL_CHAIN_ID} \
  && npm run generate:interfaces
COPY static_files/contracts/l1/scripts/deployPolAndMigration.s.sol /opt/pos-contracts/scripts/deployment-scripts/deployPolAndMigration.s.sol
COPY static_files/contracts/l1/scripts/deployBurnOnlyPredicates.s.sol /opt/pos-contracts/scripts/deployment-scripts/deployBurnOnlyPredicates.s.sol
RUN forge build

# pos-portal.
WORKDIR /opt/pos-portal
RUN git clone --branch ${POS_PORTAL_BRANCH} https://github.com/maticnetwork/pos-portal . \
  && git checkout ${POS_PORTAL_TAG_OR_COMMIT_SHA} \
  && git submodule update --init --recursive --depth 1 \
  && find . -name .git -exec rm -rf {} + 2>/dev/null || true \
  && npm install \
  && npm run generate:interfaces \
  # Grant our deploy scripts read-write on contractAddresses.json.
  && sed -i 's|fs_permissions = \[|fs_permissions = [{ access = "read-write", path = "./contractAddresses.json" }, |' foundry.toml
COPY static_files/contracts/l1/scripts/deployPosBridgeRoot.s.sol /opt/pos-portal/scripts/deployment-scripts/deployPosBridgeRoot.s.sol
COPY static_files/contracts/l2/scripts/deployPosBridgeChild.s.sol /opt/pos-portal/scripts/deployment-scripts/deployPosBridgeChild.s.sol
RUN forge build

# spol-contracts
WORKDIR /opt/spol-contracts
RUN git clone --branch ${SPOL_CONTRACTS_BRANCH} https://github.com/0xPolygon/spol-contracts . \
  && git checkout ${SPOL_CONTRACTS_TAG_OR_COMMIT_SHA} \
  && rm -rf .git
COPY docker/spol-kurtosis/ script/kurtosis/
RUN forge soldeer install \
  && forge build


FROM debian:bookworm-slim
LABEL description="Polygon PoS contracts deployment image (pos-contracts + pos-portal + spol-contracts)"
LABEL author="devtools@polygon.technology"

RUN apt-get update \
  && apt-get install --no-install-recommends --yes bash ca-certificates curl jq \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bin/forge /usr/local/bin/forge
COPY --from=builder /usr/local/bin/cast /usr/local/bin/cast

# pos-contracts runtime surface: artifacts + contracts + scripts + the one
# node_modules dir whose paths are actually referenced by contracts/. Keeping
# src='contracts' so forge doesn't invalidate its build cache; contracts/ needs
# openzeppelin-solidity (8.4M) to parse — everything else in node_modules is
# dropped.
WORKDIR /opt/pos-contracts
COPY --from=builder /opt/pos-contracts/foundry.toml ./foundry.toml
COPY --from=builder /opt/pos-contracts/lib ./lib
COPY --from=builder /opt/pos-contracts/contracts ./contracts
COPY --from=builder /opt/pos-contracts/scripts ./scripts
COPY --from=builder /opt/pos-contracts/out ./out
COPY --from=builder /opt/pos-contracts/node_modules/openzeppelin-solidity ./node_modules/openzeppelin-solidity
COPY --from=builder /opt/pos-contracts/node_modules/solidity-rlp ./node_modules/solidity-rlp
# Drop the mainnet upgrade migrations — they import extra deps we don't need,
# and we never invoke them from the devnet deploy wrappers.
RUN rm -rf scripts/deployers

# pos-portal runtime surface: same idea, but the deploy scripts only use
# deployCode against pre-built artifacts, so contracts/ isn't needed.
WORKDIR /opt/pos-portal
COPY --from=builder /opt/pos-portal/foundry.toml ./foundry.toml
COPY --from=builder /opt/pos-portal/lib/forge-std ./lib/forge-std
COPY --from=builder /opt/pos-portal/scripts/deployment-scripts ./scripts/deployment-scripts
COPY --from=builder /opt/pos-portal/out ./out

# spol-contracts runtime surface. forge re-resolves remappings at script time,
# so src/, script/, dependencies/ all need to stay. Total: ~21MB. Skip test/,
# broadcast/, audits/ (~3.5MB combined) by not copying them. Keeping cache/
# saves ~3s per deploy at the cost of cosmetic "AST source not found" warnings
# for the test files we deliberately excluded.
WORKDIR /opt/spol-contracts
COPY --from=builder /opt/spol-contracts/foundry.toml ./foundry.toml
COPY --from=builder /opt/spol-contracts/foundry.lock ./foundry.lock
COPY --from=builder /opt/spol-contracts/soldeer.lock ./soldeer.lock
COPY --from=builder /opt/spol-contracts/remappings.txt ./remappings.txt
COPY --from=builder /opt/spol-contracts/src ./src
COPY --from=builder /opt/spol-contracts/script ./script
COPY --from=builder /opt/spol-contracts/dependencies ./dependencies
COPY --from=builder /opt/spol-contracts/out ./out
COPY --from=builder /opt/spol-contracts/cache ./cache

# No default workdir — every wrapper script `cd`s into the right repo itself.
WORKDIR /
