CONTRACTS_CONFIG_FILE_PATH = "../../static_files/contracts"


def deploy(plan, polygon_pos_args, l2_rpc_url, private_key):
    network_params = polygon_pos_args.get("network_params")
    deployments = network_params.get("el_contract_deployments")
    if not deployments:
        return

    setup_images = polygon_pos_args.get("setup_images")
    config_artifact = plan.upload_files(
        name="el-contract-deployer-config",
        src=CONTRACTS_CONFIG_FILE_PATH,
    )
    deployments_artifact = plan.render_templates(
        name="el-contract-deployments-config",
        config={
            "deployments.json": struct(
                template="{{.deployments}}",
                data={"deployments": json.encode(deployments)},
            )
        },
    )
    plan.run_sh(
        name="el-contract-deployer",
        description="Deploying the contracts given in el_contract_deployments on L2",
        image=setup_images.get("contract_deployer"),
        env_vars={
            "PRIVATE_KEY": private_key,
            "L2_RPC_URL": l2_rpc_url,
        },
        files={
            "/opt/data": config_artifact,
            "/opt/data/deployments": deployments_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/contracts/elContractDeployments.json",
                name="el-contract-deployments",
            ),
        ],
        run="bash /opt/data/l2/deploy-el-contracts.sh",
        wait="5m",
    )
