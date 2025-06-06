---
sidebar_position: 1
---

# Overview

This section explains how to customize your Polygon PoS devnet deployment.

## Running With Custom Arguments

You can pass custom arguments using the `--args-file` flag:

```bash
kurtosis run --enclave pos --args-file params.yml .
```

Alternatively, you can specify arguments directly on the command line:

```bash
kurtosis run --enclave pos . \
  '{"polygon_pos_package": {"network_params": {"bor_id": "98765"}}}"'
```

:::warning
Do not combine an args file with on-the-fly arguments as Kurtosis cannot merge parameters from both sources and will use only the on-the-fly arguments.
:::

## Example Configurations

Below are some sample configurations to help you get started. Feel free to copy and adapt these examples to fit your use case. You can find more examples in the `.github/configs/` directory.

### Heimdall - Bor Devnet

```yml title=".github/configs/heimdall-bor.yml"
polygon_pos_package:
  participants:
    - kind: validator
      cl_type: heimdall
      el_type: bor
      count: 4
    - kind: rpc
      cl_type: heimdall
      el_type: bor
      count: 2
```

### Heimdall - Erigon Devnet

```yml title=".github/configs/heimdall-erigon.yml"
polygon_pos_package:
  participants:
    - kind: validator
      cl_type: heimdall
      el_type: erigon
      count: 4
    - kind: rpc
      cl_type: heimdall
      el_type: erigon
      count: 2

  network_params:
    cl_environment: local
```

### Heimdall-v2 - Bor Devnet

```yml title=".github/configs/heimdall-v2-bor.yml"
polygon_pos_package:
  participants:
    - kind: validator
      cl_type: heimdall-v2
      el_type: bor
      count: 4
    - kind: rpc
      cl_type: heimdall-v2
      el_type: bor
      count: 2
```

### Default Devnet with Observability and Test Runner

```yml title=".github/configs/additional-services.yml"
polygon_pos_package:
  additional_services:
    - prometheus_grafana
    - test_runner

```

Explore the [Configuration Schema](reference.md) for a detailed breakdown of all available options.
