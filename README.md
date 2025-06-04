# Polygon PoS Kurtosis Package

A [Kurtosis](https://github.com/kurtosis-tech/kurtosis) package for creating a private, portable and modular Polygon PoS devnet that can be deployed locally or in the cloud using Docker or Kubernetes. The package includes network tools and supports multiple clients, making blockchain development and testing more accessible.

> 🚨 Please note that this package is not intended for production use!

Specifically, this package will:

1. Spin up a local L1 chain, fully customizable with multi-client support, leveraging the [ethereum-package](https://github.com/ethpandaops/ethereum-package).
2. Deploy MATIC contracts to L1 as well as stake for each validators.
3. Generate L2 Consensus Layer (CL) and Execution Layer (EL) genesis information.
4. Configure and boostrap a network of Polygon PoS nodes of configurable size using the genesis data generated above.

Optional features:

- Spin up a transaction spammer to send fake transactions to the network.
- Spin up monitoring solutions such as Prometheus, Grafana and Blockscout to observe the network.

For full documentation, see [docs](./docs/docs/introduction/overview.md).
