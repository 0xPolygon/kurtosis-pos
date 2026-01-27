constants = import_module("../config/constants.star")

# Port identifiers and numbers.
RABBITMQ_AMQP_PORT_ID = "amqp"
RABBITMQ_AMQP_PORT_NUMBER = 5672

# CPU and memory limits.
MAX_CPU = 1000  # in milicores (1 core)
MAX_MEM = 2048  # in megabytes (2 GB)


def launch(plan, id, image):
    name = "l2-cl-{}-rabbitmq".format(id)
    service = plan.add_service(
        name=name,
        config=ServiceConfig(
            image=image,
            ports={
                RABBITMQ_AMQP_PORT_ID: PortSpec(
                    number=RABBITMQ_AMQP_PORT_NUMBER,
                    application_protocol="amqp",
                )
            },
            max_cpu=MAX_CPU,
            max_mem=MAX_MEM,
        ),
    )
    return "amqp://{}:{}@{}:{}".format(
        constants.RABBITMQ_USERNAME,
        constants.RABBITMQ_PASSWORD,
        name,
        RABBITMQ_AMQP_PORT_NUMBER,
    )
