CONTRACTS_CONFIG_FILE_PATH = "../../static_files/contracts"

# Must match static_files/el/genesis/genesis.json's config.bor.reservedRegistryContract
# and config.bor.reservedClients — this devnet stub hardcodes both sides rather
# than templating them, matching genesis.json's own untemplated stub values.
REGISTRY_ADDR = "0x0000000000000000000000000000000000001002"
CLIENT_ADDR = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"
CLIENT_QUOTA_GAS = "30000000"


def initialize_reserved_registry(
    plan, polygon_pos_args, l2_rpc_url, admin_private_key, admin_address
):
    setup_images = polygon_pos_args.get("setup_images")
    image = setup_images.get("contract_deployer")
    config_artifact = plan.upload_files(
        name="reserved-registry-deployer-config",
        src=CONTRACTS_CONFIG_FILE_PATH,
    )

    plan.run_sh(
        name="reserved-registry-init",
        description="Initializing the reserved-blockspace registry and registering the devnet client",
        image=image,
        env_vars={
            "PRIVATE_KEY": admin_private_key,
            "L2_RPC_URL": l2_rpc_url,
            "ADMIN_ADDRESS": admin_address,
            "REGISTRY_ADDR": REGISTRY_ADDR,
            "CLIENT_ADDR": CLIENT_ADDR,
            "CLIENT_QUOTA_GAS": CLIENT_QUOTA_GAS,
        },
        files={
            "/opt/data": config_artifact,
        },
        run="bash /opt/data/l2/init-reserved-registry.sh",
        wait="2m",
    )
