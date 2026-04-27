constants = import_module("../config/constants.star")

# Port identifiers and numbers.
RABBITMQ_AMQP_PORT_ID = "amqp"
RABBITMQ_AMQP_PORT_NUMBER = 5672

# The folder where the rabbitmq app stores data inside the service.
APP_DATA_FOLDER_PATH = "/var/lib/rabbitmq"

# The folder where the rabbitmq app reads config files inside the service.
APP_CONFIG_FOLDER_PATH = "/etc/rabbitmq"

# CPU and memory limits.
MAX_CPU = 1000  # in milicores (1 core)
MAX_MEM = 2048  # in megabytes (2 GB)


def generate_name(id):
    return "l2-cl-{}-rabbitmq".format(id)


# RabbitMQ is only needed for validator nodes.
# It provides the AMQP message broker used by the bridge to submit checkpoints to L1 and handle span/checkpoint events.
# RPC nodes don't run the bridge and don't need RabbitMQ at all.
def launch(plan, id, image, log_level, log_format):
    name = generate_name(id)

    # Render the rabbitmq config file.
    config_artifact = plan.render_templates(
        name="{}-config".format(name),
        config={
            "rabbitmq.conf": struct(
                template=read_file(
                    src="../../static_files/cl/rabbitmq/rabbitmq.conf.tmpl"
                ),
                data={
                    "log_level": _log_level(log_level),
                    "log_format": _log_formatter(log_format),
                },
            ),
        },
    )

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
            files={
                APP_DATA_FOLDER_PATH: Directory(persistent_key="{}-data".format(name)),
                APP_CONFIG_FOLDER_PATH: config_artifact,
            },
            env_vars={
                "RABBITMQ_NODE_PORT": str(RABBITMQ_AMQP_PORT_NUMBER),
                "RABBITMQ_DEFAULT_USER": constants.RABBITMQ_USERNAME,
                "RABBITMQ_DEFAULT_PASS": constants.RABBITMQ_PASSWORD,
                "RABBITMQ_CONFIG_FILE": "{}/rabbitmq.conf".format(
                    APP_CONFIG_FOLDER_PATH
                ),
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


def _log_level(log_level):
    # RabbitMQ log levels: debug, info, warning, error, critical.
    # trace and warn are mapped to the closest RabbitMQ equivalent.
    map = {
        constants.LOG_LEVEL.trace: "debug",
        constants.LOG_LEVEL.debug: "debug",
        constants.LOG_LEVEL.info: "info",
        constants.LOG_LEVEL.warn: "warning",
        constants.LOG_LEVEL.error: "error",
    }
    if log_level not in map:
        fail("Invalid log level: " + log_level)
    return map[log_level]


def _log_formatter(log_format):
    # RabbitMQ log formats: plaintext, json
    map = {
        constants.LOG_FORMAT.text: "plaintext",
        constants.LOG_FORMAT.json: "json",
    }
    if log_format not in map:
        fail("Invalid log format: " + log_format)
    return map[log_format]
