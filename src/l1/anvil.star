constants = import_module("../config/constants.star")
hex = import_module("../hex/hex.star")
math = import_module("../math/math.star")
prefunded_accounts_module = import_module("../prefunded_accounts/accounts.star")


ANVIL_PORT_ID = "rpc"
ANVIL_PORT_NUMBER = 8545

ANVIL_GENESIS_FILE_PATH = "../../static_files/l1/anvil/genesis.json"


def _build_accounts_alloc(admin_address):
    # Anvil's --mnemonic only funds addresses derived from that mnemonic, but
    # PREFUNDED_ACCOUNTS now uses vanity addresses (not mnemonic-derived) for
    # validator EVM identities. Without explicit funding here, validator bridges
    # fail submitCheckpoint with "Insufficient funds for gas * price + value".
    accounts = {
        admin_address: {
            "nonce": 0,
            "balance": hex.int_to_hex(math.ether_to_wei(constants.ADMIN_BALANCE_ETH)),
            "code": "0x",
            "storage": {},
        },
    }
    validator_balance_wei = hex.int_to_hex(
        math.ether_to_wei(constants.VALIDATORS_BALANCE_ETH)
    )
    for a in prefunded_accounts_module.PREFUNDED_ACCOUNTS:
        accounts[a.eth_tendermint.address] = {
            "nonce": 0,
            "balance": validator_balance_wei,
            "code": "0x",
            "storage": {},
        }
    return accounts


def run(plan, anvil_args, preregistered_validator_keys_mnemonic, admin_address):
    genesis_artifact = plan.render_templates(
        name="l1-anvil-genesis",
        config={
            "genesis.json": struct(
                template=read_file(ANVIL_GENESIS_FILE_PATH),
                data={
                    "accounts": json.encode(_build_accounts_alloc(admin_address)),
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
                    number=ANVIL_PORT_NUMBER, application_protocol="http", wait="5s"
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
