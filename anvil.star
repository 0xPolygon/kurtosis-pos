constants = import_module("./src/config/constants.star")


ANVIL_PORT_ID = "http"
ANVIL_PORT_NUMBER = 8545


def run(plan, args):
    service = plan.add_service(
        name="anvil",
        config=ServiceConfig(
            image=args.get("image"),
            ports={
                ANVIL_PORT_ID: PortSpec(ANVIL_PORT_NUMBER, application_protocol="http"),
            },
            cmd=[
                " ".join(
                    [
                        "anvil",
                        "--chain-id {}".format(args.get("network_id")),
                        "--block-time {}".format(args.get("block_time")),
                        "--slots-in-an-epoch {}".format(args.get("slots_in_epoch")),
                        "--host 0.0.0.0",
                        "--port {}".format(ANVIL_PORT_NUMBER),
                        "--balance {}".format(constants.ADMIN_BALANCE_ETH),
                        '--mnemonic "{}"'.format(args.get("mnemonic")),
                        "--dump-state /tmp/state_dump.json",
                    ]
                )
            ],
        ),
    )
    rpc_url = service.ports[ANVIL_PORT_ID].url
    return rpc_url
