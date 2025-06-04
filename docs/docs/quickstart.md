---
sidebar_position: 2
---

# Quickstart

## Prerequisites

You will need to install the following tools:

- [kurtosis](https://github.com/kurtosis-tech/kurtosis)
- [docker](https://docs.docker.com/)

If you intend to interact with and debug the devnet, you may also want to consider a few additional tools such as:

- [jq](https://github.com/jqlang/jq)
- [yq](https://pypi.org/project/yq/) (v3)
- [foundry](https://github.com/foundry-rs/foundry) (`cast` and `forge`)
- [polycli](https://github.com/0xPolygon/polygon-cli)

## Installation

```bash
git clone https://github.com/0xPolygon/kurtosis-polygon-pos.git
cd kurtosis-polygon-pos
```

## Running Your First Environment

```bash
kurtosis run --enclave pos .
```

## Using Custom Configurations

You can pass custom arguments using the `--args-file` flag.

```bash
kurtosis run --enclave pos --args-file=./.github/configs/your-config.yml .
```

It is also possible to specify args on the command line.

```bash
kurtosis run --enclave pos . '{"polygon_pos_package": {"network_params": {"bor_id": "98765"}}}"'
```

Note that you can also run the default configuration without cloning the repository.

```bash
kurtosis run --enclave pos github.com/0xPolygon/kurtosis-polygon-pos
```

To use a specific version, you can use the following command.

```bash
kurtosis run --enclave pos github.com/0xPolygon/kurtosis-polygon-pos@v1.0.12
```

## Interact With The Network

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

## Tear Down

Once done with the enclave, you can remove its contents with the following command.

```bash
kurtosis enclave rm --force pos-devnet
```
