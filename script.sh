#!/bin/sh

kurtosis service exec pos test-runner -- env \
  | grep -vE '^(HOSTNAME|HOME|PATH|PWD)=' \
  > /Users/mardizzone/Desktop/polygon/code/kurtosis-pos/service.env

HOST_L1_RPC=$(kurtosis port print pos el-1-geth-lighthouse rpc)
sed -i.bak -E "s|^L1_RPC_URL=.*|L1_RPC_URL=http://${HOST_L1_RPC}|" /Users/mardizzone/Desktop/polygon/code/kurtosis-pos/service.env

HOST_L2_RPC=$(kurtosis port print pos l2-el-1-erigon-heimdall-v2-validator rpc)
sed -i.bak -E "s|^L2_RPC_URL=.*|L2_RPC_URL=${HOST_L2_RPC}|" /Users/mardizzone/Desktop/polygon/code/kurtosis-pos/service.env

HOST_L2_CL_API_URL=$(kurtosis port print pos l2-cl-1-heimdall-v2-erigon-validator http)
sed -i.bak -E "s|^L2_CL_API_URL=.*|L2_CL_API_URL=${HOST_L2_CL_API_URL}|" /Users/mardizzone/Desktop/polygon/code/kurtosis-pos/service.env




set -a
source /Users/mardizzone/Desktop/polygon/code/kurtosis-pos/service.env
bats  --show-output-of-passing-tests --filter-tags bridge,transaction-pol --recursive /Users/mardizzone/Desktop/polygon/code/e2e/tests/

set +a
