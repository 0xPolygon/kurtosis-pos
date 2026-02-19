---
sidebar_position: 2
---

# Reference

The following tables break down each configuration section and field available for customizing your devnet. Use these references to understand the structure, defaults, and purpose of every option.

:::tip
For the latest defaults and advanced options, always refer to the source code in `src/config/input_parser.star`.
:::

## Dev Configuration

The `dev` section controls high-level deployment options for the devnet.

```yml title="params.yml"
dev:
  l1_backend: ethereum-package
  should_deploy_l1: true
  should_deploy_matic_contracts: true
```

|             Field             |  Type  |     Default      |                                   Description                                    |
| ----------------------------- | ------ | ---------------- | -------------------------------------------------------------------------------- |
| l1_backend                    | string | ethereum-package | L1 backend to use: `ethereum-package` for full devnet or `anvil` for lightweight |
| should_deploy_l1              | bool   | true             | Whether to deploy the L1 chain                                                   |
| should_deploy_matic_contracts | bool   | true             | Whether to deploy Polygon PoS contracts to L1                                    |

## L1 Configuration

The package supports two L1 backends, configured via the `dev.l1_backend` parameter:

- **`ethereum-package`** (default): Full-featured L1 devnet with multi-client support
- **`anvil`**: Lightweight local Ethereum node for rapid testing

### Ethereum Package Backend

