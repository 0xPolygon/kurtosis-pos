ARG HEIMDALL_V2_VERSION="0.6.0"
FROM 0xpolygon/heimdall-v2:${HEIMDALL_V2_VERSION} AS heimdall-v2


FROM golang:1.26-alpine AS polycli-builder
LABEL description="Polycli builder image"
LABEL author="devtools@polygon.technology"

ARG POLYGON_CLI_VERSION="v0.1.102"
WORKDIR /opt/polygon-cli
RUN apk add --no-cache git build-base \
  && git clone --branch "${POLYGON_CLI_VERSION}" https://github.com/0xPolygon/polygon-cli.git . \
  && make build


FROM alpine:3.23
LABEL description="CL genesis builder image"
LABEL author="devtools@polygon.technology"

ENV CL_CHAIN_ID="heimdall-4927"
ENV CL_CLIENT_CONFIG_PATH="/etc/cl"

COPY --from=heimdall-v2 /usr/bin/heimdalld /usr/local/bin/heimdalld
COPY --from=polycli-builder /opt/polygon-cli/out/polycli /usr/local/bin/polycli
COPY --from=polycli-builder /opt/polygon-cli/bindings /opt/bindings

RUN apk add --no-cache ca-certificates bash jq tini xxd \
  && heimdalld init --home "${CL_CLIENT_CONFIG_PATH}" --chain-id "${CL_CHAIN_ID}" 1
