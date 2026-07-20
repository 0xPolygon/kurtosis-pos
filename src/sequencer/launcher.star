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

SEQSTORE_TOPIC = "chain"


def launch(plan, network_params):
    seqstore_image = network_params.get("sequencer_image")
    brokers = "{}:{}".format(REDPANDA_SERVICE_NAME, REDPANDA_KAFKA_PORT_NUMBER)

    plan.add_service(
        name=REDPANDA_SERVICE_NAME,
        config=ServiceConfig(
            image=network_params.get("sequencer_redpanda_image"),
            ports={
                "kafka": PortSpec(number=REDPANDA_KAFKA_PORT_NUMBER),
            },
            cmd=[
                "redpanda",
                "start",
                "--mode=dev-container",
                "--smp=1",
                "--kafka-addr=internal://0.0.0.0:{}".format(
                    REDPANDA_KAFKA_PORT_NUMBER
                ),
                "--advertise-kafka-addr=internal://{}".format(brokers),
            ],
            ready_conditions=ReadyCondition(
                recipe=ExecRecipe(
                    command=["rpk", "cluster", "health", "--exit-when-healthy"],
                ),
                field="code",
                assertion="==",
                target_value=0,
            ),
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

    plan.add_service(
        name=SEQSTORE_GATEWAY_SERVICE_NAME,
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
