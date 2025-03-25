constants = import_module("../package_io/constants.star")
contract_util = import_module("../contracts/util.star")
el_cl_launcher = import_module("../el_cl_launcher.star")

PROMETHEUS_IMAGE = "prom/prometheus:v3.2.1"

GRAFANA_VERSION = "11.5.3"
GRAFANA_DASHBOARDS = "../../static_files/grafana/dashboards"

PANOPTICHAIN_IMAGE = "ghcr.io/0xpolygon/panoptichain:v1.2.3"
PANOPTICHAIN_PORT = 9090
PANOPTICHAIN_METRICS_PATH = "/metrics"


def launch(
    plan,
    l1_context,
    l1_chain_id,
    l2_participants,
    l2_chain_id,
    l2_el_genesis_artifact,
    contract_addresses_artifact,
):
    panoptichain_url = launch_panoptichain(
        plan,
        l1_context,
        l1_chain_id,
        l2_participants,
        l2_chain_id,
        l2_el_genesis_artifact,
        contract_addresses_artifact,
    )
    prometheus_url = launch_prometheus(plan, l2_participants, panoptichain_url)
    launch_grafana(plan, prometheus_url)


def launch_panoptichain(
    plan,
    l1_context,
    l1_chain_id,
    l2_participants,
    l2_chain_id,
    l2_el_genesis_artifact,
    contract_addresses_artifact,
):
    # Retrive L1 rpc urls.
    l1_rpcs = {}
    if l1_context.all_participants:
        for p in l1_context.all_participants:
            l1_rpcs[p.el_context.service_name] = p.el_context.rpc_http_url
    else:
        l1_rpcs = {"external-l1": l1_context.rpc_url}

    # Retrieve L2 EL and CL urls.
    l2_el_rpcs = {
        p.el_context.service_name: p.el_context.rpc_http_url for p in l2_participants
    }
    l2_cl_urls = {
        p.cl_context.service_name: {
            "heimdall": p.cl_context.api_url,
            "tendermint": p.cl_context.rpc_url,
        }
        for p in l2_participants
    }

    # Retrieve contract addresses.
    contract_addresses = contract_util.read_contract_addresses(
        plan, contract_addresses_artifact
    )
    state_receiver_contract_address = (
        contract_util.read_state_receiver_contract_address(plan, l2_el_genesis_artifact)
    )

    panoptichain_config_artifact = plan.render_templates(
        name="panoptichain-config",
        config={
            "config.yml": struct(
                template=read_file(src="../../static_files/panoptichain/config.yml"),
                data={
                    "l1_chain_id": l1_chain_id,
                    "l2_chain_id": l2_chain_id,
                    "l1_rpcs": l1_rpcs,
                    "l2_rpcs": l2_el_rpcs,
                    "heimdall_urls": l2_cl_urls,
                    "checkpoint_address": contract_addresses.get("root_chain"),
                    "state_sync_sender_address": contract_addresses.get("state_sender"),
                    "state_sync_receiver_address": state_receiver_contract_address,
                    "panoptichain_port": PANOPTICHAIN_PORT,
                    "panoptichain_metrics_path": PANOPTICHAIN_METRICS_PATH,
                },
            )
        },
    )

    service = plan.add_service(
        name="panoptichain",
        config=ServiceConfig(
            image=PANOPTICHAIN_IMAGE,
            ports={
                "metrics": PortSpec(PANOPTICHAIN_PORT, application_protocol="http"),
            },
            files={"/etc/panoptichain": panoptichain_config_artifact},
        ),
    )
    return service.ports["metrics"].url


def launch_prometheus(plan, l2_participants, panoptichain_url):
    metrics_jobs = generate_metrics_jobs(l2_participants, panoptichain_url)
    return import_module(constants.PROMETHEUS_PACKAGE).run(
        plan,
        metrics_jobs,
        name="prometheus",
        min_cpu=10,
        max_cpu=1000,
        min_memory=128,
        max_memory=2048,
        node_selectors=None,
        storage_tsdb_retention_time="1d",
        storage_tsdb_retention_size="512MB",
        image=PROMETHEUS_IMAGE,
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
    import_module(constants.GRAFANA_PACKAGE).run(
        plan,
        prometheus_url,
        name="grafana",
        grafana_version=GRAFANA_VERSION,
        grafana_dashboards_files_artifact=grafana_dashboards_files_artifact,
    )
