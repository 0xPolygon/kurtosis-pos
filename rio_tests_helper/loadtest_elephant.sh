#!/bin/bash

rpc_url=$(kurtosis port print pos l2-el-1-bor-heimdall-v2-validator rpc)
private_key="0xd40311b5a5ca5eaeb48dfba5403bde4993ece8eccf4190e98e19fcd4754260ea"

# docker run -v $PWD:/code:ro -it ethereum/solc:0.8.30-alpine --bin --strict-assembly /code/elephant.yul | tail -n 1 > elephant.bin
elephant_deploy_contract=$(polycli wrap-contract $(cat elephant.bin))
elephant_addr=$(cast send --legacy --rpc-url "$rpc_url" --private-key "$private_key" --create "$elephant_deploy_contract" | grep "contractAddress" | awk '{print $2}')
cast code $elephant_addr --rpc-url $rpc_url

polycli fund --number 100 --seed "elephant" --rpc-url $rpc_url --private-key $private_key --eth-amount 1000000000000000000000
jq -r '.[].PrivateKey' wallets.json > private-keys.txt

polycli loadtest \
        --rpc-url "$rpc_url" \
        --rate-limit "6" \
        --mode contract-call \
        --concurrency 500 \
        --requests 10000 \
        --contract-address "$elephant_addr" \
        --gas-price 26000000000 \
        --gas-limit 10000000 \
        --sending-accounts-file private-keys.txt \
        --calldata 0x3defb9620000000000000000000000000000000000000000000000000000000000000001 \
        --verbosity 700
