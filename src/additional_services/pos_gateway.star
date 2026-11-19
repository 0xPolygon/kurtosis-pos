constants = import_module("../config/constants.star")
shared = import_module("./shared.star")
util = import_module("./util.star")

POS_GATEWAY_CONFIG_FILE_PATH = (
    "../../static_files/additional_services/pos_gateway/node-gateway.conf"
)

SERVICE_NAME = "pos-gateway"
RPC_PORT_ID = "rpc"
RPC_PORT_NUMBER = 8887

# The gateway mounts each network at /<network name> and /<chain id>.
NETWORK_NAME = "devnet"

CONFIG_MOUNT_PATH = "/opt/pos-gateway"


def launch(plan, pos_gateway_params, l2_context):
    config_artifact = plan.render_templates(
        name="pos-gateway-config",
        config={
            "node-gateway.conf": struct(
                template=read_file(POS_GATEWAY_CONFIG_FILE_PATH),
                data={
                    "Port": RPC_PORT_NUMBER,
                    "NetworkName": NETWORK_NAME,
                    "ChainId": constants.EL_CHAIN_ID,
                    "Upstreams": util.l2_el_rpc_urls(l2_context),
                },
            )
        },
    )

    plan.add_service(
        name=SERVICE_NAME,
        config=ServiceConfig(
            image=pos_gateway_params.get("image"),
            ports={
                RPC_PORT_ID: PortSpec(
                    number=RPC_PORT_NUMBER, application_protocol="http"
                ),
            },
            files={CONFIG_MOUNT_PATH: config_artifact},
            cmd=[
                "/node-gateway/bin/node-gateway",
                "--config",
                "{}/node-gateway.conf".format(CONFIG_MOUNT_PATH),
            ],
            max_cpu=shared.MAX_CPU,
            max_memory=shared.MAX_MEM,
            ready_conditions=ReadyCondition(
                recipe=PostHttpRequestRecipe(
                    port_id=RPC_PORT_ID,
                    endpoint="/{}?key=devnet-admin".format(NETWORK_NAME),
                    content_type="application/json",
                    body='{"jsonrpc":"2.0","id":1,"method":"eth_chainId","params":[]}',
                ),
                field="code",
                assertion="==",
                target_value=200,
                interval="2s",
                timeout="1m",
            ),
        ),
    )
