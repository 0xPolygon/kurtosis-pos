---
sidebar_position: 1
---

# Interact

Let's do a simple L2 rpc test call.

First, you will need to figure out which port Kurtosis is using for the rpc. You can get a general feel for the entire network layout by running the following command.

```bash
kurtosis enclave inspect pos-devnet
```

That output, while quite useful, might also be a little overwhelming. Let's store the rpc url in an environment variable.

```bash
export ETH_RPC_URL=$(kurtosis port print pos-devnet l2-el-1-bor-heimdall-validator rpc)
```

Send some load to the network.

```bash
# Using polycli.
pk="0x2a4ae8c4c250917781d38d95dafbb0abe87ae2c9aea02ed7c7524685358e49c2"
polycli loadtest --rpc-url "$ETH_RPC_URL" --legacy --private-key "$pk" --verbosity 700 --requests 5000 --rate-limit 10 --mode t
polycli loadtest --rpc-url "$ETH_RPC_URL" --legacy --private-key "$pk" --verbosity 700 --requests 500  --rate-limit 10 --mode 2
polycli loadtest --rpc-url "$ETH_RPC_URL" --legacy --private-key "$pk" --verbosity 700 --requests 500  --rate-limit 10 --mode v3

# Using cast.
cast send --legacy --private-key "$pk" --value 0.01ether $(cast address-zero)
```

Pretty often, you will want to check the output from the service. Here is how you can grab some logs:

```bash
kurtosis service logs pos-devnet l2-el-1-bor-heimdall-validator --follow
```

In other cases, if you see an error, you might want to get a shell in the service to be able to poke around.

```bash
kurtosis service shell pos-devnet l2-el-1-bor-heimdall-validator
```

You might also want to check the CL and EL genesis files.

```bash
kurtosis files inspect pos-devnet l2-cl-genesis genesis.json | jq
kurtosis files inspect pos-devnet l2-el-genesis genesis.json | jq
```

In the same way, you might want to check the MATIC contract addresses on L1 and L2.

```bash
kurtosis files inspect pos-devnet matic-contract-addresses contractAddresses.json | jq
```
