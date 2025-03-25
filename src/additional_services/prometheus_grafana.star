constants = import_module("../package_io/constants.star")
contract_util = import_module("../contracts/util.star")
el_cl_launcher = import_module("../el_cl_launcher.star")

PROMETHEUS_IMAGE = "prom/prometheus:v3.2.0"
GRAFANA_VERSION = "11.5.2"
GRAFANA_DASHBOARDS = "../../static_files/grafana/dashboards"
PANOPTICHAIN_IMAGE = "ghcr.io/0xpolygon/panoptichain:v1.2.2"  # https://github.com/0xPolygon/panoptichain/releases


def launch(
    plan,
    l1_participants,
    l1_chain_id,
    l2_participants,
    l2_chain_id,
    l2_el_genesis_artifact,
    contract_addresses_artifact,
):
    launch_panoptichain(
        plan,
        l1_participants,
        l1_chain_id,
        l2_participants,
        l2_chain_id,
        l2_el_genesis_artifact,
        contract_addresses_artifact,
    )
    prometheus_url = launch_prometheus(plan, l2_participants)
    launch_grafana(plan, prometheus_url)


def launch_panoptichain(
    plan,
    l1_rpcs,
    l1_chain_id,
    l2_participants,
    l2_chain_id,
    l2_el_genesis_artifact,
    contract_addresses_artifact,
):
    # Retrieve contract addresses.
    contract_addresses = contract_util.read_contract_addresses(
        plan, contract_addresses_artifact
    )
    state_receiver_contract_address = (
        contract_util.read_state_receiver_contract_address(plan, l2_el_genesis_artifact)
    )

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
                },
            )
        },
    )

    plan.add_service(
        name="panoptichain",
        config=ServiceConfig(
            image=PANOPTICHAIN_IMAGE,
            ports={
                "metrics": PortSpec(9090, application_protocol="http"),
            },
            files={"/etc/panoptichain": panoptichain_config_artifact},
        ),
    )


def launch_prometheus(plan, l2_participants):
    metrics_jobs = generate_metrics_jobs(l2_participants)
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


def generate_metrics_jobs(l2_participants):
    metrics_paths = ["/metrics", "/debug/metrics/prometheus"]
    unique_metrics_jobs = {}
    metrics_jobs = []

    for p in l2_participants:
        for context in [p.cl_context, p.el_context]:
            for m in metrics_paths:
                job_key = (context.service_name, m)
                if job_key not in unique_metrics_jobs:
                    unique_metrics_jobs[job_key] = {
                        "Name": context.service_name + m,
                        "Endpoint": context.metrics_url.removeprefix("http://"),
                        "MetricsPath": m,
                    }
                    metrics_jobs.append(unique_metrics_jobs[job_key])

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
