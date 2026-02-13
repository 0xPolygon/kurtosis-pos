constants = import_module("../config/constants.star")

# Port identifiers and numbers.
RABBITMQ_AMQP_PORT_ID = "amqp"
RABBITMQ_AMQP_PORT_NUMBER = 5672

# The folder where the rabbitmq app stores data inside the service.
APP_DATA_FOLDER_PATH = "/var/lib/rabbitmq"

# CPU and memory limits.
MAX_CPU = 1000  # in milicores (1 core)
MAX_MEM = 2048  # in megabytes (2 GB)


def launch(plan, id, image):
    name = "l2-cl-{}-rabbitmq".format(id)
    service = plan.add_service(
        name=name,
        config=ServiceConfig(
            image=image,
            env_vars={
                "RABBITMQ_DATA_DIR": APP_DATA_FOLDER_PATH,
                "RABBITMQ_DEFAULT_USER": constants.RABBITMQ_USERNAME,
                "RABBITMQ_DEFAULT_PASS": constants.RABBITMQ_PASSWORD,
            },
            files={
                # app data
                APP_DATA_FOLDER_PATH: Directory(persistent_key="{}-data".format(name)),
            },
            ports={
                RABBITMQ_AMQP_PORT_ID: PortSpec(
                    number=RABBITMQ_AMQP_PORT_NUMBER,
                    application_protocol="amqp",
                )
            },
            max_cpu=MAX_CPU,
            max_memory=MAX_MEM,
        ),
    )
    return "amqp://{}:{}@{}:{}".format(
        constants.RABBITMQ_USERNAME,
        constants.RABBITMQ_PASSWORD,
        name,
        RABBITMQ_AMQP_PORT_NUMBER,
    )
