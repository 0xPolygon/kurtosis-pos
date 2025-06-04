---
sidebar_position: 3
---

# Getting Started

Get up and running with the package in just a few steps.

1. Deploy a PoS devnet locally.

```bash
kurtosis run --enclave pos github.com/0xPolygon/kurtosis-polygon-pos
```

2. Get the L2 RPC url.

```bash
export ETH_RPC_URL=$(kurtosis port print pos l2-el-1-bor-heimdall-validator rpc)
echo $ETH_RPC_URL
```

3. Send a transaction.

```bash
pk="0xd40311b5a5ca5eaeb48dfba5403bde4993ece8eccf4190e98e19fcd4754260ea"
cast send --private-key "$pk" --value 0.01ether $(cast address-zero)
```

where `0xd40311b5a5ca5eaeb48dfba5403bde4993ece8eccf4190e98e19fcd4754260ea` is the admin private key used to deploy Polygon PoS contracts on both L1 and L2.

4. Tear down the devnet.

```bash
kurtosis enclave rm --force pos
```
