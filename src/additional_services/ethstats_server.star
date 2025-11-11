def launch(
    plan,
    ethstats_server_params,
):
    service = plan.add_service(
        name="ethstats-server",
        config=ServiceConfig(
            image=ethstats_server_params.get("image"),
            ports={"http": PortSpec(3000, application_protocol="http")},
            env_vars={
                "WS_SECRET": ethstats_server_params.get("ws_secret"),
            },
        ),
    )

    return service.ports["http"].url.replace("http://", "")
