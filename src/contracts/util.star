def read_contract_addresses(plan, contract_addresses_artifact):
    mapping = {
        # Root contracts.
        ## Core contracts.
        "l1_deposit_manager": ".root.DepositManager",
        "l1_deposit_manager_proxy": ".root.DepositManagerProxy",
        # EventsHubProxy - only availaible with node 20 contract deployer
        "l1_exit_nft": ".root.ExitNFT",
        # Governance - node 20
        "l1_governance_proxy": ".root.GovernanceProxy",
        "l1_registry": ".root.Registry",
        "l1_root_chain": ".root.RootChain",
        "l1_root_chain_proxy": ".root.RootChainProxy",
        "l1_slashing_manager": ".root.SlashingManager",
        "l1_stake_manager": ".root.StakeManager",
        "l1_stake_manager_proxy": ".root.StakeManagerProxy",
        "l1_staking_info": ".root.StakingInfo",
        "l1_state_sender": ".root.StateSender",
        # ValidatorShare - node 20
        "l1_withdraw_manager": ".root.WithdrawManager",
        "l1_withdraw_manager_proxy": ".root.WithdrawManagerProxy",
        "l1_erc20_predicate": ".root.ERC20Predicate",
        "l1_erc721_predicate": ".root.ERC721Predicate",
        "l1_marketplace_predicate": ".root.MarketplacePredicate",
        ## Tokens.
        "l1_matic_token": ".root.tokens.MaticToken",
        "l1_matic_weth_": ".root.tokens.MaticWeth",
        "l1_erc721_token": ".root.RootERC721",
        "l1_erc20_token": ".root.tokens.TestToken",
        # Child contracts.
        ## Core contracts.
        "l2_child_chain": ".child.ChildChain",
        ## Tokens.
        "l2_matic_token": ".child.tokens.MaticToken",
        "l2_matic_weth": ".child.tokens.MaticWeth",
        "l2_erc721_token": ".child.RootERC721",
        "l2_erc20_token": ".child.tokens.TestToken",
    }
    result = {}
    for key, path in mapping.items():
        address = _read_contract_address(plan, contract_addresses_artifact, key, path)
        result[key] = address
    return result


def _read_contract_address(plan, contract_addresses_artifact, key, path):
    result = plan.run_sh(
        description="Reading {} contract address".format(key),
        files={
            "/opt/contracts": contract_addresses_artifact,
        },
        run="jq --raw-output '{}' /opt/contracts/contractAddresses.json | tr -d '\n'".format(
            path
        ),
    )
    return result.output


def read_state_receiver_contract_address(plan, el_genesis_artifact):
    result = plan.run_sh(
        description="Reading state receiver contract address",
        files={
            "/opt/contracts": el_genesis_artifact,
        },
        run="jq --raw-output '.config.bor.stateReceiverContract' /opt/contracts/genesis.json | tr -d '\n'",
    )
    return result.output
