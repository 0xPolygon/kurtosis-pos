bor_launcher = import_module("./bor/launcher.star")
constants = import_module("../package_io/constants.star")
context = import_module("./context.star")
erigon_launcher = import_module("./erigon/launcher.star")
shared = import_module("./shared.star")

LAUNCHERS = {
    constants.EL_TYPE.bor: bor_launcher.launch,
    constants.EL_TYPE.erigon: erigon_launcher.launch,
}


def launch(
    plan,
    participant,
    id,
    is_validator,
    el_genesis_artifact,
    el_validator_config_artifact,
    cl_api_url,
    el_account,
    el_static_nodes,
    el_chain_id,
):
    launch_method = _get_launcher(plan, participant)
    el_node_name = generate_name(participant, id, is_validator)
    service = launch_method(
        plan,
        el_node_name,
        participant,
        el_genesis_artifact,
        el_validator_config_artifact,
        cl_api_url,
        el_account,
        el_static_nodes,
        el_chain_id,
    )

    return context.new_context(
        service_name=el_node_name,
        rpc_http_url=service.ports[shared.RPC_PORT_ID].url,
        ws_url=service.ports[shared.WS_PORT_ID].url,
        metrics_url=service.ports[shared.METRICS_PORT_ID].url,
    )


def _get_launcher(participant):
    el_type = participant.get("el_type")
    if el_type not in LAUNCHERS:
        fail(
            "Unsupported EL launcher '{0}', need one of '{1}'".format(
                el_type, ",".join(LAUNCHERS.keys())
            )
        )
    return LAUNCHERS.get(el_type)


def generate_name(participant, id, is_validator=False):
    cl_type = participant.get("cl_type")
    el_type = participant.get("el_type")
    suffix = "validator" if is_validator else "rpc"
    return "l2-el-{}-{}-{}-{}".format(
        id,
        el_type,
        cl_type,
        suffix,
    )
