prometheus_package = import_module(
    "github.com/kurtosis-tech/prometheus-package/main.star"
)
grafana_package = import_module(
    "github.com/kurtosis-tech/grafana-package/main.star@6772a4e4ae07cf5256b8a10e466587b73119bab5"
)

PROMETHEUS_IMAGE = "prom/prometheus:v3.0.1"
GRAFANA_VERSION = "11.1.4"
GRAFANA_DASHBOARDS = "github.com/0xPolygon/kurtosis-cdk/static_files/additional_services/grafana-config/dashboards"

def get_metrics_jobs(plan):
    metrics_jobs = []
    for service in plan.get_services():
        if "metrics" not in service.ports:
            continue

        metrics_paths = ["/metrics", "/debug/metrics/prometheus"]

        for metrics_path in metrics_paths:
            metrics_jobs.append(
                {
                    "Name": service.name + metrics_path,
                    "Endpoint": "{0}:{1}".format(
                        service.ip_address, service.ports["metrics"].number
                    ),
                    "MetricsPath": metrics_path,
                }
            )

    return metrics_jobs


def launch(plan):
    metrics_jobs = get_metrics_jobs(plan)

    prometheus_url = prometheus_package.run(
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

    grafana_package.run(
        plan,
        prometheus_url,
        GRAFANA_DASHBOARDS,
        name="grafana",
        grafana_version=GRAFANA_VERSION,
    )
