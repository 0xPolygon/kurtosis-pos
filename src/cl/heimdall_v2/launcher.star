constants = import_module("../../config/constants.star")
shared = import_module("../shared.star")


# The folder where the heimdall templates are stored in the repository.
HEIMDALL_TEMPLATES_FOLDER_PATH = "../../../static_files/cl/heimdall_v2"

# Minimum bor version whose gRPC BorApi is complete enough for heimdall's gRPC
# transport. bor #2194 ("full grpc implementation", first released in
# v2.8.3-beta5) added BOTH GetBlockInfoInBatch AND full proto-Header population.
# Older bor (<= 2.8.2, 2.7.x) returns Unimplemented for GetBlockInfoInBatch and
# emits a 3-field header, so a heimdall on the gRPC transport (the default since
# #631) cannot generate milestone propositions — the milestone never reaches the
# 2/3 majority that gates VeBLOP span rotation and the chain is stuck at span 0
# (deploy then times out at the wait.star l2-startup-monitor). Pin heimdall to
# the HTTP transport (bor_rpc_url, which every bor version serves) for older bor.
BOR_GRPC_MIN_VERSION = (2, 8, 3)


def _bor_image_version(el_image):
    """Parse (major, minor, patch) from a bor image ref's tag, or None.

    Strips the tag after the final ':' (a registry host:port keeps its own ':',
    so rsplit(1) still isolates the tag), a leading 'v', and any -prerelease or
    +build suffix (so v2.8.3-beta5 -> (2, 8, 3), matching bor's release lineage:
    #2194 landed in the 2.8.3 betas). Returns None for untagged or non-semver
    tags (e.g. branch/commit images), which then default to the safe HTTP path.
    """
    if ":" not in el_image:
        return None
    base = el_image.rsplit(":", 1)[-1].lstrip("v").split("-")[0].split("+")[0]
    parts = base.split(".")
    if len(parts) < 3:
        return None
    nums = []
    for p in parts[:3]:
        if not p.isdigit():
            return None
        nums.append(int(p))
    return (nums[0], nums[1], nums[2])


