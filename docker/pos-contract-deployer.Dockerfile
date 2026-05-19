FROM node:26-slim AS builder
LABEL description="pos-contract-deployer builder"

# pos-contracts (anvil-pos) - 2025-08-01
# Used for the Plasma bridge, RootChain, MaticToken, MATIC→POL migration, and
# the rest of the deployable PoS surface. Pinned to a SHA that is stable for
# the bridge contracts and that matches the cl-el-genesis baked into kurtosis.
ARG POS_CONTRACTS_ANVIL_POS_BRANCH="anvil-pos"
ARG POS_CONTRACTS_ANVIL_POS_TAG_OR_COMMIT_SHA="d96d5929"
# pos-contracts (main) - 2026-03-12
# Used to compile only the upgraded ValidatorShare implementation. Mainnet runs
# this version (registered via Registry.contractMap['validatorShare']); without
# the bump, sPOL's `restakeAndStakePOL(uint256)` call into ValidatorShare
# reverts because anvil-pos hasn't merged that feature yet (it landed on main
# in commit 24a81a5fe9 / 2025-10-27). We deploy the new impl alongside and
# flip the Registry entry — same upgrade path mainnet took.
ARG POS_CONTRACTS_MAIN_BRANCH="main"
ARG POS_CONTRACTS_MAIN_TAG_OR_COMMIT_SHA="935dee17"
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

# pos-contracts (anvil-pos).
WORKDIR /opt/pos-contracts-anvil-pos
RUN git clone --branch ${POS_CONTRACTS_ANVIL_POS_BRANCH} https://github.com/0xPolygon/pos-contracts . \
  && git checkout ${POS_CONTRACTS_ANVIL_POS_TAG_OR_COMMIT_SHA} \
  && git submodule update --init --recursive --depth 1 \
  && find . -name .git -exec rm -rf {} + 2>/dev/null || true \
  && sed -i '/^\[etherscan\]/,/^$/d' foundry.toml \
  && npm install \
  && npm run template:process -- --bor-chain-id ${EL_CHAIN_ID} \
  && npm run generate:interfaces
COPY static_files/contracts/l1/scripts/deployPolAndMigration.s.sol /opt/pos-contracts-anvil-pos/scripts/deployment-scripts/deployPolAndMigration.s.sol
COPY static_files/contracts/l1/scripts/deployBurnOnlyPredicates.s.sol /opt/pos-contracts-anvil-pos/scripts/deployment-scripts/deployBurnOnlyPredicates.s.sol
RUN forge build

# pos-contracts (main) — only used for the ValidatorShare upgrade. We do a
# fresh clone instead of overlaying the file on top of anvil-pos because the
# new ValidatorShare pulls in deps that anvil-pos doesn't carry (IERC20Permit,
# updated IValidatorShare interface, etc.). Storage layout is forward-compatible
# with the old ValidatorShare — every existing slot keeps its meaning, EIP-712
# storage is appended at the end.
WORKDIR /opt/pos-contracts-main
RUN git clone --branch ${POS_CONTRACTS_MAIN_BRANCH} https://github.com/0xPolygon/pos-contracts . \
  && git checkout ${POS_CONTRACTS_MAIN_TAG_OR_COMMIT_SHA} \
  && git submodule update --init --recursive --depth 1 \
  && find . -name .git -exec rm -rf {} + 2>/dev/null || true \
  && sed -i '/^\[etherscan\]/,/^$/d' foundry.toml \
  && npm install \
  && npm run template:process -- --bor-chain-id ${EL_CHAIN_ID} \
  && npm run generate:interfaces \
  && forge build

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

# spol-contracts. The kurtosis-specific validator setup script is uploaded at
# deploy time as a kurtosis artifact (rendered from a template so VALIDATOR_COUNT
# matches the actual devnet) — not baked into the image.
WORKDIR /opt/spol-contracts
RUN git clone --branch ${SPOL_CONTRACTS_BRANCH} https://github.com/0xPolygon/spol-contracts . \
  && git checkout ${SPOL_CONTRACTS_TAG_OR_COMMIT_SHA} \
  && rm -rf .git
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

# Carry the SVM cache from the builder so forge resolves solc against on-disk
# binaries (0.5.17 + 0.8.x for pos-contracts, etc.) instead of trying to fetch
# binaries.soliditylang.org at deploy time. Combined with `offline = true`
# appended to each foundry.toml below, this guarantees no network egress for
# compiler resolution — the kurtosis enclave often has no route to the public
# internet.
COPY --from=builder /root/.svm /root/.svm

# pos-contracts (anvil-pos) runtime surface: artifacts + contracts + scripts +
# the one node_modules dir whose paths are actually referenced by contracts/.
# Keeping src='contracts' so forge doesn't invalidate its build cache;
# contracts/ needs openzeppelin-solidity (8.4M) to parse — everything else in
# node_modules is dropped.
WORKDIR /opt/pos-contracts-anvil-pos
COPY --from=builder /opt/pos-contracts-anvil-pos/foundry.toml ./foundry.toml
RUN sed -i '/^\[profile\.default\]/a offline = true' foundry.toml
COPY --from=builder /opt/pos-contracts-anvil-pos/lib ./lib
COPY --from=builder /opt/pos-contracts-anvil-pos/contracts ./contracts
COPY --from=builder /opt/pos-contracts-anvil-pos/scripts ./scripts
COPY --from=builder /opt/pos-contracts-anvil-pos/out ./out
COPY --from=builder /opt/pos-contracts-anvil-pos/node_modules/openzeppelin-solidity ./node_modules/openzeppelin-solidity
COPY --from=builder /opt/pos-contracts-anvil-pos/node_modules/solidity-rlp ./node_modules/solidity-rlp
# Drop the mainnet upgrade migrations — they import extra deps we don't need,
# and we never invoke them from the devnet deploy wrappers.
RUN rm -rf scripts/deployers

# pos-contracts (main) runtime surface: only the ValidatorShare artifact and
# its dependencies are actually used (deployed via `forge create` against the
# pre-built `out/ValidatorShare.sol/ValidatorShare.json`). Everything else is
# stripped — we don't run `forge build` here, only `forge create`.
WORKDIR /opt/pos-contracts-main
COPY --from=builder /opt/pos-contracts-main/foundry.toml ./foundry.toml
RUN sed -i '/^\[profile\.default\]/a offline = true' foundry.toml
COPY --from=builder /opt/pos-contracts-main/out ./out

# pos-portal runtime surface: same idea, but the deploy scripts only use
# deployCode against pre-built artifacts, so contracts/ isn't needed.
WORKDIR /opt/pos-portal
COPY --from=builder /opt/pos-portal/foundry.toml ./foundry.toml
RUN sed -i '/^\[profile\.default\]/a offline = true' foundry.toml
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
RUN sed -i '/^\[profile\.default\]/a offline = true' foundry.toml
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
