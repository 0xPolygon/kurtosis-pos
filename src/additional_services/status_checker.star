STATUS_CHECKER_IMAGE = "ghcr.io/0xpolygon/status-checker:v0.2.8"


def launch(
    plan,
    l1_context,
    l2_context,
):
    # Retrieve L1 RPC URLs.
    l1_rpcs = {}
    if l1_context.all_participants:
        for p in l1_context.all_participants:
            l1_rpcs[p.el_context.service_name] = p.el_context.rpc_http_url
    else:
        l1_rpcs = {"external-l1": l1_context.rpc_url}

    # Retrieve L2 EL and CL URLs.
    l2_urls = {
        p.el_context.service_name: {
            "rpc": p.el_context.rpc_http_url,
            "heimdall": p.cl_context.api_url,
            "tendermint": p.cl_context.rpc_url,
        }
        for p in l2_context.all_participants
    }

    status_checker_config_artifact = plan.render_templates(
        name="status-checker-config",
        config={
            "config.yml": struct(
                template=read_file(
                    src="../../static_files/additional_services/status-checker/config.yml",
                ),
                data={},
            ),
        },
    )

    status_checker_checks_artifact = plan.upload_files(
        src="../../static_files/additional_services/status-checker-config/checks",
        name="status-checker-checks",
    )

    plan.add_service(
        name="status-checker",
        config=ServiceConfig(
            image=STATUS_CHECKER_IMAGE,
            files={
                "/etc/status-checker": Directory(
                    artifact_names=[status_checker_config_artifact]
                ),
                "/opt/status-checker/checks": Directory(
                    artifact_names=[status_checker_checks_artifact]
                ),
            },
            ports={"metrics": PortSpec(9090, application_protocol="http")},
            env_vars={
                "L1_RPCS": l1_rpcs,
                "L2_URLS": l2_urls,
            },
        ),
    )