def launch(
    plan,
    cl_node_name,
    participant,
    network_params,
    cl_genesis_artifact,
    cl_keys_artifact,
    cl_node_ids,
    l1_rpc_url,
    el_rpc_url,
    el_grpc_url,
    amqp_url,
    container_proc_manager_artifact,
    producer_votes_str,
):
    # heimdall dials bor over gRPC (the default since #631) ONLY when the paired
    # EL both speaks bor's gRPC AND speaks the complete version of it:
    #   * el_type must be bor — erigon implements bor's HTTP RPC but NOT its gRPC
    #     server, so an erigon-paired heimdall on gRPC would dial an endpoint that
    #     is never served (refused connections, no block/header/state-sync data).
    #   * the bor version must be >= BOR_GRPC_MIN_VERSION — older bor lacks
    #     #2194's GetBlockInfoInBatch + full proto-Header, which stalls span
    #     rotation (see BOR_GRPC_MIN_VERSION). Unparseable tags default to HTTP.
    # When gRPC is off, heimdall short-circuits its gRPC init and uses the HTTP
    # transport (bor_rpc_url), so leave the gRPC URL empty.
    el_is_bor = participant.get("el_type") == constants.EL_TYPE.bor
    bor_version = _bor_image_version(participant.get("el_image") or "")
    bor_grpc_supported = (
        el_is_bor and bor_version != None and bor_version >= BOR_GRPC_MIN_VERSION
    )
    bor_grpc_flag = "true" if bor_grpc_supported else "false"
    bor_grpc_url = el_grpc_url if bor_grpc_supported else ""

    heimdall_node_config_artifacts = plan.render_templates(
        name="{}-config".format(cl_node_name),
        config={
            "app.toml": struct(
                template=read_file(
                    "{}/app.toml".format(HEIMDALL_TEMPLATES_FOLDER_PATH)
                ),
                data={
                    "kind": participant.get("kind"),
                    # Network params.
                    "cl_environment": network_params.get("cl_environment"),
                    "cl_min_retain_blocks": participant.get("cl_min_retain_blocks"),
                    "span_poll_interval": network_params.get("cl_span_poll_interval"),
                    "checkpoint_poll_interval": network_params.get(
                        "cl_checkpoint_poll_interval"
                    ),
                    "producer_votes": producer_votes_str,
                    # URLs.
                    "amqp_url": amqp_url,
                    # bor_rpc_url: the participant's comma-separated bor RPC URL
                    # list (cl_bor_rpc_urls) when set — >= 2 endpoints enable
                    # heimdall-v2 bor-endpoint failover (#605) — else the
                    # co-located bor EL's single RPC URL (previous behavior).
                    "bor_rpc_url": participant.get("cl_bor_rpc_urls") or el_rpc_url,
                    "bor_grpc_flag": bor_grpc_flag,
                    "bor_grpc_url": bor_grpc_url,
                    "l1_rpc_url": l1_rpc_url,
                    # Port numbers.
                    "rest_api_port_number": shared.REST_API_PORT_NUMBER,
                    "grpc_port_number": shared.GRPC_PORT_NUMBER,
                    "rpc_port_number": shared.RPC_PORT_NUMBER,
                },
            ),
            "client.toml": struct(
                template=read_file(
                    "{}/client.toml".format(HEIMDALL_TEMPLATES_FOLDER_PATH),
                ),
                data={
                    "cl_chain_id": constants.CL_CHAIN_ID,
                    "rpc_port_number": shared.RPC_PORT_NUMBER,
                },
            ),
            "config.toml": struct(
                template=read_file(
                    "{}/config.toml".format(HEIMDALL_TEMPLATES_FOLDER_PATH)
                ),
                data={
                    # Node params.
                    "moniker": cl_node_name,
                    "log_level": participant.get("cl_log_level"),
                    "log_format": participant.get("cl_log_format"),
                    "persistent_peers": cl_node_ids,
                    "cl_compact_enabled": participant.get("cl_compact_enabled"),
                    "cl_compaction_interval": participant.get("cl_compaction_interval"),
                    "cl_storage_pruning_interval": participant.get(
                        "cl_storage_pruning_interval"
                    ),
                    "cl_indexer_pruning_enabled": participant.get(
                        "cl_indexer_pruning_enabled"
                    ),
                    # Port numbers.
                    "proxy_app_port_number": shared.PROXY_LISTEN_PORT_NUMBER,
                    "rpc_port_number": shared.RPC_PORT_NUMBER,
                    "p2p_listen_port_number": shared.NODE_LISTEN_PORT_NUMBER,
                    "metrics_port_number": shared.METRICS_PORT_NUMBER,
                    "pprof_port_number": shared.PPROF_PORT_NUMBER,
                },
            ),
        },
    )

    is_validator = participant.get("kind") == constants.PARTICIPANT_KIND.validator
    if is_validator:
        heimdall_cmds = [
            " && ".join(
                [
                    # Copy CL genesis, node and validator keys inside heimdall config folder.
                    "cp /opt/data/genesis/genesis.json /opt/data/keys/node_key.json /opt/data/keys/priv_validator_key.json {}/config/".format(
                        shared.CONFIG_FOLDER_PATH
                    ),
                    "mkdir -p {}/data".format(shared.CONFIG_FOLDER_PATH),
                    "cp /opt/data/keys/priv_validator_state.json {}/data/priv_validator_state.json".format(
                        shared.CONFIG_FOLDER_PATH
                    ),
                    # Heimdall-v2 requires that the `round` property of priv_validator_state.json be of type int32.
                    'sed -i \'s/"round": "\\([0-9]*\\)"/"round": \\1/\' {}/data/priv_validator_state.json'.format(
                        shared.CONFIG_FOLDER_PATH
                    ),
                    # Start heimdall with the bridge using the container proc manager script.
                    "/usr/local/share/container-proc-manager.sh heimdalld start --all --bridge --home {} --log_no_color --rest-server".format(
                        shared.CONFIG_FOLDER_PATH,
                    ),
                ]
            )
        ]
    else:
        heimdall_cmds = [
            " && ".join(
                [
                    # Copy CL genesis inside heimdall config folder.
                    "cp /opt/data/genesis/genesis.json {}/config/".format(
                        shared.CONFIG_FOLDER_PATH
                    ),
                    # Auto-generate node keys (no pre-generated validator keys for rpc/archive nodes).
                    # `--overwrite` keeps `heimdalld init` idempotent across a
                    # `kurtosis service stop`/`start`: that restarts the *same*
                    # container, so /tmp/init-data survives. Without it the second
                    # boot aborts with "genesis.json file already exists" before
                    # `heimdalld start`, the container exits, and the node never
                    # comes back (the `rpc` port is dropped). Only genesis.json is
                    # rewritten; existing node_key/priv_validator_key are kept, so
                    # the P2P node ID stays stable.
                    "heimdalld init {} --home /tmp/init-data --overwrite".format(
                        cl_node_name
                    ),
                    "cp /tmp/init-data/config/node_key.json /tmp/init-data/config/priv_validator_key.json {}/config/".format(
                        shared.CONFIG_FOLDER_PATH
                    ),
                    "mkdir -p {}/data".format(shared.CONFIG_FOLDER_PATH),
                    "cp /tmp/init-data/data/priv_validator_state.json {}/data/priv_validator_state.json".format(
                        shared.CONFIG_FOLDER_PATH
                    ),
                    # Heimdall-v2 requires that the `round` property of priv_validator_state.json be of type int32.
                    'sed -i \'s/"round": "\\([0-9]*\\)"/"round": \\1/\' {}/data/priv_validator_state.json'.format(
                        shared.CONFIG_FOLDER_PATH
                    ),
                    # Start heimdall without the bridge using the container proc manager script.
                    "/usr/local/share/container-proc-manager.sh heimdalld start --all --home {} --log_no_color --rest-server".format(
                        shared.CONFIG_FOLDER_PATH,
                    ),
                ]
            )
        ]

    files = {
        # app data
        shared.APP_DATA_FOLDER_PATH: Directory(
            persistent_key="{}-data".format(cl_node_name)
        ),
        "{}/data".format(shared.CONFIG_FOLDER_PATH): Directory(
            persistent_key="{}-config-data".format(cl_node_name)
        ),
        "{}/bridge".format(shared.CONFIG_FOLDER_PATH): Directory(
            persistent_key="{}-bridge-data".format(cl_node_name)
        ),
        # config
        "{}/config".format(shared.CONFIG_FOLDER_PATH): heimdall_node_config_artifacts,
        "/opt/data/genesis": cl_genesis_artifact,
        # utils scripts
        "/usr/local/share": container_proc_manager_artifact,
    }
    if is_validator:
        files["/opt/data/keys"] = cl_keys_artifact

    return plan.add_service(
        name="{}".format(cl_node_name),
        config=ServiceConfig(
            image=participant.get("cl_image"),
            ports={
                shared.REST_API_PORT_ID: PortSpec(
                    number=shared.REST_API_PORT_NUMBER,
                    application_protocol="http",
                ),
                shared.GRPC_PORT_ID: PortSpec(
                    number=shared.GRPC_PORT_NUMBER,
                    application_protocol="grpc",
                ),
                shared.NODE_LISTEN_PORT_ID: PortSpec(
                    number=shared.NODE_LISTEN_PORT_NUMBER,
                    application_protocol="http",
                ),
                shared.RPC_PORT_ID: PortSpec(
                    number=shared.RPC_PORT_NUMBER,
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
            },
            files=files,
            entrypoint=["sh", "-c"],
            cmd=[" && ".join(heimdall_cmds)],
            max_cpu=shared.MAX_CPU,
            max_memory=shared.MAX_MEM,
        ),
    )
