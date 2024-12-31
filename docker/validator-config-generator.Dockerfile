FROM golang:1.22 AS polycli-builder
WORKDIR /opt/polygon-cli
RUN git clone --branch v0.1.65 https://github.com/maticnetwork/polygon-cli.git . \
  && make build

FROM 0xpolygon/heimdall:1.0.10 AS heimdall

FROM alpine:latest
LABEL description="Heimdall genesis builder image"
LABEL author="devtools@polygon.technology"

ENV DEFAULT_HEIMDALL_ID="heimdall-P5rXwg"
ENV HEIMDALL_CONFIG_PATH="/etc/heimdall"

COPY --from=polycli-builder /opt/polygon-cli/out/polycli /usr/local/bin/polycli
COPY --from=polycli-builder /opt/polygon-cli/bindings /opt/bindings
COPY --from=heimdall /usr/bin/heimdallcli /usr/bin/heimdalld /usr/local/bin/

RUN apk add --no-cache bash jq \
  && heimdalld init --home "${HEIMDALL_CONFIG_PATH}" --chain-id "${DEFAULT_HEIMDALL_ID}"
