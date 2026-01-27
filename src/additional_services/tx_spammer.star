constants = import_module("../config/constants.star")
contract_util = import_module("../contracts/util.star")
shared = import_module("./shared.star")
wallet_module = import_module("../wallet/wallet.star")

TX_SPAMMER_SCRIPT_NAME = "loadtest.sh"


def launch(
    plan,
    l1_context,
    l2_context,
    l2_network_params,
):
    # Get rpc urls and funder private key.
    l1_rpc_url = l1_context.rpc_url
    l2_rpc_url = l2_context.all_participants[0].el_context.rpc_http_url
    funder_private_key = l2_network_params.get("admin_private_key")

    # Generate a new wallet and fund it with ETH on L1.
    l1_wallet = wallet_module.new(plan)
    wallet_module.fund(
        plan,
        receiver_address=l1_wallet.address,
        rpc_url=l1_rpc_url,
        funder_private_key=funder_private_key,
    )

    # Start the tx spammer service on L1.
    tx_spammer_artifact = plan.upload_files(
        src="../../static_files/additional_services/tx-spammer/{}".format(
            TX_SPAMMER_SCRIPT_NAME
        ),
        name="tx-spammer-script",
    )
    _start_tx_spammer_service(
        plan,
        name="l1-tx-spammer",
        script_artifact=tx_spammer_artifact,
        private_key=l1_wallet.private_key,
        rpc_url=l1_rpc_url,
    )

    # Generate a new wallet and fund it with ETH on L2.
    l2_wallet = wallet_module.new(plan)
    wallet_module.fund(
        plan,
        receiver_address=l2_wallet.address,
        rpc_url=l2_rpc_url,
        funder_private_key=funder_private_key,
        # Note: Explicitly set the gas price on L2 because zero gas price transactions are not accepted.
        extra_flags="--priority-gas-price 50gwei --gas-price 50gwei",
    )

    # Start the tx spammer service on L2.
    _start_tx_spammer_service(
        plan,
        name="l2-tx-spammer",
        script_artifact=tx_spammer_artifact,
        private_key=l2_wallet.private_key,
        rpc_url=l2_rpc_url,
    )


def _start_tx_spammer_service(plan, name, script_artifact, private_key, rpc_url):
    plan.add_service(
        name=name,
        config=ServiceConfig(
            image=constants.DEFAULT_IMAGES.get("toolbox_image"),
            files={
                "/opt": Directory(artifact_names=[script_artifact]),
            },
            env_vars={
                "PRIVATE_KEY": private_key,
                "RPC_URL": rpc_url,
            },
            entrypoint=["bash", "-c"],
            cmd=["chmod +x /opt/{0} && /opt/{0}".format(TX_SPAMMER_SCRIPT_NAME)],
            max_cpu=shared.MAX_CPU,
            max_mem=shared.MAX_MEM,
        ),
    )
