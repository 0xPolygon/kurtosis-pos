constants = import_module("../config/constants.star")

CONTRACTS_CONFIG_FILE_PATH = "../../static_files/contracts"


def deploy_l1_pos_portal(
    plan, polygon_pos_args, l1_rpc_url, private_key, contract_addresses_artifact
):
    setup_images = polygon_pos_args.get("setup_images")
    image = setup_images.get("pos_portal_deployer")
    config_artifact = plan.upload_files(
        name="pos-portal-l1-deployer-config",
        src=CONTRACTS_CONFIG_FILE_PATH,
    )

    result = plan.run_sh(
        name="pos-portal-l1-deployer",
        description="Deploying pos-portal L1 (root) contracts",
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
                name="pos-portal-l1-addresses",
            ),
        ],
        run="bash /opt/data/deploy-l1-pos-portal.sh",
        wait="5m",
    )
    return result.files_artifacts[0]


def deploy_l2_pos_portal_and_wire(
    plan,
    polygon_pos_args,
    l1_rpc_url,
    l2_rpc_url,
    private_key,
    contract_addresses_artifact,
):
    setup_images = polygon_pos_args.get("setup_images")
    image = setup_images.get("pos_portal_deployer")
    config_artifact = plan.upload_files(
        name="pos-portal-l2-deployer-config",
        src=CONTRACTS_CONFIG_FILE_PATH,
    )

    result = plan.run_sh(
        name="pos-portal-l2-deployer",
        description="Deploying pos-portal L2 (child) contracts and cross-chain wiring",
        image=image,
        env_vars={
            "PRIVATE_KEY": private_key,
            "L1_RPC_URL": l1_rpc_url,
            "L2_RPC_URL": l2_rpc_url,
        },
        files={
            "/opt/data": config_artifact,
            "/opt/data/addresses": contract_addresses_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/contracts/contractAddresses.json",
                name="matic-contract-addresses-with-pos-portal",
            ),
        ],
        run="bash /opt/data/deploy-l2-pos-portal.sh",
        wait="5m",
    )
    return result.files_artifacts[0]
