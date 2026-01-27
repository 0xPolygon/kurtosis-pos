constants = import_module("../../config/constants.star")
shared = import_module("../shared.star")


# The folder where the erigon template config is stored in the repository.
ERIGON_TEMPLATE_CONFIG_FILE_PATH = "../../../static_files/el/erigon/config.toml"


# The folder where erigon configs are stored inside the service.
ERIGON_CONFIG_FOLDER_PATH = "/etc/erigon"
# The folder where erigon app stores data inside the service.
ERIGON_APP_DATA_FOLDER_PATH = "/var/lib/erigon"


def launch(
    plan,
    el_node_name,
    id,
    participant,
    network_params,
    el_genesis_artifact,
    el_keys_artifact,
    cl_api_url,
    cl_ws_rpc_url,
    el_account,
    el_static_nodes,
    container_proc_manager_artifact,
    ethstats_server_params,
):
    erigon_node_config_artifact = plan.render_templates(
        name="{}-config".format(el_node_name),
        config={
            "config.toml": struct(
                template=read_file(ERIGON_TEMPLATE_CONFIG_FILE_PATH),
                data={
                    # node params
                    "node_name": el_node_name,
                    "config_folder_path": ERIGON_CONFIG_FOLDER_PATH,
                    "data_folder_path": ERIGON_APP_DATA_FOLDER_PATH,
                    "kind": participant.get("kind"),
                    "address": el_account.eth_tendermint.address,
                    "cl_api_url": cl_api_url,
                    "log_level": participant.get("el_log_level"),
                    "json_log_enabled": participant.get("el_log_format")
                    == constants.LOG_FORMAT.json,
                    "extradata": "erigon-{}".format(id),
                    # network params.
                    "el_chain_id": network_params.get("el_chain_id"),
                    "el_gas_limit": network_params.get("el_gas_limit"),
                    "static_nodes": ",".join(el_static_nodes),
                    "ethstats_server_secret": ethstats_server_params.get("ws_secret"),
                    # ports
                    "rpc_port_number": shared.RPC_PORT_NUMBER,
                    "ws_port_number": shared.WS_PORT_NUMBER,
                    "discovery_port_number": shared.DISCOVERY_PORT_NUMBER,
                    "metrics_port_number": shared.METRICS_PORT_NUMBER,
                    "ethstats_server_port_number": constants.ETHSTATS_SERVER_PORT_NUMBER,
                },
            ),
        },
    )

    erigon_cmds = [
        # Copy genesis file.
        "cp /opt/data/genesis/genesis.json {}/genesis.json".format(
            ERIGON_CONFIG_FOLDER_PATH
        ),
        # Copy keys.
        "cp /opt/data/keys/password.txt {}".format(ERIGON_CONFIG_FOLDER_PATH),
        "mkdir -p {}".format(ERIGON_APP_DATA_FOLDER_PATH),
        "cp /opt/data/keys/nodekey {}/nodekey".format(ERIGON_APP_DATA_FOLDER_PATH),
        "cp -r /opt/data/keys/keystore {}".format(ERIGON_APP_DATA_FOLDER_PATH),
        # Initialise erigon.
        "erigon init --datadir {} {}/genesis.json".format(
            ERIGON_APP_DATA_FOLDER_PATH, ERIGON_CONFIG_FOLDER_PATH
        ),
        # Start erigon.
        # Note: this command attempts to start Erigon and retries if it fails.
        # The retry mechanism addresses a race condition where Erigon initially fails to
        # resolve hostnames of other nodes, as services are created sequentially;
        # after a 5-second delay, all services should be up, allowing Erigon to start
        # successfully. This is also why the port checks are disabled.
        "while ! erigon --config {}/config.toml; do echo -e '\n❌ Erigon failed to start. Retrying in five seconds...\n'; sleep 5; done".format(
            ERIGON_CONFIG_FOLDER_PATH
        ),
    ]

    return plan.add_service(
        name=el_node_name,
        config=ServiceConfig(
            image=participant.get("el_image"),
            # All port checks are disabled, see the comment above.
            ports={
                shared.RPC_PORT_ID: PortSpec(
                    number=shared.RPC_PORT_NUMBER,
                    application_protocol="http",
                    wait=None,
                ),
                shared.WS_PORT_ID: PortSpec(
                    number=shared.WS_PORT_NUMBER,
                    application_protocol="ws",
                    wait=None,
                ),
                shared.DISCOVERY_PORT_ID: PortSpec(
                    number=shared.DISCOVERY_PORT_NUMBER,
                    application_protocol="http",
                    wait=None,
                ),
                shared.METRICS_PORT_ID: PortSpec(
                    number=shared.METRICS_PORT_NUMBER,
                    application_protocol="http",
                    wait=None,
                ),
            },
            files={
                ERIGON_CONFIG_FOLDER_PATH: erigon_node_config_artifact,
                "/opt/data/genesis": el_genesis_artifact,
                "/opt/data/keys": el_keys_artifact,
            },
            entrypoint=["sh", "-c"],
            cmd=["&&".join(erigon_cmds)],
            user=User(uid=0, gid=0),  # Run the container as root user.
            max_cpu=shared.MAX_CPU,
            max_mem=shared.MAX_MEM,
        ),
    )
