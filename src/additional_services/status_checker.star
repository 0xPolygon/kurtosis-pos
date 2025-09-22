util = import_module("./util.star")


def launch(
    plan,
    status_checker_params,
    l1_context,
    l2_context,
    l2_el_genesis_artifact,
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

    common_checks_artifact = plan.upload_files(
        src="../../static_files/additional_services/status-checker/checks/common",
        name="status-checker-common-checks",
    )
    status_checker_artifacts = [common_checks_artifact]

    rio_block = get_rio_block(plan, l2_el_genesis_artifact)
    rio_enabled = rio_block != "null"
    if rio_enabled:
        rio_checks_artifact = plan.upload_files(
            src="../../static_files/additional_services/status-checker/checks/rio",
            name="status-checker-rio-checks",
        )
        status_checker_artifacts.append(rio_checks_artifact)

    plan.add_service(
        name="status-checker",
        config=ServiceConfig(
            image=status_checker_params.get("image"),
            files={
                "/etc/status-checker": Directory(
                    artifact_names=[status_checker_config_artifact]
                ),
                "/opt/status-checker/checks": Directory(
                    artifact_names=status_checker_artifacts
                ),
            },
            ports={"metrics": PortSpec(9090, application_protocol="http")},
            env_vars={
                "L1_RPCS": json.encode(l1_rpcs),
                "L2_URLS": json.encode(l2_urls),
            },
        ),
    )


def get_rio_block(plan, l2_el_genesis_artifact):
    result = plan.run_sh(
        name="rio-block-reader",
        description="Reading rio block from the L2 EL genesis",
        files={
            "/tmp": l2_el_genesis_artifact,
        },
        run="jq --raw-output '.config.bor.rioBlock' /tmp/genesis.json | tr -d '\n'",
    )
    return result.output
