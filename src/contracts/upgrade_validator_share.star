CONTRACTS_CONFIG_FILE_PATH = "../../static_files/contracts"


def upgrade(
    plan, polygon_pos_args, l1_rpc_url, private_key, contract_addresses_artifact
):
    """Replace pos-contracts (anvil-pos) ValidatorShare with the version mainnet runs.

    See upgrade-validator-share.sh for context — TL;DR sPOL's
    `_buySharesFromValidator` calls a fused `restakeAndStakePOL(uint256)` that
    only exists on pos-contracts/main, so without this step `buySPOL` reverts.
    """
    setup_images = polygon_pos_args.get("setup_images")
    contract_deployer_image = setup_images.get("contract_deployer")
    contract_deployer_config_artifact = plan.upload_files(
        name="validator-share-upgrade-config",
        src=CONTRACTS_CONFIG_FILE_PATH,
    )

    result = plan.run_sh(
        name="validator-share-upgrade",
        description="Deploying the upgraded ValidatorShare and pointing Registry at it",
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
                name="validator-share-upgrade-addresses",
            ),
        ],
        run="bash /opt/data/l1/upgrade-validator-share.sh",
        wait="3m",
    )
    return result.files_artifacts[0]
