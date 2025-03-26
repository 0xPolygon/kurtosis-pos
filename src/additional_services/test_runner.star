TEST_RUNNER_IMAGE = "e2e:test"  # TODO: Update the image name.


def launch(
    plan,
    l1_context,
    l2_participants,
    l2_network_params,
    devnet_cl_type,
    l2_el_genesis_artifact,
    contract_addresses_artifact,
):
    # Retrieve contract addresses.
    l1_deposit_manager_proxy_address = contract_util.get_address(
        plan,
        contract_name="l1_deposit_manager_proxy",
        contract_addresses_artifact=contract_addresses_artifact,
    )
    l1_erc20_token_address = contract_util.get_address(
        plan,
        contract_name="l1_erc20_token",
        contract_addresses_artifact=contract_addresses_artifact,
    )
    l2_state_receiver_address = contract_util.get_address(
        plan,
        contract_name="l2_state_receiver",
        l2_el_genesis_artifact=l2_el_genesis_artifact,
    )

    plan.add_service(
        name="test-runner",
        config=ServiceConfig(
            image=TEST_RUNNER_IMAGE,
            env_vars={
                "ADDRESS": l2_network_params.get("admin_address"),
                "PRIVATE_KEY": l2_network_params.get("admin_private_key"),
                "L2_CL_NODE_TYPE": devnet_cl_type,
                # RPC Urls.
                "L1_RPC_URL": l1_context.rpc_url,
                "L2_RPC_URL": l2_participants[0].el_context.rpc_http_url,
                "L2_CL_API_URL": l2_participants[0].cl_context.api_url,
                # Contract addresses.
                "L1_DEPOSIT_MANAGER_PROXY_ADDRESS": l1_deposit_manager_proxy_address,
                "ERC20_TOKEN_ADDRESS": l1_erc20_token_address,
                "L2_STATE_RECEIVER_ADDRESS": l2_state_receiver_address,
            },
            entrypoint=["bash", "-c"],
            cmd=["sleep infinity"],
        ),
    )