When using `l1_backend: ethereum-package` (default), customize the L1 devnet with an `ethereum_package` property in your args file. The available options mirror those from the ethereum-package. For the complete YAML schema and default values, refer to the [ethereum-package configuration documentation](https://github.com/ethpandaops/ethereum-package?tab=readme-ov-file#configuration).

```yml title="params.yml"
dev:
  l1_backend: ethereum-package  # default

ethereum_package:
  participants:
    - cl_type: lighthouse
      el_type: geth
  network_params:
    preset: minimal
    seconds_per_slot: 1
```

#### `participants`

|  Field   |  Type  |          Default           |           Description            |
| -------- | ------ | -------------------------- | -------------------------------- |
| cl_type  | string | lighthouse                 | Consensus Layer (CL) client type |
| cl_image | string | sigp/lighthouse:v8.1.0     | Image for the CL client          |
| el_type  | string | geth                       | Execution Layer (EL) client type |
| el_image | string | ethereum/client-go:v1.17.0 | Image for the EL client          |

#### `network_params`

|      Field       |  Type  | Default |                       Description                        |
| ---------------- | ------ | ------- | -------------------------------------------------------- |
| preset           | string | minimal | Network preset, useful for rapid testing and development |
| seconds_per_slot | int    | 1       | Number of seconds per slot on the Beacon chain           |

### Anvil Backend

When using `l1_backend: anvil`, customize the Anvil L1 with an `anvil` property in your args file. Anvil is a lightweight local Ethereum node from the Foundry toolkit, ideal for rapid testing scenarios.

```yml title="params.yml"
dev:
  l1_backend: anvil

anvil:
  network_id: "3151908"
  block_time: 1
  slots_in_epoch: 2
```

| Field          | Type   | Default                               | Description                                                                                           |
| -------------- | ------ | ------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| image          | string | ghcr.io/foundry-rs/foundry:v1.6.0-rc1 | Anvil container image                                                                                 |
| network_id     | string | 3151908                               | L1 network/chain ID                                                                                   |
| block_time     | int    | 1                                     | Block time in seconds                                                                                 |
| slots_in_epoch | int    | 2                                     | Number of slots per epoch (block_time × slots_in_epoch = seconds to transition from latest to safest) |

## L2 Configuration

To customize the L2 devnet, include a `polygon_pos_package` property in your args file.

```yml title="params.yml"
polygon_pos_package:
  log_level: info
  log_format: text
  participants:
    - kind: validator
      cl_type: heimdall-v2
      el_type: bor
      count: 2
  network_params:
    el_block_interval_seconds: 2
    el_gas_limit: 60_000_000
  additional_services:
    - observability
```

### Top-Level Parameters

|   Field    |  Type  | Default |                                     Description                                     |
| ---------- | ------ | ------- | ----------------------------------------------------------------------------------- |
| log_level  | string | info    | Global log level for all participants: `error`, `warn`, `info`, `debug`, or `trace` |
| log_format | string | text    | Global log format for all participants: `text` or `json`                            |

:::tip
These global settings apply to all participants unless overridden at the participant level with `cl_log_level`, `cl_log_format`, `el_log_level`, or `el_log_format`.
:::

### `participants`

Default: a single validator.

| Field                            | Type   | Default                     | Description                                                                                         |
| -------------------------------- | ------ | --------------------------- | --------------------------------------------------------------------------------------------------- |
| kind                             | string | validator                   | Role of the node in the network: `validator`, `rpc` or `archive`                                    |
| cl_type                          | string | heimdall-v2                 | Consensus Layer (CL) client type                                                                    |
| cl_image                         | string | 0xpolygon/heimdall-v2:0.6.0 | Image for the CL client                                                                             |
| cl_queue_image                   | string | rabbitmq:4.2.4              | Image for the CL queue                                                                              |
| cl_log_level                     | string | info                        | Log level for the CL client                                                                         |
| cl_log_format                    | string | text                        | Log format for the CL client                                                                        |
| cl_min_retain_blocks             | int    | 0                           | Minimal distance from current height to retain height                                               |
| cl_compact_enabled               | bool   | false                       | Compaction enabling.                                                                                |
| cl_compaction_interval           | int    | 1000                        | Minimal blocks necessary to run a new compaction routine                                            |
| cl_storage_pruning_interval      | string | 10m0s                       | Interval between prune routines.                                                                    |
| cl_indexer_pruning_enabled       | bool   | false                       | Pruning enabling.                                                                                   |
| el_type                          | string | bor                         | Execution Layer (EL) client type: `bor` or `erigon`                                                 |
| el_image                         | string | 0xpolygon/bor:2.6.0-beta2   | Image for the EL client (bor: `0xpolygon/bor:2.6.0-beta2`, erigon: `0xpolygon/erigon:v3.4.0-beta2`) |
| el_log_level                     | string | info                        | Log level for the EL client                                                                         |
| el_log_format                    | string | text                        | Log format for the EL client                                                                        |
| el_bor_produce_witness           | bool   | false                       | Allow bor to start producing witnesses                                                              |
| el_bor_sync_with_witness         | bool   | false                       | Enable bor to sync new blocks using witnesses                                                       |
| el_bor_stateless_parallel_import | bool   | false                       | Enable bor to use parallel import in stateless mode (requires `el_bor_sync_with_witness`)           |
| count                            | int    | 1                           | Number of nodes to spin up for this participant                                                     |

### `setup_images`

|           Field            |  Type  |                        Default                         |                 Description                 |
| -------------------------- | ------ | ------------------------------------------------------ | ------------------------------------------- |
| contract_deployer          | string | ghcr.io/0xpolygon/pos-contract-deployer:d96d592        | Image used to deploy MATIC contracts to L1  |
| el_genesis_builder         | string | ghcr.io/0xpolygon/pos-el-genesis-builder:96a19dd       | Image used to create the L2 EL genesis file |
| validator_config_generator | string | ghcr.io/0xpolygon/pos-validator-config-generator:0.6.0 | Image used to generate validator configs    |

### `network_params`

:::tip
You can check the admin private key and mnemonic default values at `src/config/input_parser.star`.
:::

| Field                                 | Type   | Default            | Description                                                        |
| ------------------------------------- | ------ | ------------------ | ------------------------------------------------------------------ |
| admin_private_key                     | string | 0xd403...60ea      | Private key used to deploy Polygon PoS contracts on both L1 and L2 |
| preregistered_validator_keys_mnemonic | string | sibling lend brave | Mnemonic for validator keystores                                   |
| validator_stake_amount_eth            | int    | 10000              | Amount of ether to stake for each validator                        |
| validator_top_up_fee_amount_eth       | int    | 2000               | Top up fee amount in ether for each validator                      |
| cl_chain_id                           | string | heimdall-4927      | CL network ID                                                      |
| cl_environment                        | string | -                  | CL environment: `mainnet`, `mumbai`, or `local` (optional)         |
| cl_span_poll_interval                 | string | 5s                 | Span poll interval on the CL chain                                 |
| cl_checkpoint_poll_interval           | string | 5s                 | Checkpoint poll interval on the CL chain                           |
| cl_max_age_num_blocks                 | int    | 100000             | Genesis evidence setting, useful to set smaller pruning intervals  |
| el_chain_id                           | string | "4927"             | EL network ID                                                      |
| el_block_interval_seconds             | int    | 1                  | Seconds per block on the EL chain                                  |
| el_sprint_duration                    | int    | 16                 | Duration of an EL sprint (blocks)                                  |
| el_span_duration                      | int    | 128                | Duration of an EL span (blocks).                                   |
| el_gas_limit                          | int    | 65_000_000         | EL gas limit                                                       |
| jaipur_fork_block                     | int    | 0                  | Block number for Jaipur hard fork activation                       |
| delhi_fork_block                      | int    | 0                  | Block number for Delhi hard fork activation                        |
| indore_fork_block                     | int    | 0                  | Block number for Indore hard fork activation                       |
| agra_fork_block                       | int    | 0                  | Block number for Agra hard fork activation                         |
| napoli_fork_block                     | int    | 0                  | Block number for Napoli hard fork activation                       |
| ahmedabad_fork_block                  | int    | 0                  | Block number for Ahmedabad hard fork activation                    |
| bhilai_fork_block                     | int    | 0                  | Block number for Bhilai hard fork activation                       |
| rio_fork_block                        | int    | 256                | Block number for Rio hard fork activation                          |
| madhugiri_fork_block                  | int    | 256                | Block number for Madhugiri hard fork activation                    |
| madhugiri_pro_fork_block              | int    | 256                | Block number for Madhugiri Pro hard fork activation                |
| dandeli_fork_block                    | int    | 256                | Block number for Dandeli hard fork activation                      |
| lisovo_fork_block                     | int    | 256                | Block number for Lisovo hard fork activation                       |
| lisovo_pro_fork_block                 | int    | 256                | Block number for Lisovo Pro hard fork activation                   |

### `additional_services`

The `additional_services` array lets you enable optional tools and utilities alongside your devnet. These are not configuration options themselves, but rather extra services you can include by listing their names in the array.

|      Service      |                                                 Description                                                  |
| ----------------- | ------------------------------------------------------------------------------------------------------------ |
| `blockscout`      | Blockchain explorer for viewing blocks, transactions, and accounts - Coming soon                             |
| `bridge_spammer`  | Bridge funds from L1 to L2 to simulate network load                                                          |
| `ethstats_server` | Visual interface for tracking network status                                                                 |
| `observability`   | Monitoring stack: deploys Prometheus, Grafana, and [Panoptichain](https://github.com/0xPolygon/panoptichain) |
| `status_checker`  | Perform regular status checks to track and monitor the health of the network                                 |
| `tx_spammer`      | Send transactions to the network to simulate load                                                            |

### `ethstats_server_params`

| Field |  Type  |                                         Default                                         |               Description                |
| ----- | ------ | --------------------------------------------------------------------------------------- | ---------------------------------------- |
| image | string | europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/ethstats-server:9da2124 | Image used to deploy the ethstats server |

### `status_checker_params`

| Field |  Type  |                 Default                 |               Description               |
| ----- | ------ | --------------------------------------- | --------------------------------------- |
| image | string | ghcr.io/0xpolygon/status-checker:v0.2.9 | Image used to deploy the status checker |
