FROM node:20-slim
LABEL description="Polygon sPOL (LST) contracts deployment image"
LABEL author="devtools@polygon.technology"

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
  # Check out spol-contracts at the pinned ref. The previous implementation used
  # `git clone --depth 1 --branch main` followed by `git checkout <sha>`, but the
  # shallow clone only fetches the tip of main, so the checkout silently failed
  # (its non-zero exit swallowed by the `|| true` on the following `find`) and
  # the image was always built from whatever main currently pointed at — not the
  # SHA the tag claimed. Use a full clone so the checkout works for any ref form
  # the caller passes: short SHA, full SHA, tag, or branch name.
  && git clone https://github.com/0xPolygon/spol-contracts . \
  && git checkout "${SPOL_CONTRACTS_TAG_OR_COMMIT_SHA}" \
  && rm -rf .git

# Overlay kurtosis-specific mocks and validator-setup script into script/mock/.
# These files compile alongside the upstream sPOL source during the forge build below,
# and are referenced by name at deploy time by deploy-lst-contracts.sh in kurtosis-pos.
COPY spol-mocks/ script/mock/

# Pre-install soldeer deps and compile so the runtime container only needs to run
# the deploy scripts — no cold forge build on every kurtosis run.
RUN forge soldeer install \
  && forge build
