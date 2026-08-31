constants = import_module("../config/constants.star")

# Sequence store: a Redpanda-backed preconfirmation store. Bor validators
# publish their block lifecycle to the ingress; bor RPC nodes consume the
# gateway stream and serve preconfirmation receipts. The store is enclave-
# internal: bor reaches it via the service names below, and each fresh
# enclave gets a fresh chain (required — the producer anchors onto an
# empty store).

SEQSTORE_INGRESS_SERVICE_NAME = constants.SEQSTORE_INGRESS_SERVICE_NAME
SEQSTORE_GATEWAY_SERVICE_NAME = constants.SEQSTORE_GATEWAY_SERVICE_NAME
SEQSTORE_AUDITOR_SERVICE_NAME = "seqstore-auditor"
REDPANDA_SERVICE_NAME = "seqstore-redpanda"

SEQSTORE_GRPC_PORT_NUMBER = constants.SEQSTORE_GRPC_PORT_NUMBER
SEQSTORE_OPS_PORT_NUMBER = 9600
REDPANDA_KAFKA_PORT_NUMBER = 9092
REDPANDA_RPC_PORT_NUMBER = 33145
REDPANDA_ADMIN_PORT_NUMBER = 9644
ENVOY_ADMIN_PORT_NUMBER = 9901
ENVOY_TEMPLATE_CONFIG_FILE_PATH = "../../static_files/sequencer/envoy.yaml"

SEQSTORE_TOPIC = "chain"

# Every seqstore role (ingress, gateway, auditor) serves Prometheus metrics
# on its ops port at this path (see 0xPolygon/sequence-store internal/ops).
SEQSTORE_METRICS_PATH = "/metrics"

# Redpanda's admin API already binds 0.0.0.0:9644 by default -- no flag
# needed for Prometheus to reach it, just the port declared below (`rpk
# redpanda start` has no --admin-addr flag; passing one is rejected by the
# underlying binary). /public_metrics is Redpanda's recommended,
# cheaper-to-scrape subset; the legacy /metrics endpoint carries many more
# internal series.
REDPANDA_METRICS_PATH = "/public_metrics"

# Envoy's admin interface serves its own Prometheus-format stats here
# (request/connection counts, health-check state per gateway upstream).
ENVOY_METRICS_PATH = "/stats/prometheus"

# Resource caps, following the per-service limits every other launcher
# sets. Redpanda runs --smp=1 but pre-allocates memory aggressively.
REDPANDA_MAX_CPU = 2000  # in millicores (2 cores)
REDPANDA_MAX_MEM = 16384  # in megabytes (16 GB)
SEQSTORE_MAX_CPU = 1000  # in millicores (1 core)
SEQSTORE_MAX_MEM = 16384  # in megabytes (16 GB)
ENVOY_MAX_CPU = 1000  # in millicores (1 core)
ENVOY_MAX_MEM = 16384  # in megabytes (16 GB)


