# Polygon PoS Kurtosis Package

TODO

## Table of contents

TODO

## Quickstart

TODO

```bash
# Create a params file and deploy the devnet.
kurtosis run --enclave polygon-pos --args-file params.yml .

# Save the devnet parameters (genesis, contract addresses, etc.).
mkdir -p ./tmp
kurtosis files inspect polygon-pos l2-el-genesis genesis.json | tail -n +2 | jq > ./tmp/l2-el-genesis.json
kurtosis files inspect polygon-pos l2-cl-genesis genesis.json | tail -n +2 | jq > ./tmp/l2-cl-genesis.json
kurtosis files inspect polygon-pos matic-contract-addresses contractAddresses.json | tail -n +2 | jq > ./tmp/contract-addresses.json
kurtosis files inspect polygon-pos validators-config validators.js | tail -n +2 > ./tmp/validators.js
```

1. Get MATIC contract addresses.

```bash
kurtosis files inspect polygon-pos matic-contract-addresses contractAddresses.json | tail -n +2 | jq
```

2. Get the validators configuration.

```bash
kurtosis files inspect polygon-pos validators-config validators.js | tail -n +2
```

3. Get the EL genesis.

```bash
kurtosis files inspect polygon-pos l2-el-genesis genesis.json | tail -n +2 | jq
```

4. Get the CL genesis.

```bash
kurtosis files inspect polygon-pos l2-cl-genesis genesis.json | tail -n +2 | jq
```

5. Check the status of the devnet.

```bash
export ENCLAVE="polygon-pos"
bash scripts/discover.sh # Run this script only once.
bash scripts/status.sh
```

6. Send some load to the network.

```bash
export ETH_RPC_URL="$(kurtosis port print polygon-pos l2-el-1-bor-heimdall-validator rpc)"
cast balance 0x97538585a02A3f1B1297EB9979cE1b34ff953f1E # the first pre-funded account

private_key="0x2a4ae8c4c250917781d38d95dafbb0abe87ae2c9aea02ed7c7524685358e49c2"
polycli loadtest --rpc-url "$ETH_RPC_URL" --legacy --private-key "$private_key" --verbosity 700 --requests 500 --rate-limit 10 --mode t
polycli loadtest --rpc-url "$ETH_RPC_URL" --legacy --private-key "$private_key" --verbosity 700 --requests 500 --rate-limit 10 --mode 2
cast send --legacy --private-key "$private_key" --value 0.01ether $(cast address-zero)
```

## Configuration

TODO
