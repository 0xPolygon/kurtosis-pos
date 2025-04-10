# Port identifiers and numbers.
REST_API_PORT_ID = "http"
REST_API_PORT_NUMBER = 1317

GRPC_PORT_ID = "grpc"
GRPC_PORT_NUMBER = 3132

NODE_LISTEN_PORT_ID = "node-listen"
NODE_LISTEN_PORT_NUMBER = 26656

RPC_PORT_ID = "rpc"
RPC_PORT_NUMBER = 26657

PROXY_LISTEN_PORT_NUMBER = 26658

METRICS_PORT_ID = "metrics"
METRICS_PORT_NUMBER = 26660

# The folder where the heimdall configs are stored inside the service.
CONFIG_FOLDER_PATH = "/etc/heimdall"
# The folder where the heimdall app stores data inside the service.
APP_DATA_FOLDER_PATH = "/var/lib/heimdall"


def wait_for_node_startup(plan, service_name):
    recipe = PostHttpRequestRecipe(
        endpoint="",
        content_type="application/json",
        body='{"method":"status","params":[],"id":1,"jsonrpc":"2.0"}',
        port_id=RPC_PORT_ID,
        extract={
            "id": ".result.node_info.id",
        },
    )
    plan.wait(
        description="Wait for '{}' to start".format(service_name),
        service_name=service_name,
        recipe=recipe,
        field="extract.id",
        assertion="!=",
        target_value="",
        interval="1s",
        timeout="1m",
    )
