contract_util = import_module("../contracts/util.star")
constants = import_module("../config/constants.star")
shared = import_module("./shared.star")
util = import_module("./util.star")

PROMETHEUS_PACKAGE = "github.com/kurtosis-tech/prometheus-package/main.star@f5ce159aec728898e3deb827f6b921f8ecfc527f"

GRAFANA_PACKAGE = "github.com/kurtosis-tech/grafana-package/main.star@c8ff0b52d25deb0bc4ec95971dcf25b2fca11287"
GRAFANA_DASHBOARDS = "../../static_files/additional_services/grafana/dashboards"

PANOPTICHAIN_PORT = 9090
PANOPTICHAIN_METRICS_PATH = "/metrics"


def launch(
    plan,
    l1_context,
    l2_context,
    l2_el_genesis_artifact,
    contract_addresses_artifact,
):
    panoptichain_url = launch_panoptichain(
        plan,
        l1_context,
        l2_context,
        l2_el_genesis_artifact,
        contract_addresses_artifact,
    )
    prometheus_url = launch_prometheus(
        plan, l2_context.all_participants, panoptichain_url
    )
    launch_grafana(plan, prometheus_url)


def launch_panoptichain(
    plan,
    l1_context,
    l2_context,
    l2_el_genesis_artifact,
    contract_addresses_artifact,
):
    # Retrieve contract addresses.
    l1_root_chain_proxy_address = contract_util.get_address(
        plan,
        contract_name="l1_root_chain_proxy",
        contract_addresses_artifact=contract_addresses_artifact,
    )
    l1_state_sender_address = contract_util.get_address(
        plan,
        contract_name="l1_state_sender",
        contract_addresses_artifact=contract_addresses_artifact,
    )
    l2_state_receiver_address = contract_util.get_address(
        plan,
        contract_name="l2_state_receiver",
        l2_el_genesis_artifact=l2_el_genesis_artifact,
    )

    panoptichain_config_artifact = plan.render_templates(
        name="panoptichain-config",
        config={
            "config.yml": struct(
                template=read_file(
                    src="../../static_files/additional_services/panoptichain/config.yml"
                ),
                data={
                    "l1_chain_id": l1_context.chain_id,
                    "l2_chain_id": l2_context.el_chain_id,
                    "l1_rpcs": util.l1_rpcs(l1_context),
                    "l2_urls": util.l2_urls(l2_context),
                    "checkpoint_address": l1_root_chain_proxy_address,
                    "state_sync_sender_address": l1_state_sender_address,
                    "state_sync_receiver_address": l2_state_receiver_address,
                    "panoptichain_port": PANOPTICHAIN_PORT,
                    "panoptichain_metrics_path": PANOPTICHAIN_METRICS_PATH,
                },
            )
        },
    )

    service = plan.add_service(
        name="panoptichain",
        config=ServiceConfig(
            image=constants.ADDITIONAL_SERVICE_IMAGES.get("panoptichain_image"),
            ports={
                "metrics": PortSpec(PANOPTICHAIN_PORT, application_protocol="http"),
            },
            files={"/etc/panoptichain": panoptichain_config_artifact},
            max_cpu=shared.MAX_CPU,
            max_memory=shared.MAX_MEM,
        ),
    )
    return service.ports["metrics"].url


def launch_prometheus(plan, l2_participants, panoptichain_url):
    metrics_jobs = generate_metrics_jobs(l2_participants, panoptichain_url)
    return import_module(PROMETHEUS_PACKAGE).run(
        plan,
        metrics_jobs,
        name="prometheus",
        min_cpu=10,
        max_cpu=shared.MAX_CPU,
        min_memory=128,
        max_memory=shared.MAX_MEM,
        node_selectors=None,
        storage_tsdb_retention_time="1d",
        storage_tsdb_retention_size="512MB",
        image=constants.ADDITIONAL_SERVICE_IMAGES.get("prometheus_image"),
    )


def generate_metrics_jobs(l2_participants, panoptichain_url):
    unique_metrics_jobs = {}
    metrics_jobs = [
        {
            "Name": "panoptichain",
            "Endpoint": panoptichain_url.removeprefix("http://"),
            "MetricsPath": PANOPTICHAIN_METRICS_PATH,
        }
    ]
    for p in l2_participants:
        for context in [p.cl_context, p.el_context]:
            if context.service_name not in unique_metrics_jobs:
                unique_metrics_jobs[context.service_name] = {
                    "Name": context.service_name,
                    "Endpoint": context.metrics_url.removeprefix("http://"),
                    "MetricsPath": "/debug/metrics/prometheus",
                }
                metrics_jobs.append(unique_metrics_jobs[context.service_name])
    return metrics_jobs


def launch_grafana(plan, prometheus_url):
    grafana_dashboards_files_artifact = plan.upload_files(
        src=GRAFANA_DASHBOARDS, name="grafana-dashboards"
    )
    # no max cpu or mem limits for grafana
    import_module(GRAFANA_PACKAGE).run(
        plan,
        prometheus_url,
        name="grafana",
        image=constants.ADDITIONAL_SERVICE_IMAGES.get("grafana_image"),
        grafana_dashboards_files_artifact=grafana_dashboards_files_artifact,
    )
