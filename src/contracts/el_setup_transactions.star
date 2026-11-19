CONTRACTS_CONFIG_FILE_PATH = "../../static_files/contracts"


def send(plan, polygon_pos_args, l2_rpc_url, private_key):
    network_params = polygon_pos_args.get("network_params")
    transactions = network_params.get("el_setup_transactions")
    if not transactions:
        return

    setup_images = polygon_pos_args.get("setup_images")
    config_artifact = plan.upload_files(
        name="el-setup-transactions-scripts",
        src=CONTRACTS_CONFIG_FILE_PATH,
    )
    transactions_artifact = plan.render_templates(
        name="el-setup-transactions-config",
        config={
            "transactions.json": struct(
                template="{{.transactions}}",
                data={"transactions": json.encode(transactions)},
            )
        },
    )
    plan.run_sh(
        name="el-setup-transactions-sender",
        description="Sending the transactions given in el_setup_transactions on L2",
        image=setup_images.get("contract_deployer"),
        env_vars={
            "PRIVATE_KEY": private_key,
            "L2_RPC_URL": l2_rpc_url,
        },
        files={
            "/opt/data": config_artifact,
            "/opt/data/transactions": transactions_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/contracts/elSetupTransactions.json",
                name="el-setup-transactions",
            ),
        ],
        run="bash /opt/data/l2/send-el-setup-transactions.sh",
        wait="5m",
    )
