constants = import_module("../config/constants.star")
contract_util = import_module("../contracts/util.star")
wallet_module = import_module("../wallet/wallet.star")


def launch(
    plan,
    l1_context,
    l2_network_params,
    contract_addresses_artifact,
):
    # Retrieve L1 contract addresses.
    l1_matic_token_address = contract_util.get_address(
        plan,
        contract_name="l1_matic_token",
        contract_addresses_artifact=contract_addresses_artifact,
    )
    l1_erc20_token_address = contract_util.get_address(
        plan,
        contract_name="l1_erc20_token",
        contract_addresses_artifact=contract_addresses_artifact,
    )
    l1_deposit_manager_proxy_address = contract_util.get_address(
        plan,
        contract_name="l1_deposit_manager_proxy",
        contract_addresses_artifact=contract_addresses_artifact,
    )

    # Generate a new wallet, fund it with ETH, MATIC and some ERC20 tokens on L1.
    funder_private_key = l2_network_params.get("admin_private_key")
    wallet = wallet_module.new(plan)
    wallet_module.fund(
        plan,
        receiver_address=wallet.address,
        rpc_url=l1_context.rpc_url,
        funder_private_key=funder_private_key,
    )
    wallet_module.send_erc20_tokens(
        plan,
        contract_address=l1_matic_token_address,
        receiver_address=wallet.address,
        rpc_url=l1_context.rpc_url,
        funder_private_key=funder_private_key,
    )
    wallet_module.send_erc20_tokens(
        plan,
        contract_address=l1_erc20_token_address,
        receiver_address=wallet.address,
        rpc_url=l1_context.rpc_url,
        funder_private_key=funder_private_key,
    )

    # Start the bridge spammer service on L1.
    bridge_spammer_config_artifact = plan.upload_files(
        src="../../static_files/additional_services/bridge-spammer",
        name="bridge-spammer-script",
    )
    plan.add_service(
        name="l1-bridge-spammer",
        config=ServiceConfig(
            image=constants.DEFAULT_IMAGES.get("toolbox_image"),
            files={
                SCRIPT_FOLDER_PATH: Directory(
                    artifact_names=[bridge_spammer_config_artifact]
                ),
            },
            env_vars={
                "PRIVATE_KEY": wallet.private_key,
                "L1_RPC_URL": l1_context.rpc_url,
                # addresses
                "L1_MATIC_TOKEN_ADDRESS": l1_matic_token_address,
                "L1_ERC20_TOKEN_ADDRESS": l1_erc20_token_address,
                "L1_DEPOSIT_MANAGER_PROXY_ADDRESS": l1_deposit_manager_proxy_address,
            },
            entrypoint=["bash", "-c"],
            cmd=["chmod +x {0}/{1} && {0}/{1}".format(SCRIPT_FOLDER_PATH, SCRIPT_NAME)],
        ),
    )
