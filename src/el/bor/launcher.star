constants = import_module("../../config/constants.star")
shared = import_module("../shared.star")

# The folder where the bor template config is stored in the repository.
BOR_TEMPLATE_CONFIG_FILE_PATH = "../../../static_files/el/bor/config.toml"

# The folder where bor configs are stored inside the service.
BOR_CONFIG_FOLDER_PATH = "/etc/bor"
# The folder where bor app stores data inside the service.
BOR_APP_DATA_FOLDER_PATH = "/var/lib/bor"


def launch(
    plan,
    el_node_name,
    id,
    participant,
    network_params,
    el_genesis_artifact,
    el_keys_artifact,
    cl_api_urls,
    cl_ws_rpc_urls,
    el_account,
    el_static_nodes,
    el_validator_rpc_urls,
    container_proc_manager_artifact,
    ethstats_server_params,
):
    ethstats_server_secret = ""
    if ethstats_server_params:
        ethstats_server_secret = ethstats_server_params.get("ws_secret")

    # Resolve bp-rpc-endpoints for the relayer. If the participant did not
    # provide an explicit override, default to every validator EL service in
    # the cluster (in-cluster DNS, http, port 8545). Pre-render as a TOML list
    # literal so the template body stays simple.
    enable_private_tx_relay = participant.get("el_bor_enable_private_tx_relay")
    accept_private_tx = participant.get("el_bor_accept_private_tx")
    bp_endpoints = list(participant.get("el_bor_private_tx_bp_endpoints") or [])
    if enable_private_tx_relay and len(bp_endpoints) == 0:
        bp_endpoints = list(el_validator_rpc_urls)
    if enable_private_tx_relay and len(bp_endpoints) == 0:
        fail(
            "Participant '{}' has el_bor_enable_private_tx_relay=True but no validator EL nodes are present in the network and no el_bor_private_tx_bp_endpoints override was provided.".format(
                el_node_name
            )
        )
    bp_rpc_endpoints_toml = (
        "[" + ", ".join(['"{}"'.format(u) for u in bp_endpoints]) + "]"
    )

    # Bor supports comma-separated Heimdall endpoints natively via
    # eth/ethconfig/config.go::parseURLs — the [heimdall].url field
    # accepts the list and MultiHeimdallClient cascades on failure.
    # When a single URL is passed (the common case), this produces the
    # same string as the pre-multi-Heimdall code path.
    cl_api_url = ",".join(cl_api_urls) if cl_api_urls else ""
    cl_ws_rpc_url = ",".join(cl_ws_rpc_urls) if cl_ws_rpc_urls else ""

    # Extra bor CLI flags from the participant, appended verbatim to the
    # `bor server` command where they take precedence over config.toml. This is
    # an escape hatch for flags the package does not model as first-class
    # fields (e.g. --p2p.nosnap, --miner.disable-pending-block, --grpc.token).
    # Provide a list of already-split tokens, e.g.
    #   el_bor_extra_args:
    #     - "--p2p.nosnap"
    #     - "--grpc.addr"
    #     - "0.0.0.0:3131"
    # Tokens are space-joined; values containing spaces are not supported (use
    # a dedicated participant field or genesis override for those). They are
    # interpolated UNESCAPED into the `sh -c` command below — same trust model
    # as static_nodes / bp_rpc_endpoints_toml: operator-authored devnet config,
    # not untrusted input. Do not feed externally-sourced values here.
    el_extra_args = participant.get("el_bor_extra_args") or []
    extra_args_str = " ".join([str(a) for a in el_extra_args])

    bor_node_config_artifact = plan.render_templates(
        name="{}-config".format(el_node_name),
        config={
            "config.toml": struct(
                template=read_file(BOR_TEMPLATE_CONFIG_FILE_PATH),
                data={
                    # node params
                    "node_name": el_node_name,
                    "config_folder_path": BOR_CONFIG_FOLDER_PATH,
                    "data_folder_path": BOR_APP_DATA_FOLDER_PATH,
                    "kind": participant.get("kind"),
                    "address": el_account.eth_tendermint.address,
                    "cl_api_url": cl_api_url,
                    "cl_ws_rpc_url": cl_ws_rpc_url,
                    "log_level_to_int": log_level_to_int(
                        participant.get("el_log_level")
                    ),
                    "json_log_enabled": participant.get("el_log_format")
                    == constants.LOG_FORMAT.json,
                    "extradata": "bor-{}".format(id),
                    "produce_witness": participant.get("el_bor_produce_witness"),
                    "sync_with_witness": participant.get("el_bor_sync_with_witness"),
                    "stateless_parallel_import": participant.get(
                        "el_bor_stateless_parallel_import"
                    ),
                    "archive_mode": participant.get("el_bor_archive_mode"),
                    # network params
                    "static_nodes": str(el_static_nodes),
                    "el_gas_limit": network_params.get("el_gas_limit"),
                    "el_block_interval_seconds": network_params.get(
                        "el_block_interval_seconds"
                    ),
                    "ethstats_server_secret": ethstats_server_secret,
                    # relay (private tx)
                    "accept_private_tx": accept_private_tx,
                    "enable_private_tx_relay": enable_private_tx_relay,
                    "bp_rpc_endpoints_toml": bp_rpc_endpoints_toml,
                    # ports
                    "rpc_port_number": shared.RPC_PORT_NUMBER,
                    "ws_port_number": shared.WS_PORT_NUMBER,
                    "discovery_port_number": shared.DISCOVERY_PORT_NUMBER,
                    "metrics_port_number": shared.METRICS_PORT_NUMBER,
                    "pprof_port_number": shared.PPROF_PORT_NUMBER,
                    "grpc_port_number": shared.GRPC_PORT_NUMBER,
                    # Only expose bor's gRPC server on all interfaces when the
                    # paired heimdall dials it over gRPC; otherwise bor keeps its
                    # own (loopback-only on >= v2.8.3) default. See the gated
                    # [grpc] block in the bor config.toml template.
                    "cl_bor_grpc_flag": participant.get("cl_bor_grpc_flag"),
                    "ethstats_server_port_number": constants.ETHSTATS_SERVER_PORT_NUMBER,
                },
            ),
        },
    )

    bor_cmds = [
        # Copy genesis file.
        "cp /opt/data/genesis/genesis.json {}/genesis.json".format(
            BOR_CONFIG_FOLDER_PATH
        ),
        # Copy keys.
        "cp /opt/data/keys/password.txt {}".format(BOR_CONFIG_FOLDER_PATH),
        "mkdir -p {}".format(BOR_APP_DATA_FOLDER_PATH),
        "cp /opt/data/keys/nodekey {}/nodekey".format(BOR_APP_DATA_FOLDER_PATH),
        "cp -r /opt/data/keys/keystore {}".format(BOR_APP_DATA_FOLDER_PATH),
        # Start bor using the container proc manager script. el_bor_extra_args
        # (if any) are appended after --config so they override config.toml.
        "/usr/local/share/container-proc-manager.sh bor server --config {}/config.toml{}".format(
            BOR_CONFIG_FOLDER_PATH,
            " " + extra_args_str if extra_args_str else "",
        ),
    ]

    # bor's gRPC port is published only when the paired heimdall dials bor over
    # gRPC (cl_bor_grpc_flag) — the same gate as the [grpc] block in the bor
    # config.toml template. With the flag off (the default) bor binds gRPC
    # loopback-only, so there is no externally-reachable server to publish.
    # NOTE: when the flag is on this publishes bor's gRPC admin API
    # unauthenticated over plaintext; heimdall refuses to send a bearer token
    # over non-local plaintext (x/bor/grpc/client.go), so authenticating it
    # would require TLS on bor's gRPC. Treat cl_bor_grpc_flag as devnet-only.
    el_ports = {
        shared.RPC_PORT_ID: PortSpec(
            number=shared.RPC_PORT_NUMBER,
            application_protocol="http",
        ),
        shared.WS_PORT_ID: PortSpec(
            number=shared.WS_PORT_NUMBER,
            application_protocol="ws",
        ),
        shared.DISCOVERY_PORT_ID: PortSpec(
            number=shared.DISCOVERY_PORT_NUMBER,
            application_protocol="http",
        ),
        shared.METRICS_PORT_ID: PortSpec(
            number=shared.METRICS_PORT_NUMBER,
            application_protocol="http",
        ),
        shared.PPROF_PORT_ID: PortSpec(
            number=shared.PPROF_PORT_NUMBER,
            application_protocol="http",
        ),
    }
    if participant.get("cl_bor_grpc_flag"):
        el_ports[shared.GRPC_PORT_ID] = PortSpec(
            number=shared.GRPC_PORT_NUMBER,
            application_protocol="grpc",
        )

    return plan.add_service(
        name=el_node_name,
        config=ServiceConfig(
            image=participant.get("el_image"),
            # All port checks are disabled, see the comment above.
            ports=el_ports,
            files={
                # app data
                BOR_APP_DATA_FOLDER_PATH: Directory(
                    persistent_key="{}-data".format(el_node_name)
                ),
                # config
                BOR_CONFIG_FOLDER_PATH: bor_node_config_artifact,
                "/opt/data/genesis": el_genesis_artifact,
                "/opt/data/keys": el_keys_artifact,
                # utils scripts
                "/usr/local/share": container_proc_manager_artifact,
            },
            entrypoint=["sh", "-c"],
            cmd=[" && ".join(bor_cmds)],
            max_cpu=shared.MAX_CPU,
            max_memory=shared.MAX_MEM,
        ),
    )


# Bor log level must be specified using an integer instead of a string.
# https://github.com/0xPolygon/bor/blob/ceb62bb9d3b91b57579f674f5823f7becbd01df8/internal/cli/server/server.go#L86
def log_level_to_int(log_level):
    map_log_level_to_int = {
        "trace": 5,
        "debug": 4,
        "info": 3,
        "warn": 2,
        "error": 1,
        "crit": 0,
    }
    if log_level not in map_log_level_to_int:
        fail("Invalid log level: " + log_level)
    return map_log_level_to_int.get(log_level)
