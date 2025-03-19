FROM node:16-bookworm
LABEL description="Polygon PoS contracts deployment image (node-16)"
LABEL author="devtools@polygon.technology"

ENV DEFAULT_EL_CHAIN_ID="4927"

# Prepare MATIC smart contracts for deployment by compiling them.
# For reference: https://github.com/maticnetwork/contracts/tree/v0.3.11/deploy-migrations
# 🚨 Note: it installs jq v1.6 which does not correctly handle large numbers!
# root@cbd6ec04fded:/opt/contracts# echo "2105474802501957777" | jq '.'
# 2105474802501958000
WORKDIR /opt/contracts
RUN apt-get update \
  && apt-get install --yes --no-install-recommends jq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && npm install --global truffle@5.11.5 \
  && git clone --branch mardizzone/node-16 https://github.com/maticnetwork/contracts.git . \
  && git checkout c4d8e12 \
  && npm install \
  && npm run template:process -- --bor-chain-id "${DEFAULT_EL_CHAIN_ID}" \
  && truffle compile
