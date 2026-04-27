CONTRACTS_CONFIG_FILE_PATH = "../../static_files/contracts"


def migrate(
    plan, polygon_pos_args, l1_rpc_url, private_key, contract_addresses_artifact
):
    setup_images = polygon_pos_args.get("setup_images")
    contract_deployer_image = setup_images.get("contract_deployer")
    contract_deployer_config_artifact = plan.upload_files(
        name="matic-to-pol-migration-config",
        src=CONTRACTS_CONFIG_FILE_PATH,
    )

    result = plan.run_sh(
        name="matic-to-pol-migration",
        description="Deploying POL + PolygonMigration and running the MATIC -> POL governance batch",
        image=contract_deployer_image,
        env_vars={
            "PRIVATE_KEY": private_key,
            "L1_RPC_URL": l1_rpc_url,
        },
        files={
            "/opt/data": contract_deployer_config_artifact,
            "/opt/data/addresses": contract_addresses_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/contracts/contractAddresses.json",
                name="plasma-bridge-l1-addresses-with-pol",
            ),
        ],
        run="bash /opt/data/l1/migrate-matic-to-pol-token.sh",
        wait="3m",
    )
    return result.files_artifacts[0]
