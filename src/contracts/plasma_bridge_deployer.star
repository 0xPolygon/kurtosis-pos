constants = import_module("../config/constants.star")

CONTRACTS_CONFIG_FILE_PATH = "../../static_files/contracts/pos"


def deploy_l1(plan, polygon_pos_args, l1_rpc_url, private_key, validator_accounts):
    network_params = polygon_pos_args.get("network_params")
    setup_images = polygon_pos_args.get("setup_images")
    contract_deployer_image = setup_images.get("contract_deployer")
    contract_deployer_config_artifact = plan.upload_files(
        name="plasma-bridge-l1-deployer-config",
        src=CONTRACTS_CONFIG_FILE_PATH,
    )

    validator_accounts_formatted = _format_validator_accounts(validator_accounts)
    result = plan.run_sh(
        name="plasma-bridge-l1-deployer",
        description="Deploying plasma bridge contracts to L1 and staking each validator",
        image=contract_deployer_image,
        env_vars={
            "PRIVATE_KEY": private_key,
            "L1_RPC_URL": l1_rpc_url,
            "CL_CHAIN_ID": constants.CL_CHAIN_ID,
            "VALIDATOR_ACCOUNTS": validator_accounts_formatted,
            "VALIDATOR_BALANCE": str(constants.VALIDATORS_BALANCE_ETH),
            "VALIDATOR_STAKE_AMOUNT_ETH": str(
                network_params.get("validator_stake_amount_eth")
            ),
            "VALIDATOR_TOP_UP_FEE_AMOUNT_ETH": str(
                network_params.get("validator_top_up_fee_amount_eth")
            ),
        },
        files={
            "/opt/data": contract_deployer_config_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/contracts/contractAddresses.json",
                name="plasma-bridge-l1-addresses",
            ),
            StoreSpec(
                src="/opt/contracts/validators.js",
                name="l2-validators-config",
            ),
        ],
        run="bash /opt/data/l1/deploy-plasma-bridge.sh",
        wait="5m",
    )
    artifact_count = len(result.files_artifacts)
    if artifact_count != 2:
        fail(
            "The L1 plasma-bridge deployer should have generated 2 artifacts, got {}.".format(
                artifact_count
            )
        )
    return (result.files_artifacts[0], result.files_artifacts[1])


def deploy_l2(
    plan,
    polygon_pos_args,
    l1_rpc_url,
    l2_rpc_url,
    private_key,
    contract_addresses_artifact,
):
    setup_images = polygon_pos_args.get("setup_images")
    contract_deployer_image = setup_images.get("contract_deployer")
    contract_deployer_config_artifact = plan.upload_files(
        name="plasma-bridge-l2-deployer-config",
        src=CONTRACTS_CONFIG_FILE_PATH,
    )

    result = plan.run_sh(
        name="plasma-bridge-l2-deployer",
        description="Deploying plasma bridge child contracts on L2 and synchronising state on L1",
        image=contract_deployer_image,
        env_vars={
            "PRIVATE_KEY": private_key,
            "L1_RPC_URL": l1_rpc_url,
            "L2_RPC_URL": l2_rpc_url,
        },
        files={
            "/opt/data": contract_deployer_config_artifact,
            "/opt/data/addresses": contract_addresses_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/contracts/contractAddresses.json",
                name="plasma-bridge-addresses",
            ),
        ],
        run="bash /opt/data/l2/deploy-plasma-bridge.sh",
        wait="10m",
    )
    return result.files_artifacts[0]


def _format_validator_accounts(accounts):
    return ";".join(
        [
            "{},{}".format(
                account.eth_tendermint.address, account.eth_tendermint.public_key
            )
            for account in accounts
        ]
    )
