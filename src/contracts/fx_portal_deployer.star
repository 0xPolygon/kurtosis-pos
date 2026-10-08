CONTRACTS_CONFIG_FILE_PATH = "../../static_files/contracts"


def deploy(
    plan,
    polygon_pos_args,
    dev_args,
    l1_rpc_url,
    l2_rpc_url,
    private_key,
    contract_addresses_artifact,
):
    setup_images = polygon_pos_args.get("setup_images")
    image = setup_images.get("contract_deployer")
    config_artifact = plan.upload_files(
        name="fx-portal-deployer-config",
        src=CONTRACTS_CONFIG_FILE_PATH,
    )

    # Same reasoning as pos_bridge_deployer.deploy_l2: L1 contracts already exist.
    skip_l1_wiring = not dev_args.get("should_deploy_matic_contracts")

    result = plan.run_sh(
        name="fx-portal-deployer",
        description="Deploying fx-portal contracts on L1 and L2",
        image=image,
        env_vars={
            "PRIVATE_KEY": private_key,
            "L1_RPC_URL": l1_rpc_url,
            "L2_RPC_URL": l2_rpc_url,
            "SKIP_L1_WIRING": "1" if skip_l1_wiring else "0",
        },
        files={
            "/opt/data": config_artifact,
            "/opt/data/addresses": contract_addresses_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/contracts/contractAddresses.json",
                name="fx-portal-addresses",
            ),
        ],
        run="bash /opt/data/l2/deploy-fx-portal.sh",
        wait="5m",
    )
    return result.files_artifacts[0]
