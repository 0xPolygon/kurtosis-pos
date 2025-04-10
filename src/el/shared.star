# Port identifiers and numbers.
RPC_PORT_ID = "rpc"
RPC_PORT_NUMBER = 8545

WS_PORT_ID = "ws"
WS_PORT_NUMBER = 8546

DISCOVERY_PORT_ID = "discovery"
DISCOVERY_PORT_NUMBER = 30303

METRICS_PORT_ID = "metrics"
METRICS_PORT_NUMBER = 7071


def wait_for_node_startup(plan, service_name):
    recipe = PostHttpRequestRecipe(
        endpoint="",
        content_type="application/json",
        body='{"method":"admin_nodeInfo","params":[],"id":1,"jsonrpc":"2.0"}',
        port_id=RPC_PORT_ID,
        extract={
            "enode": ".result.enode",
        },
    )
    plan.wait(
        description="Wait for '{}' to start".format(service_name),
        service_name=service_name,
        recipe=recipe,
        field="extract.enode",
        assertion="!=",
        target_value="",
        interval="1s",
        timeout="1m",
    )
