# Polygon PoS Kurtosis Package

A [Kurtosis](https://github.com/kurtosis-tech/kurtosis) package for creating a private, portable and modular Polygon PoS devnet that can be deployed locally or in the cloud using Docker or Kubernetes. The package includes network tools and supports multiple clients, making blockchain development and testing more accessible.

> 🚨 Please note that this package is not intended for production use!

Specifically, this package will:

1. Spin up a local L1 chain, fully customizable with multi-client support, leveraging the [ethereum-package](https://github.com/ethpandaops/ethereum-package).
2. Deploy MATIC contracts to L1 as well as stake for each validators.
3. Generate Consensus Layer (CL) and Execution Layer (EL) genesis information.
4. Configure and boostrap a network of Polygon PoS nodes of configurable size using the genesis data generated above.

Optional features:

- Spin up a transaction spammer to send fake transactions to the network.
- Spin up monitoring solutions such as Prometheus, Grafana and Blockscout to observe the network.

## Table of contents

- [Quickstart](#quickstart)
  - [Prerequisites](#prerequisites)
  - [Deploy](#deploy)
  - [Interact](#interact)
  - [Tear Down](#tear-down)
- [Configuration](#configuration)

## Quickstart

### Prerequisites

You will need to install the following tools:

- [kurtosis](https://github.com/kurtosis-tech/kurtosis)
- [docker](https://docs.docker.com/)

If you intend to interact with and debug the devnet, you may also want to consider a few additional tools such as:

- [jq](https://github.com/jqlang/jq)
- [yq](https://pypi.org/project/yq/) (v3)
- [foundry](https://github.com/foundry-rs/foundry) (`cast` and `forge`)
- [polycli](https://github.com/0xPolygon/polygon-cli)

### Deploy

Run the package with default configurations with the following command. It will deploy a PoS devnet with three participants, two Heimdall/Bor validators and one Heimdall/Bor rpc. This process typically takes around five minutes.

```bash
kurtosis run --enclave pos-devnet github.com/0xPolygon/kurtosis-polygon-pos
```

Kurtosis packages are highly configurable, allowing users to customize network behavior by defining parameters in a file that can be dynamically passed at runtime.

```bash
kurtosis run --args-file params.yml --enclave pos-devnet github.com/0xPolygon/kurtosis-polygon-pos
```

Where `params.yml` contains the parameters of the devnet.

Note that it is also possible to specify args on the command line.

```bash
kurtosis run --enclave pos-devnet github.com/0xPolygon/kurtosis-polygon-pos '{"polygon_pos_package": {"network_params": {"bor_id": "98765"}}}"'
```

If you want to make modifications to the package, you can also run the package locally.

```bash
kurtosis run --args-file params.yml --enclave pos-devnet .
```

### Interact

To make sure the devnet is running correctly, you can use two of our handy scripts. The first script scans the Kurtosis enclave to identify the rpc urls of the different nodes (run this script only once per deployment), while the second script queries the different rpc urls and returns the status of the devnet.

```bash
export ENCLAVE="pos-devnet"
bash scripts/discover.sh
bash scripts/status.sh
```

If you want to format the result in a more readable way, you can use the following command.

```bash
result=$(bash scripts/status.sh)
echo "${result}" | jq --raw-output '
  (["Layer", "ID", "Name", "Peers", "Height", "Latest Block Hash", "Is Syncing"] | (., map(length*"-"))),
  (.participants.cl[] | ["CL"] + [.id, .name, .peers, .height, .latestBlockHash[:10], .isSyncing]),
  (.participants.el[] | ["EL"] + [.id, .name, .peers, .height, .latestBlockHash[:10], .isSyncing])
  | @tsv' | column -ts $'\t'
```

A healthy devnet is characterized by CL and EL nodes that successfully establish peer connections and show consistent block production and finalization across both layers.

Now that we made sure the devnet is healthy, let's do a simple L2 rpc test call.

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
kurtosis files inspect pos-devnet l2-cl-genesis genesis.json | tail -n +2 | jq
kurtosis files inspect pos-devnet l2-el-genesis genesis.json | tail -n +2 | jq
```

In the same way, you might want to check the MATIC contract addresses on the root and child chains.

```bash
kurtosis files inspect pos-devnet matic-contract-addresses contractAddresses.json | tail -n +2 | jq
```

### Tear Down

Once done with the enclave, you can remove its contents with the following command.

```bash
kurtosis enclave rm --force pos-devnet
```

## Configuration

To configure the package behaviour, you can create your own `params.yml` file (you can name it anything you like). The full YAML schema that can be passed in is as follows with the defaults provided:

```yml
# Ethereum package (L1) configuration.
# https://github.com/ethpandaops/ethereum-package?tab=readme-ov-file#configuration
ethereum_package:
  # Specification of the L1 participants.
  # By default, the L1 will rely on a single validator node (lighthouse/geth).
  participants:
    - el_type: geth
      el_image: ethereum/client-go:v1.14.12
      cl_type: lighthouse
      cl_image: sigp/lighthouse:v6.0.0
      use_separate_vc: true
      vc_type: lighthouse
      vc_image: sigp/lighthouse:v6.0.0

  # L1 network parameters.
  network_params:
    # Preset for the network.
    # Minimal preset is useful for rapid testing and development.
    # It only takes 192 seconds to get to finalized epoch vs 1536 seconds with mainnet defaults.
    preset: minimal
    # Number of seconds per slot on the Beacon chain.
    seconds_per_slot: 1


# Polygon PoS package (L2) configuration.
polygon_pos_package:
  # Specification of the L2 participants.
  participants:
    - ## Execution Layer (EL) specific flags.
      # The type of EL client that should be started.
      # Valid values are: "bor", "bor-modified-for-heimdall-v2", "erigon"
      el_type: bor

      # The docker image that should be used for the EL client.
      # Leave blank to use the default image for the client type.
      # Defaults by client:
      # - bor: "0xpolygon/bor:1.5.5"
      # - erigon: TBD
      el_image: ""

      # The log level string that this participant's EL client should log at.
      # Leave blank to use the default log level, info.
      # Valid values are: "error", "warn", "info", "debug", "trace"
      el_log_level: ""

      ## Consensus Layer (CL) specific flags.
      # The type of CL client that should be started.
      # Valid values are: "heimdall", "heimdall-v2"
      cl_type: heimdall

      # The docker image that should be used for the CL client.
      # Leave blank to use the default image for the client type.
      # Defaults by client:
      # - heimdall: "0xpolygon/heimdall:1.2.0"
      # - heimdall-v2: TDB
      cl_image: ""

      # The docker image that should be used for the CL's client database.
      # Leave blank to use the default image.
      # Default: "rabbitmq:4.0.5"
      cl_db_image: ""

      # The log level string that this participant's CL client should log at.
      # Leave blank to use the default log level, info.
      # Valid values are: "error", "warn", "info", "debug", "trace"
      cl_log_level: ""

      # Wether to run this participant as a validator or an rpc.
      # Default: false (run as an rpc)
      is_validator: true

      # Count of nodes to spin up for this participant.
      # Default: 1
      count: 2

    - el_type: bor
      cl_type: heimdall
      is_validator: false

  # Images for contract deployment and configuration.
  setup_images:
    # Image used to deploy MATIC contracts to L1.
    # Default: "leovct/pos-contract-deployer:node-16"
    contract_deployer: ""
    # Image used to create the L2 EL genesis file.
    # Default: "leovct/pos-el-genesis-builder:node-16"
    el_genesis_builder: ""
    # Image used to generate L2 CL/EL validators configurations.
    # Default: "leovct/pos-validator-config-generator:1.2.0-e0a87ca"
    validator_config_generator: ""

  # L2 network parameters.
  network_params:
    ## Validators parameters.
    # This mnemonic will be used to create keystores for CL/EL validators.
    # Note that validators accounts are prefunded to make the validator setup easier and faster.
    # Take a look at src/prelaunch_data_generator/genesis_constants/PRE_FUNDED_ACCOUNTS.md
    # Default: "sibling lend brave explain wait orbit mom alcohol disorder message grace sun"
    preregistered_validator_keys_mnemonic: ""
    # The amount of ether to stake for each validator.
    # Default: "10000"
    validator_stake_amount: ""
    # The top up fee amount, in ether, for each validator.
    # Default: "2000"
    validator_top_up_fee_amount: ""

    ## Consensus Layer parameters.
    # The CL network id.
    # Default: "heimdall-4927"
    cl_chain_id: ""
    # The span poll interval on the CL chain.
    # Default: "0m15s"
    cl_span_poll_interval: ""
    # The checkpoint pool interval on the CL chain.
    # Default: "1m0s"
    cl_checkpoint_poll_interval: ""

    ## Execution Layer parameters.
    # The EL network id.
    # Default: "4927"
    el_chain_id: ""
    # The number of seconds per block on the EL chain.
    # Default: 2
    el_block_interval_seconds: ""
    # The duration of an EL sprint, measured in blocks.
    # Default: 16
    el_sprint_duration: ""
    # The duration of an EL span, measured in blocks.
    # Default: 128
    el_span_duration: ""
    # The EL gas limit.
    # Default: 10^7
    el_gas_limit: ""

  # Additional services to run in this enclave.
  # Default: []
  additional_services:
    # A blockchain explorer (will be supported soon).
    - blockscout
    # A monitoring stack composed of Prometheus and Grafana (will be supported soon).
    - prometheus_grafana
    # A transaction spammer to send fake transactions to the network (will be supported soon).
    - tx_spammer

# Developper parameters.
dev:
  # Wether to deploy a local L1 or not.
  # By default, the package will deploy a local L1. If you want to use an existing L1, set this
  # parameter to false and specify the private key and the rpc url.
  should_deploy_l1: true
  # The private used to deploy MATIC contracts and fund validator accounts.
  # You only need to set this parameter if you set `dev.should_deploy_l1` to false and
  # `dev.should_deploy_matic_contracts` to true. Or in other words if you use an existing L1 but
  # still plan to deploy the MATIC contracts and generate the genesis files.
  # Default: ""
  l1_private_key: ""
  # The L1 rpc url.
  # Default: ""
  l1_rpc_url: ""

  # Wether to deploy MATIC contracts to L1 and generate the CL and EL genesis files.
  # By default, the package will deploy the contracts and generate the genesis files.
  # It you want to use your own genesis files, set this parameter to false and specify the filepaths.
  should_deploy_matic_contracts: true
  # The L2 CL genesis file path.
  # Default: ""
  l2_cl_genesis_filepath: ""
  # The L2 EL genesis file path.
  # Default: ""
  l2_el_genesis_filepath: ""
```
