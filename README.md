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

5. Check that CL nodes are connected.

```bash
# Attach a container, with network debugging tools, to one of the CL nodes.
# Find the docker identifier using `docker ps`.
# For example: `docker ps --filter "name=heimdall-0" --format "{{.ID}}"`.
docker run -it --rm --net=container:58b7944c59ba nicolaka/netshoot:latest /bin/bash
curl --silent localhost:26657/net_info | jq '.result.peers | length'
```

6. Check that EL nodes are connected.

```bash
# Attach a container, with network debugging tools, to one of the CL nodes.
# Find the docker identifier using `docker ps`.
# For example: `docker ps --filter "name=bor-0" --format "{{.ID}}"`.
docker run -it --rm --net=container:1db0b171c5c8 nicolaka/netshoot:latest /bin/bash
echo $(($(curl -s -H "Content-Type: application/json" --data '{"jsonrpc": "2.0", "method": "net_peerCount", "params": [], "id": 1}' localhost:8545 | jq --raw-output '.result')))
```

## Configuration

TODO
