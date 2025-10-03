---
sidebar_position: 2
---

# Reference

The following tables break down each configuration section and field available for customizing your devnet. Use these references to understand the structure, defaults, and purpose of every option.

:::tip
For the latest defaults and advanced options, always refer to the source code in `src/config/input_parser.star`.
:::

## L1 Configuration

To customize the L1 devnet, include an `ethereum_package` property in your args file. The available options mirror those from the ethereum-package. For the complete YAML schema and default values, refer to the [ethereum-package configuration documentation](https://github.com/ethpandaops/ethereum-package?tab=readme-ov-file#configuration).

```yml title="params.yml"
ethereum_package:
  participants:
    - cl_type: lighthouse
      el_type: geth
  network_params:
    preset: minimal
    seconds_per_slot: 1
```

### `participants`

| Field    | Type   | Default                     | Description                      |
| -------- | ------ | --------------------------- | -------------------------------- |
| cl_type  | string | lighthouse                  | Consensus Layer (CL) client type |
| cl_image | string | sigp/lighthouse:v8.0.0-rc.0 | Image for the CL client          |
| el_type  | string | geth                        | Execution Layer (EL) client type |
| el_image | string | ethereum/client-go:v1.16.4  | Image for the EL client          |

### `network_params`

| Field            | Type   | Default | Description                                              |
| ---------------- | ------ | ------- | -------------------------------------------------------- |
| preset           | string | minimal | Network preset, useful for rapid testing and development |
| seconds_per_slot | int    | 1       | Number of seconds per slot on the Beacon chain           |

## L2 Configuration

To customize the L2 devnet, include a `polygon_pos_package` property in your args file.

```yml title="params.yml"
polygon_pos_package:
  participants:
    - kind: validator
      cl_type: heimdall-v2
      el_type: bor
      count: 2
  network_params:
    el_block_interval_seconds: 2
    el_gas_limit: 45_000_000
  additional_services:
    - observability
```

### `participants`

Default: a single validator.

| Field                       | Type   | Default                     | Description                                              |
| --------------------------- | ------ | --------------------------- | -------------------------------------------------------- |
| kind                        | string | validator                   | Role of the node in the network: `validator` or `rpc`    |
| cl_type                     | string | heimdall-v2                 | Consensus Layer (CL) client type                         |
| cl_image                    | string | 0xpolygon/heimdall-v2:0.3.1 | Image for the CL client                                  |
| cl_db_image                 | string | rabbitmq:4.1.4              | Image for the CL database                                |
| cl_log_level                | string | info                        | Log level for the CL client                              |
| cl_min_retain_blocks        | int    | 0                           | Minimal distance from current height to retain height    |
| cl_compact_enabled          | bool   | false                       | Compaction enabling.                                     |
| cl_compaction_interval      | int    | 1000                        | Minimal blocks necessary to run a new compaction routine |
| cl_storage_pruning_interval | string | 1m0s                        | Interval between prune routines.                         |
| cl_indexer_pruning_enabled  | bool   | false                       | Pruning enabling.                                        |
| el_type                     | string | bor                         | Execution Layer (EL) client type                         |
| el_image                    | string | 0xpolygon/bor:2.2.11        | Image for the EL client                                  |
| el_log_level                | string | info                        | Log level for the EL client                              |
| count                       | int    | 1                           | Number of nodes to spin up for this participant          |

### `setup_images`

| Field                      | Type   | Default                                                                                              | Description                                 |
| -------------------------- | ------ | ---------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| contract_deployer          | string | europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/pos-contract-deployer:d96d592        | Image used to deploy MATIC contracts to L1  |
| el_genesis_builder         | string | europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/pos-el-genesis-builder:96a19dd       | Image used to create the L2 EL genesis file |
| validator_config_generator | string | europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/pos-validator-config-generator:0.3.1 | Image used to generate validator configs    |

### `network_params`

:::tip
You can check the admin private key and mnemonic default values at `src/config/input_parser.star`.
:::

| Field                                 | Type   | Default                | Description                                                        |
| ------------------------------------- | ------ | ---------------------- | ------------------------------------------------------------------ |
| admin_private_key                     | string | 0xd403...60ea          | Private key used to deploy Polygon PoS contracts on both L1 and L2 |
| preregistered_validator_keys_mnemonic | string | sibling lend brave ... | Mnemonic for validator keystores                                   |
| validator_stake_amount_eth            | int    | 10000                  | Amount of ether to stake for each validator                        |
| validator_top_up_fee_amount_eth       | int    | 2000                   | Top up fee amount in ether for each validator                      |
| cl_chain_id                           | string | heimdall-4927          | CL network ID                                                      |
| cl_environment                        | string | mainnet                | CL environment                                                     |
| cl_span_poll_interval                 | string | 0m15s                  | Span poll interval on the CL chain                                 |
| cl_checkpoint_poll_interval           | string | 1m0s                   | Checkpoint poll interval on the CL chain                           |
| cl_max_age_num_blocks                 | int    | 100000                 | Genesis evidence setting, useful to set smaller pruning intervals  |
| el_chain_id                           | string | "4927"                 | EL network ID                                                      |
| el_block_interval_seconds             | int    | 1                      | Seconds per block on the EL chain                                  |
| el_sprint_duration                    | int    | 16                     | Duration of an EL sprint (blocks)                                  |
| el_span_duration                      | int    | 128                    | Duration of an EL span (blocks).                                   |
| el_gas_limit                          | int    | 45_000_000             | EL gas limit                                                       |

### `additional_services`

The `additional_services` array lets you enable optional tools and utilities alongside your devnet. These are not configuration options themselves, but rather extra services you can include by listing their names in the array.

| Service          | Description                                                                                                  |
| ---------------- | ------------------------------------------------------------------------------------------------------------ |
| `blockscout`     | Blockchain explorer for viewing blocks, transactions, and accounts - Coming soon                             |
| `bridge_spammer` | Bridge funds from L1 to L2 to simulate network load                                                          |
| `observability`  | Monitoring stack: deploys Prometheus, Grafana, and [Panoptichain](https://github.com/0xPolygon/panoptichain) |
| `test_runner`    | Run [agglayer/e2e](https://github.com/agglayer/e2e) end-to-end tests against the devnet                      |
| `tx_spammer`     | Send transactions to the network to simulate load                                                            |
| `status_checker` | Perform fegular status checks to track and monitor the health of the network                                 |

### `test_runner_params`

| Field | Type   | Default                                                                     | Description                                                                                               |
| ----- | ------ | --------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| image | string | europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/e2e:9cf122d | Image used to deploy the test runner - used to run [agglayer/e2e](https://github.com/agglayer/e2e) tests. |

### `status_checker_params`

| Field | Type   | Default                                 | Description                              |
| ----- | ------ | --------------------------------------- | ---------------------------------------- |
| image | string | europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/status-checker:0.2.9 | Image used to deploy the status checker. |
