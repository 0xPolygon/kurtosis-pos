---
sidebar_position: 2
---

# Run Bridge Tests

This guide will show you how to run end-to-end (e2e) bridge tests against a Kurtosis devnet.

:::info
This guide assumes you have a running devnet, if that's not the case, you can head to the [Getting Started](../introduction/getting-started.md) section.
:::

## Clone the Test Suite

First, clone the [agglayer/e2e](https://github.com/agglayer/e2e) repository. PoS-related tests are located in `tests/pos`.

```bash
git clone https://github.com/agglayer/e2e.git
cd e2e
```

## Run Bats Tests

:::info
We rely on [bats](https://github.com/bats-core/bats-core), a bash testing framework to run most of our e2e tests. The next steps assume you have it installed.
:::

Then run the L1-to-L2 bridge test to validate that Heimdall and Bor can process bridge events and trigger state synchronizations.

```bash
bats --filter-tags pos,bridge --recursive tests/
```

:::tip
If you have deployed the test runner in your environment, you can run the tests without cloning the repository:

```bash
kurtosis service exec pos test-runner "bats --filter-tags pos,bridge --recursive tests/"
```

:::

After the tests complete, you should see output similar to:

```bash
pos/plasma-bridge.bats
 ✓ bridge POL from L1 to L2 via Plasma bridge and confirm native tokens balance increased on L2
 ✓ bridge MATIC from L1 to L2 via Plasma bridge and confirm native tokens balance increased on L2
 ✓ bridge ETH from L1 to L2 via Plasma bridge and confirm MaticWeth balance increased on L2
 ✓ bridge ERC20 tokens from L1 to L2 via Plasma bridge and confirm ERC20 balance increased on L2
 ✓ bridge ERC721 token from L1 to L2 via Plasma bridge and confirm ERC721 balance increased on L2

5 tests, 0 failures
```

If any tests fail, check the logs in your Kurtosis enclave for more details.
