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

## Configuration

TODO
