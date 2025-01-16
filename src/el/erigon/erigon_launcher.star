# Port identifiers and numbers.
ERIGON_RPC_PORT_ID = "rpc"
ERIGON_RPC_PORT_NUMBER = 8545

ERIGON_WS_PORT_ID = "ws"
ERIGON_WS_PORT_NUMBER = 8546

ERIGON_METRICS_PORT_ID = "metrics"
ERIGON_METRICS_PORT_NUMBER = 7071


# The folder where the erigon template config is stored in the repository.
ERIGONTEMPLATE_CONFIG_FILE_PATH = "../../../static_files/erigon/config.toml"


# The folder where erigon configs are stored inside the service.
ERIGON_CONFIG_FOLDER_PATH = "/etc/erigon"
# The folder where erigon app stores data inside the service.
ERIGON_APP_DATA_FOLDER_PATH = "/var/lib/erigon"


def launch(
    plan,
    el_node_name,
    participant,
    el_genesis_artifact,
    el_validator_config_artifact,
    cl_node_url,
    el_account,
    el_static_nodes,
    network_params,
):
    is_validator = participant.get("is_validator", False)
    erigon_node_config_artifact = plan.render_templates(
        name="{}-node-config".format(el_node_name),
        config={
            "config.toml": struct(
                template=read_file(ERIGONTEMPLATE_CONFIG_FILE_PATH),
                data={
                    # node params
                    "node_name": el_node_name,
                    "config_folder_path": ERIGON_CONFIG_FOLDER_PATH,
                    "data_folder_path": ERIGON_APP_DATA_FOLDER_PATH,
                    "is_validator": is_validator,
                    "address": el_account.eth_address,
                    "static_nodes": str(el_static_nodes),
                    "cl_node_url": cl_node_url,
                    "log_level": participant.get("el_log_level", ""),
                    # ports
                    "rpc_port_number": ERIGON_RPC_PORT_NUMBER,
                    "ws_port_number": ERIGON_WS_PORT_NUMBER,
                    "metrics_port_number": ERIGON_METRICS_PORT_NUMBER,
                },
            ),
        },
    )

    files = {
        ERIGON_CONFIG_FOLDER_PATH: erigon_node_config_artifact,
        "/opt/data/genesis": el_genesis_artifact,
    }
    if is_validator:
        files["/opt/data/config"] = el_validator_config_artifact

    validator_cmds = [
        # Copy EL validator config inside erigon data and config folders.
        "cp /opt/data/config/nodekey {}/nodekey".format(ERIGON_CONFIG_FOLDER_PATH),
    ]
    erigon_cmd = [
        # Copy EL genesis file inside erigon config folder.
        "cp /opt/data/genesis/genesis.json {}/genesis.json".format(
            ERIGON_CONFIG_FOLDER_PATH
        ),
        # Start erigon.
        "".join(
            [
                "erigon",
                "--verbosity={}".format(participant.get("el_log_level", "")),
                "--nodekey={}/nodekey".format(ERIGON_CONFIG_FOLDER_PATH),
                "--datadir={}".format(ERIGON_APP_DATA_FOLDER_PATH),
                "--chain=mainnet",
                "--networkid={}".format(network_params.get("el_chain_id", "")),
                "--bor.heimdall={}".format(cl_node_url),
                "--staticpeers='{}'".format(el_static_nodes),
                "--http.api='eth,admin,debug,web3,txpool,trace,net,bor'",
                "--http.vhosts='*'",
                "--http.corsdomain='*'",
                "--http.addr='0.0.0.0'",
                "--http.port={}".format(ERIGON_RPC_PORT_NUMBER),
                "--snapshots=false",
            ]
        ),
    ]

    return plan.add_service(
        name=el_node_name,
        config=ServiceConfig(
            image=participant.get("el_image"),
            ports={
                ERIGON_RPC_PORT_ID: PortSpec(
                    number=ERIGON_RPC_PORT_NUMBER,
                    application_protocol="http",
                ),
            },
            files=files,
            entrypoint=["sh", "-c"],
            cmd=[
                "&&".join(validator_cmds + erigon_cmd if is_validator else erigon_cmd)
            ],
        ),
    )
