constants = import_module("../config/constants.star")

# Sequence store: a Redpanda-backed preconfirmation store. Bor validators
# publish their block lifecycle to the ingress; bor RPC nodes consume the
# gateway stream and serve preconfirmation receipts. The store is enclave-
# internal: bor reaches it via the service names below, and each fresh
# enclave gets a fresh chain (required — the producer anchors onto an
# empty store).

SEQSTORE_INGRESS_SERVICE_NAME = "seqstore-ingress"
SEQSTORE_GATEWAY_SERVICE_NAME = "seqstore-gateway"
SEQSTORE_AUDITOR_SERVICE_NAME = "seqstore-auditor"
REDPANDA_SERVICE_NAME = "seqstore-redpanda"

SEQSTORE_GRPC_PORT_NUMBER = 9550
SEQSTORE_OPS_PORT_NUMBER = 9600
REDPANDA_KAFKA_PORT_NUMBER = 9092
REDPANDA_RPC_PORT_NUMBER = 33145
ENVOY_ADMIN_PORT_NUMBER = 9901
ENVOY_TEMPLATE_CONFIG_FILE_PATH = "../../static_files/sequencer/envoy.yaml"

SEQSTORE_TOPIC = "chain"


def launch(plan, network_params):
    seqstore_image = network_params.get("sequencer_image")
    redpanda_count = network_params.get("sequencer_redpanda_count", 1)

    broker_names = [REDPANDA_SERVICE_NAME]
    if redpanda_count > 1:
        broker_names = [
            "{}-{}".format(REDPANDA_SERVICE_NAME, i) for i in range(redpanda_count)
        ]

    brokers = ",".join(
        ["{}:{}".format(name, REDPANDA_KAFKA_PORT_NUMBER) for name in broker_names]
    )

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

        if redpanda_count > 1:
            # Multi-broker cluster: every node lists the first as its
            # seed — the deploy/redpanda-cluster.yml topology from the
            # store repo.
            cmd += [
                "--rpc-addr=0.0.0.0:{}".format(REDPANDA_RPC_PORT_NUMBER),
                "--advertise-rpc-addr={}:{}".format(name, REDPANDA_RPC_PORT_NUMBER),
                "--seeds={}:{}".format(broker_names[0], REDPANDA_RPC_PORT_NUMBER),
            ]

        plan.add_service(
            name=name,
            config=ServiceConfig(
                image=network_params.get("sequencer_redpanda_image"),
                ports={
                    "kafka": PortSpec(number=REDPANDA_KAFKA_PORT_NUMBER),
                },
                cmd=cmd,
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
            ),
        )

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

    # The ingress creates the topic and reports ready once serving; the
    # gateway is launched after it so the topic always exists.
    plan.add_service(
        name=SEQSTORE_INGRESS_SERVICE_NAME,
        config=ServiceConfig(
            image=seqstore_image,
            ports={
                "grpc": PortSpec(number=SEQSTORE_GRPC_PORT_NUMBER),
                "ops": PortSpec(
                    number=SEQSTORE_OPS_PORT_NUMBER, application_protocol="http"
                ),
            },
            cmd=[
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
            ready_conditions=_ops_ready_condition(),
        ),
    )

    gateway_count = network_params.get("sequencer_gateway_count", 1)

    gateway_names = [SEQSTORE_GATEWAY_SERVICE_NAME]
    if gateway_count > 1:
        # The pool takes numbered names; the canonical service name goes to
        # the balancer below, so bor configs and tooling stay unchanged.
        gateway_names = [
            "{}-{}".format(SEQSTORE_GATEWAY_SERVICE_NAME, i)
            for i in range(gateway_count)
        ]

    for gateway_name in gateway_names:
        plan.add_service(
            name=gateway_name,
            config=ServiceConfig(
                image=seqstore_image,
                ports={
                    "grpc": PortSpec(number=SEQSTORE_GRPC_PORT_NUMBER),
                    "ops": PortSpec(
                        number=SEQSTORE_OPS_PORT_NUMBER, application_protocol="http"
                    ),
                },
                cmd=[
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
                ready_conditions=_ops_ready_condition(),
            ),
        )

    if gateway_count > 1:
        _launch_gateway_lb(plan, network_params, gateway_names)

    plan.add_service(
        name=SEQSTORE_AUDITOR_SERVICE_NAME,
        config=ServiceConfig(
            image=seqstore_image,
            ports={
                "ops": PortSpec(
                    number=SEQSTORE_OPS_PORT_NUMBER, application_protocol="http"
                ),
            },
            cmd=[
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
            ready_conditions=_ops_ready_condition(),
        ),
    )


def _ops_ready_condition():
    return ReadyCondition(
        recipe=GetHttpRequestRecipe(
            port_id="ops",
            endpoint="/ready",
        ),
        field="code",
        assertion="==",
        target_value=200,
    )


def _launch_gateway_lb(plan, network_params, gateway_names):
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

    plan.add_service(
        name=SEQSTORE_GATEWAY_SERVICE_NAME,
        config=ServiceConfig(
            image=network_params.get("sequencer_envoy_image"),
            ports={
                "grpc": PortSpec(number=SEQSTORE_GRPC_PORT_NUMBER),
                "admin": PortSpec(
                    number=ENVOY_ADMIN_PORT_NUMBER, application_protocol="http"
                ),
            },
            files={"/etc/envoy": lb_config_artifact},
            entrypoint=["envoy"],
            cmd=["-c", "/etc/envoy/envoy.yaml", "--log-level", "info"],
            ready_conditions=ReadyCondition(
                recipe=GetHttpRequestRecipe(port_id="admin", endpoint="/ready"),
                field="code",
                assertion="==",
                target_value=200,
            ),
        ),
    )
