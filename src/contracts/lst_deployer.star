constants = import_module("../config/constants.star")

LST_CONTRACTS_CONFIG_FILE_PATH = "../../static_files/contracts/lst"


def deploy_lst_contracts(
    plan,
    polygon_pos_args,
    dev_args,
    l1_rpc_url,
    l2_rpc_url,
    private_key,
    admin_address,
    validator_accounts,
    pos_contract_addresses_artifact,
):
    """Deploy sPOL/LST contracts to L1 and L2.

    Runs inside the pos-contract-deployer image, which bundles the spol-contracts
    source, the kurtosis-specific validator setup script, soldeer deps, and a
    warm forge cache under /opt/spol-contracts (alongside pos-contracts and
    pos-portal). Reads PolygonMigration and RootChainManager from the
    accumulated PoS contractAddresses.json (no longer needs kurtosis-specific
    mocks now that main deploys both as real contracts).

    Downstream consumers read the resulting `lst-contract-addresses` kurtosis
    artifact by name, so this function does not return it.
    """
    network_params = polygon_pos_args.get("network_params")
    setup_images = polygon_pos_args.get("setup_images")
    lst_deployer_params = dev_args.get("lst_deployer_params", {})

    reward_fee = lst_deployer_params.get("reward_fee", 50)
    fee_receiver = lst_deployer_params.get("fee_receiver", "")
    max_divergence = lst_deployer_params.get("max_divergence", 10)

    contract_deployer_config_artifact = plan.upload_files(
        src=LST_CONTRACTS_CONFIG_FILE_PATH,
        name="lst-deployer-config",
    )

    plan.run_sh(
        name="lst-contracts-deployer",
        description="Deploying sPOL/LST contracts to L1 and L2",
        image=setup_images.get("contract_deployer"),
        env_vars={
            "PRIVATE_KEY": private_key,
            "L1_RPC_URL": l1_rpc_url,
            "L2_RPC_URL": l2_rpc_url,
            "L1_CHAIN_ID": str(constants.L1_CHAIN_ID),
            "L2_CHAIN_ID": str(network_params.get("el_chain_id")),
            "ADMIN_ADDRESS": admin_address,
            "REWARD_FEE": str(reward_fee),
            "FEE_RECEIVER": fee_receiver,
            "MAX_DIVERGENCE": str(max_divergence),
            "VALIDATOR_COUNT": str(len(validator_accounts)),
        },
        files={
            "/opt/data": contract_deployer_config_artifact,
            "/opt/data/pos-addresses": pos_contract_addresses_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/lst/lstContractAddresses.json",
                name="lst-contract-addresses",
            ),
        ],
        run="bash /opt/data/deploy-lst-contracts.sh",
        wait="5m",
    )
