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
cl_rpc_url=$(kurtosis port print polygon-pos heimdall-0 rpc)
curl --silent "${cl_rpc_url}/net_info" | jq '.result.peers | length'
```

6. Check that EL nodes are connected.

```bash
el_rpc_url=$(kurtosis port print polygon-pos bor-0 rpc)
echo $(( $(curl --silent -H "Content-Type: application/json" --data '{"jsonrpc": "2.0", "method": "net_peerCount", "params": [], "id": 1}' "${el_rpc_url}" | jq --raw-output '.result') ))
```

7. Check the state of the L1 chain

```bash
polycli monitor --rpc-url "http://$(kurtosis port print polygon-pos el-1-geth-lighthouse rpc)"
```

8. Check the state of the L2 CL chain.

```bash
cl_rpc_url=$(kurtosis port print polygon-pos heimdall-0 rpc)
curl --silent "${cl_rpc_url}/status" | jq --raw-output '.result.sync_info.latest_block_height'
```

9. Check the state of the L2 EL chai

```bash
polycli monitor --rpc-url "$(kurtosis port print polygon-pos bor-0 rpc)"
```

10. Send some load to the network

```bash
export ETH_RPC_URL="$(kurtosis port print polygon-pos bor-0 rpc)"
cast balance 0x97538585a02A3f1B1297EB9979cE1b34ff953f1E # the first pre-funded account

private_key="0x2a4ae8c4c250917781d38d95dafbb0abe87ae2c9aea02ed7c7524685358e49c2"
cast send --legacy --private-key "$private_key" --value 0.01ether $(cast address-zero)
# TODO: Find out why it doesn't work with `cast` but it works with `polycli`.
# Error: server returned an error response: error code -32000: pending state is not available

polycli loadtest --rpc-url "$ETH_RPC_URL" --legacy --private-key "$private_key" --verbosity 700 --requests 500 --rate-limit 10 --mode t
polycli loadtest --rpc-url "$ETH_RPC_URL" --legacy --private-key "$private_key" --verbosity 700 --requests 500 --rate-limit 10 --mode 2
# TODO: Find out why blocks are not getting mined.
```

Some Heimdall logs:

```bash
[heimdall-0] DEBUG[2025-01-02|14:04:02.418] Error while fetching data from URL           status=400 URL=http://0.0.0.0:1317/staking/proposer/1
[heimdall-0] ERROR[2025-01-02|14:04:02.418] Error fetching proposers                     url=/staking/proposer/%v error="error while fetching data from url: http://0.0.0.0:1317/staking/proposer/1, status: 400"
[heimdall-0] ERROR[2025-01-02|14:04:02.418] Error checking isProposer in HeaderBlock handler module=checkpoint service=processor error="error while fetching data from url: http://0.0.0.0:1317/staking/proposer/1, status: 400"
[heimdall-0] ERROR: 2025/01/02 14:04:02 worker.go:370 Failed processing task task_8a4f4005-3620-4ccf-9dc8-e2f1e48b709f. Error = error while fetching data from url: http://0.0.0.0:1317/staking/proposer/1, status: 400
```

It can't retrieve the proposer so blocks are not getting mined on the validator layer.

```bash
cl_rest_api_url=$(kurtosis port print polygon-pos heimdall-0 http)
curl --silent "${cl_rest_api_url}/staking/proposer/1" | jq
{
  "error": "{\"codespace\":\"sdk\",\"code\":1,\"message\":\"failed to load state at height 0; version does not exist (latest height: 0)\"}"
}
```

Let's dig more... We're not able to find the current validator set as well as other parameters because of the same issue.

```bash
$ curl --silent "${cl_rest_api_url}/staking/validator-set" | jq
{
  "error": "{\"codespace\":\"sdk\",\"code\":1,\"message\":\"failed to load state at height 0; version does not exist (latest height: 0)\"}"
}

$ curl --silent "${cl_rest_api_url}/overview" | jq
{
  "height": "0",
  "result": {
    "ack_count": 0,
    "checkpoint_buffer": null,
    "validator_count": 0,
    "validator_set": {
      "validators": null,
      "proposer": null
    },
    "last_noack_time": "1970-01-01T00:00:00Z"
  }
}

$ curl --silent "${cl_rest_api_url}/chainmanager/params" | jq
{
  "error": "{\"codespace\":\"sdk\",\"code\":1,\"message\":\"failed to load state at height 0; version does not exist (latest height: 0)\"}"
}

$ curl --silent "${cl_rest_api_url}/bor/params" | jq
{
  "error": "{\"codespace\":\"sdk\",\"code\":1,\"message\":\"failed to load state at height 0; version does not exist (latest height: 0)\"}"
}

$ curl --silent "${cl_rest_api_url}/auth/params" | jq
{
  "error": "{\"codespace\":\"sdk\",\"code\":1,\"message\":\"failed to load state at height 0; version does not exist (latest height: 0)\"}"
}

$ curl --silent "${cl_rest_api_url}/bank/balances/0x97538585a02A3f1B1297EB9979cE1b34ff953f1E" | jq
{
  "error": "{\"codespace\":\"sdk\",\"code\":1,\"message\":\"failed to load state at height 0; version does not exist (latest height: 0)\"}"
}
```

## Configuration

TODO
