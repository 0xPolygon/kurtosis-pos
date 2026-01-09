constants = import_module("../config/constants.star")
hex = import_module("../hex/hex.star")
math = import_module("../math/math.star")
prefunded_accounts_module = import_module("../prefunded_accounts/accounts.star")


ANVIL_PORT_ID = "http"
ANVIL_PORT_NUMBER = 8545


def run(plan, anvil_args, preregistered_validator_keys_mnemonic, admin_address):
    genesis_artifact = plan.render_templates(
        name="l1-anvil-genesis",
        config={
            "genesis.json": struct(
                template=read_file(src="../../static_files/l1/anvil/genesis.json"),
                data={
                    "admin_address": admin_address,
                    "admin_balance_wei": hex.int_to_hex(
                        math.ether_to_wei(constants.ADMIN_BALANCE_ETH)
                    ),
                },
            )
        },
    )

    service = plan.add_service(
        name="anvil",
        config=ServiceConfig(
            image=anvil_args.get("image"),
            ports={
                ANVIL_PORT_ID: PortSpec(
                    ANVIL_PORT_NUMBER, application_protocol="http", wait="5s"
                ),
            },
            files={
                "/opt/anvil": genesis_artifact,
            },
            cmd=[
                " ".join(
                    [
                        "anvil",
                        "--chain-id {}".format(anvil_args.get("network_id")),
                        "--block-time {}".format(anvil_args.get("block_time")),
                        "--slots-in-an-epoch {}".format(
                            anvil_args.get("slots_in_epoch")
                        ),
                        '--mnemonic "{}"'.format(preregistered_validator_keys_mnemonic),
                        "--accounts {}".format(
                            len(prefunded_accounts_module.PREFUNDED_ACCOUNTS)
                        ),
                        "--balance {}".format(constants.ADMIN_BALANCE_ETH),
                        "--load-state /opt/anvil/genesis.json",
                        "--dump-state /tmp/state_dump.json",
                        "--host 0.0.0.0",
                        "--port {}".format(ANVIL_PORT_NUMBER),
                    ]
                )
            ],
        ),
    )
    rpc_url = service.ports[ANVIL_PORT_ID].url
    return rpc_url
