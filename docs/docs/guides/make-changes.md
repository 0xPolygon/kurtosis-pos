---
sidebar_position: 3
---

# Make Changes

Once you have deployed the package, you should have a fully working devnet.

Now imagine you would like to make a change to some of the L2 participants, eg. the EL image. No need to re-run the entire package, you can specify the `dev` parameters to save some time!

Let's imagine you used the following configuration:

```yml
# params.yml
polygon_pos_package:
  participants:
    - kind: validator
      cl_type: heimdall
      el_type: bor
      el_image: 0xpolygon/bor:2.0.3
      count: 2
    - kind: rpc
      cl_type: heimdall
      el_type: bor
      count: 1
```

First, we will save the L2 CL and EL genesis files for later.

```bash
mkdir -p ./tmp
kurtosis files inspect pos-devnet l2-cl-genesis genesis.json | jq > ./tmp/l2-cl-genesis.json
kurtosis files inspect pos-devnet l2-el-genesis genesis.json | jq > ./tmp/l2-el-genesis.json
kurtosis files inspect pos-devnet matic-contract-addresses contractAddresses.json | jq > ./tmp/matic-contract-addresses.json
```

Then, we will add the following `dev` parameters to the configuration.

```yml
dev:
  # Avoid re-deploying the L1 devnet.
  should_deploy_l1: false
  l1_rpc_url: http://el-1-geth-lighthouse:8545

  # Avoid re-deploying the MATIC contracts to L1 and re-generating the L2 CL and EL genesis files.
  should_deploy_matic_contracts: false
  l2_cl_genesis_filepath: ./tmp/l2-cl-genesis.json
  l2_el_genesis_filepath: ./tmp/l2-el-genesis.json
  matic_contract_addresses_filepath: ./tmp/matic-contract-addresses.json
```

Finally, we will modify the EL image of the L2 validators to use `0xpolygon/bor:2.0.0`.

The final configuration should like the following:

```yml
# params.yml
polygon_pos_package:
  participants:
    - kind: validator
      cl_type: heimdall
      el_type: bor
      el_image: 0xpolygon/bor:2.0.0 # default: 0xpolygon/bor:2.0.3
      count: 2
    - kind: rpc
      cl_type: heimdall
      el_type: bor
      count: 1

dev:
  # Avoid re-deploying the L1 devnet.
  should_deploy_l1: false
  l1_rpc_url: http://el-1-geth-lighthouse:8545

  # Avoid re-deploying the MATIC contracts to L1 and re-generating the L2 CL and EL genesis files.
  should_deploy_matic_contracts: false
  l2_cl_genesis_filepath: ./tmp/l2-cl-genesis.json
  l2_el_genesis_filepath: ./tmp/l2-el-genesis.json
  matic_contract_addresses_filepath: ./tmp/matic-contract-addresses.json
```

Stop the validators to avoid any issue when deploying the L2 contracts.

```bash
kurtosis service stop pos-devnet l2-el-1-bor-heimdall-validator
kurtosis service stop pos-devnet l2-el-2-bor-heimdall-validator
```

You can now run the package and it will only re-deploy the L2 participants. The deployment should be way faster!

```bash
kurtosis run --args-file params.yml --enclave pos-devnet .
```
