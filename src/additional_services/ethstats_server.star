constants = import_module("../config/constants.star")
shared = import_module("./shared.star")


def launch(
    plan,
    ethstats_server_params,
):
    service = plan.add_service(
        name="ethstats-server",
        config=ServiceConfig(
            image=ethstats_server_params.get("image"),
            ports={
                "http": PortSpec(
                    constants.ETHSTATS_SERVER_PORT_NUMBER, application_protocol="http"
                )
            },
            env_vars={
                "WS_SECRET": ethstats_server_params.get("ws_secret"),
            },
            max_cpu=shared.MAX_CPU,
            max_memory=shared.MAX_MEM,
        ),
    )
