# Port identifiers and numbers.
BOR_RPC_PORT_ID = "rpc"
BOR_RPC_PORT_NUMBER = 8545

BOR_WS_PORT_ID = "ws"
BOR_WS_PORT_NUMBER = 8546

BOR_DISCOVERY_PORT_ID = "discovery"
BOR_DISCOVERY_PORT_NUMBER = 30303


# The folder where the bor template config is stored in the repository.
BOR_TEMPLATE_CONFIG_FILE_PATH = "../../../static_files/bor/config.toml"

# The folder where the heimdall configs are stored inside the service.
BOR_CONFIG_FOLDER_PATH = "/etc/bor"
# The folder where bor app stores data inside the service.
BOR_APP_DATA_FOLDER_PATH = "/var/lib/bor"


def launch(
    plan,
    el_node_name,
    participant,
    el_genesis_artifact,
    el_validator_config_artifact,
    cl_node_url,
    el_account,
    bor_static_nodes,
):
    bor_config_artifact = plan.render_templates(
        name="{}-config".format(el_node_name),
        config={
            "config.toml": struct(
                template=read_file(BOR_TEMPLATE_CONFIG_FILE_PATH),
                data={
                    # node params
                    "node_name": el_node_name,
                    "config_folder_path": BOR_CONFIG_FOLDER_PATH,
                    "data_folder_path": BOR_APP_DATA_FOLDER_PATH,
                    "is_miner": participant["is_validator"],
                    "address": el_account.eth_address,
                    "static_nodes": str(bor_static_nodes),
                    "cl_node_url": cl_node_url,
                    # ports
                    "rpc_port_number": BOR_RPC_PORT_NUMBER,
                    "ws_port_number": BOR_WS_PORT_NUMBER,
                    "discovery_port_number": BOR_DISCOVERY_PORT_NUMBER,
                },
            ),
        },
    )

    return plan.add_service(
        name=el_node_name,
        config=ServiceConfig(
            image=participant["el_image"],
            ports={
                BOR_RPC_PORT_ID: PortSpec(
                    number=BOR_RPC_PORT_NUMBER,
                    application_protocol="http",
                    wait=None,
                ),
                BOR_WS_PORT_ID: PortSpec(
                    number=BOR_WS_PORT_NUMBER,
                    application_protocol="ws",
                    wait=None,
                ),
                BOR_DISCOVERY_PORT_ID: PortSpec(
                    number=BOR_DISCOVERY_PORT_NUMBER,
                    application_protocol="http",
                    wait=None,
                ),
            },
            files={
                BOR_CONFIG_FOLDER_PATH: bor_config_artifact,
                "/opt/data/genesis": el_genesis_artifact,
                "/opt/data/config": el_validator_config_artifact,
            },
            entrypoint=["sh", "-c"],
            cmd=[
                "&&".join(
                    [
                        # Copy EL genesis file inside bor config folder.
                        "cp /opt/data/genesis/genesis.json /opt/data/config/password.txt {}".format(
                            BOR_CONFIG_FOLDER_PATH
                        ),
                        # Copy EL validator config inside bor data folder.
                        "mkdir -p {}/bor".format(BOR_APP_DATA_FOLDER_PATH),
                        "cp /opt/data/config/nodekey {}/bor/nodekey".format(
                            BOR_APP_DATA_FOLDER_PATH
                        ),
                        "cp -r /opt/data/config/keystore {}".format(
                            BOR_APP_DATA_FOLDER_PATH
                        ),
                        # Start bor.
                        # Note: this command attempts to start Bor and retries if it fails.
                        # The retry mechanism addresses a race condition where Bor initially fails to
                        # resolve hostnames of other nodes, as services are created sequentially;
                        # after a 5-second delay, all services should be up, allowing Bor to start
                        # successfully. This is also why the port checks are disabled.
                        "while ! bor server --config {}/config.toml; do echo -e '\n❌ Bor failed to start. Retrying in five seconds...\n'; sleep 5; done".format(
                            BOR_CONFIG_FOLDER_PATH
                        ),
                    ]
                )
            ],
        ),
    )
