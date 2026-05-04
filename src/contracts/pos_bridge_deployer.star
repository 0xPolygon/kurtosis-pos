CONTRACTS_CONFIG_FILE_PATH = "../../static_files/contracts"


def deploy_l1(
    plan, polygon_pos_args, l1_rpc_url, private_key, contract_addresses_artifact
):
    setup_images = polygon_pos_args.get("setup_images")
    image = setup_images.get("contract_deployer")
    config_artifact = plan.upload_files(
        name="pos-bridge-l1-deployer-config",
        src=CONTRACTS_CONFIG_FILE_PATH,
    )

    result = plan.run_sh(
        name="pos-bridge-l1-deployer",
        description="Deploying pos-bridge L1 (root) contracts",
        image=image,
        env_vars={
            "PRIVATE_KEY": private_key,
            "L1_RPC_URL": l1_rpc_url,
        },
        files={
            "/opt/data": config_artifact,
            "/opt/data/addresses": contract_addresses_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/contracts/contractAddresses.json",
                name="pos-bridge-l1-addresses",
            ),
        ],
        run="bash /opt/data/l1/deploy-pos-bridge.sh",
        wait="5m",
    )
    return result.files_artifacts[0]


def deploy_l2(
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
        name="pos-bridge-l2-deployer-config",
        src=CONTRACTS_CONFIG_FILE_PATH,
    )

    # When `should_deploy_matic_contracts` is false, the L1 contracts (incl. the
    # cross-chain wiring done by deploy-pos-bridge.sh) are already in place from
    # a prior deploy. Re-running the wiring would emit fresh state-sync events on
    # L1 that race the test deposit and break bor's lastStateId tracking.
    skip_l1_wiring = not dev_args.get("should_deploy_matic_contracts")

    result = plan.run_sh(
        name="pos-bridge-l2-deployer",
        description="Deploying pos-bridge L2 (child) contracts and cross-chain wiring",
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
                name="pos-bridge-l2-addresses",
            ),
        ],
        run="bash /opt/data/l2/deploy-pos-bridge.sh",
        wait="5m",
    )
    return result.files_artifacts[0]