def launch(plan, store_params):
    seqstore_image = store_params.get("image")
    redpanda_count = store_params.get("redpanda_count")

    broker_names = _pool_names(REDPANDA_SERVICE_NAME, redpanda_count)
    brokers = ",".join(
        ["{}:{}".format(name, REDPANDA_KAFKA_PORT_NUMBER) for name in broker_names]
    )

    metrics_jobs = _launch_brokers(plan, store_params, broker_names)

    if redpanda_count > 1:
        # The production replication profile (store design doc: RF=3,
        # min.insync.replicas = majority). Pre-create before the ingress: its
        # dev-only EnsureTopic would create at the broker-default RF.
        plan.exec(
            service_name=broker_names[0],
            recipe=ExecRecipe(
                command=[
                    "rpk",
                    "topic",
                    "create",
                    SEQSTORE_TOPIC,
                    "--partitions",
                    "1",
                    "--replicas",
                    str(redpanda_count),
                    "--topic-config",
                    "min.insync.replicas={}".format(redpanda_count // 2 + 1),
                ],
            ),
        )

    # The ingress creates the topic (single-broker case) and reports ready
    # once serving; the gateways and auditor launch after it so the topic
    # always exists by the time they follow the log.
    ingress_service = plan.add_service(
        name=SEQSTORE_INGRESS_SERVICE_NAME,
        config=_store_service_config(
            seqstore_image,
            [
                "ingress",
                "-addr",
                ":{}".format(SEQSTORE_GRPC_PORT_NUMBER),
                "-ops-addr",
                ":{}".format(SEQSTORE_OPS_PORT_NUMBER),
                "-chain-id",
                constants.EL_CHAIN_ID,
                "-brokers",
                brokers,
                "-topic",
                SEQSTORE_TOPIC,
                "-create-topic",
                "-txn-timeout",
                "3s",
            ],
            with_grpc=True,
        ),
    )
    metrics_jobs.append(
        _seqstore_metrics_job(SEQSTORE_INGRESS_SERVICE_NAME, ingress_service)
    )

    gateway_count = store_params.get("gateway_count")

    # With a pool, the numbered names hold the gateways and the canonical
    # service name goes to the balancer, so bor configs and tooling stay
    # unchanged. Gateways and the auditor are independent followers of the
    # log; launch them in parallel.
    gateway_names = _pool_names(SEQSTORE_GATEWAY_SERVICE_NAME, gateway_count)

    followers = {}
    for gateway_name in gateway_names:
        followers[gateway_name] = _store_service_config(
            seqstore_image,
            [
                "gateway",
                "-addr",
                ":{}".format(SEQSTORE_GRPC_PORT_NUMBER),
                "-ops-addr",
                ":{}".format(SEQSTORE_OPS_PORT_NUMBER),
                "-chain-id",
                constants.EL_CHAIN_ID,
                "-brokers",
                brokers,
                "-topic",
                SEQSTORE_TOPIC,
            ],
            with_grpc=True,
        )

    followers[SEQSTORE_AUDITOR_SERVICE_NAME] = _store_service_config(
        seqstore_image,
        [
            "auditor",
            "-ops-addr",
            ":{}".format(SEQSTORE_OPS_PORT_NUMBER),
            "-brokers",
            brokers,
            "-topic",
            SEQSTORE_TOPIC,
            "-evidence",
            "/tmp/supersessions.jsonl",
        ],
        with_grpc=False,
    )

    follower_services = plan.add_services(configs=followers)
    for name, service in follower_services.items():
        metrics_jobs.append(_seqstore_metrics_job(name, service))

    if gateway_count > 1:
        metrics_jobs.append(_launch_gateway_lb(plan, store_params, gateway_names))

    return metrics_jobs


def _seqstore_metrics_job(name, service):
    return {
        "Name": name,
        "Endpoint": service.ports["ops"].url.removeprefix("http://"),
        "MetricsPath": SEQSTORE_METRICS_PATH,
    }


def _pool_names(base, count):
    """The bare service name when there is one instance, numbered names
    otherwise — the canonical name stays free for a front (the envoy LB)."""
    if count > 1:
        return ["{}-{}".format(base, i) for i in range(count)]
    return [base]


def _launch_brokers(plan, store_params, broker_names):
    """One dev-container broker, or a Redpanda cluster: every broker gets
    the full seed list and empty_seed_starts_cluster=false — the documented
    founding topology (a broker seeded only on itself never founds a
    cluster). Identical configs mean the brokers can launch in parallel."""
    multi = len(broker_names) > 1
    seeds = ",".join(
        ["{}:{}".format(name, REDPANDA_RPC_PORT_NUMBER) for name in broker_names]
    )

    configs = {}
    for name in broker_names:
        cmd = [
            "redpanda",
            "start",
            "--mode=dev-container",
            "--smp=1",
            "--kafka-addr=internal://0.0.0.0:{}".format(REDPANDA_KAFKA_PORT_NUMBER),
            "--advertise-kafka-addr=internal://{}:{}".format(
                name, REDPANDA_KAFKA_PORT_NUMBER
            ),
        ]

        if multi:
            cmd += [
                "--rpc-addr=0.0.0.0:{}".format(REDPANDA_RPC_PORT_NUMBER),
                "--advertise-rpc-addr={}:{}".format(name, REDPANDA_RPC_PORT_NUMBER),
                "--seeds={}".format(seeds),
                "--set",
                "redpanda.empty_seed_starts_cluster=false",
            ]

        configs[name] = ServiceConfig(
            image=store_params.get("redpanda_image"),
            ports={
                "kafka": PortSpec(number=REDPANDA_KAFKA_PORT_NUMBER),
                "admin": PortSpec(
                    number=REDPANDA_ADMIN_PORT_NUMBER, application_protocol="http"
                ),
            },
            cmd=cmd,
            max_cpu=REDPANDA_MAX_CPU,
            max_memory=REDPANDA_MAX_MEM,
            ready_conditions=ReadyCondition(
                recipe=ExecRecipe(
                    command=[
                        "rpk",
                        "cluster",
                        "health",
                        "--exit-when-healthy",
                    ],
                ),
                field="code",
                assertion="==",
                target_value=0,
            ),
        )

    broker_services = plan.add_services(configs=configs)
    return [
        {
            "Name": name,
            "Endpoint": service.ports["admin"].url.removeprefix("http://"),
            "MetricsPath": REDPANDA_METRICS_PATH,
        }
        for name, service in broker_services.items()
    ]


def _store_service_config(image, cmd, with_grpc):
    ports = {
        "ops": PortSpec(number=SEQSTORE_OPS_PORT_NUMBER, application_protocol="http"),
    }
    if with_grpc:
        ports["grpc"] = PortSpec(number=SEQSTORE_GRPC_PORT_NUMBER)

    return ServiceConfig(
        image=image,
        ports=ports,
        cmd=cmd,
        max_cpu=SEQSTORE_MAX_CPU,
        max_memory=SEQSTORE_MAX_MEM,
        ready_conditions=_http_ready_condition("ops"),
    )


def _http_ready_condition(port_id):
    return ReadyCondition(
        recipe=GetHttpRequestRecipe(
            port_id=port_id,
            endpoint="/ready",
        ),
        field="code",
        assertion="==",
        target_value=200,
    )


def _launch_gateway_lb(plan, store_params, gateway_names):
    """Envoy in front of the gateway pool, rendered from the static template
    (see static_files/sequencer/envoy.yaml for the balancing semantics)."""
    lb_config_artifact = plan.render_templates(
        name="seqstore-gateway-lb-config",
        config={
            "envoy.yaml": struct(
                template=read_file(ENVOY_TEMPLATE_CONFIG_FILE_PATH),
                data={
                    "AdminPort": ENVOY_ADMIN_PORT_NUMBER,
                    "GrpcPort": SEQSTORE_GRPC_PORT_NUMBER,
                    "OpsPort": SEQSTORE_OPS_PORT_NUMBER,
                    "Gateways": gateway_names,
                },
            ),
        },
    )

    lb_service = plan.add_service(
        name=SEQSTORE_GATEWAY_SERVICE_NAME,
        config=ServiceConfig(
            image=store_params.get("envoy_image"),
            ports={
                "grpc": PortSpec(number=SEQSTORE_GRPC_PORT_NUMBER),
                "admin": PortSpec(
                    number=ENVOY_ADMIN_PORT_NUMBER, application_protocol="http"
                ),
            },
            files={"/etc/envoy": lb_config_artifact},
            entrypoint=["envoy"],
            cmd=["-c", "/etc/envoy/envoy.yaml", "--log-level", "info"],
            max_cpu=ENVOY_MAX_CPU,
            max_memory=ENVOY_MAX_MEM,
            ready_conditions=_http_ready_condition("admin"),
        ),
    )
    return {
        "Name": SEQSTORE_GATEWAY_SERVICE_NAME,
        "Endpoint": lb_service.ports["admin"].url.removeprefix("http://"),
        "MetricsPath": ENVOY_METRICS_PATH,
    }
