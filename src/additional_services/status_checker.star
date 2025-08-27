util = import_module("./util.star")


def launch(
    plan,
    status_checker_params,
    l1_context,
    l2_context,
):
    l1_rpcs = util.l1_rpcs(l1_context)
    l2_urls = util.l2_urls(l2_context)

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
        src="../../static_files/additional_services/status-checker/checks",
        name="status-checker-checks",
    )

    plan.add_service(
        name="status-checker",
        config=ServiceConfig(
            image=status_checker_params.get("image"),
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
                "L1_RPCS": json.encode(l1_rpcs),
                "L2_URLS": json.encode(l2_urls),
            },
        ),
    )
