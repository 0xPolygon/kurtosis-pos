FROM 0xpolygon/heimdall:1.0.10 AS heimdall

FROM alpine:latest
LABEL description="Heimdall genesis builder image"
LABEL author="devtools@polygon.technology"

ENV DEFAULT_HEIMDALL_ID="heimdall-P5rXwg"
ENV HEIMDALL_CONFIG_PATH="/etc/heimdall"

COPY --from=heimdall /usr/bin/heimdallcli /usr/bin/heimdalld /usr/local/bin/
RUN apk add --no-cache bash jq \
  && heimdalld init --home "${HEIMDALL_CONFIG_PATH}" --chain-id "${DEFAULT_HEIMDALL_ID}"
