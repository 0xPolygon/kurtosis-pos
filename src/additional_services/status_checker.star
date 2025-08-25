config_util = import_module("../config/util.star")

STATUS_CHECKER_IMAGE = "ghcr.io/0xpolygon/status-checker:v0.2.8"


def launch(
    plan,
    l1_context,
    l2_context,
):
    l1_rpcs = config_util.l1_rpcs(l1_context)
    l2_urls = config_util.l2_urls(l2_context)

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
                "L1_RPCS": json.encode(l1_rpcs),
                "L2_URLS": json.encode(l2_urls),
            },
        ),
    )
