shared = import_module("./shared.star")
util = import_module("./util.star")

NGINX_CONFIG_FILE_PATH = "../../static_files/additional_services/nginx/nginx.conf"

SERVICE_NAME = "nginx"
RPC_PORT_ID = "rpc"
RPC_PORT_NUMBER = 8545

# The config is mounted at a custom path (instead of shadowing /etc/nginx,
# which also holds files the image entrypoint expects) and selected with -c.
NGINX_CONFIG_MOUNT_PATH = "/opt/nginx"


def launch(plan, nginx_params, l2_context):
    nginx_config_artifact = plan.render_templates(
        name="nginx-config",
        config={
            "nginx.conf": struct(
                template=read_file(NGINX_CONFIG_FILE_PATH),
                data={
                    "Upstreams": util.l2_el_rpc_hosts(l2_context),
                    "RpcPort": RPC_PORT_NUMBER,
                },
            )
        },
    )

    plan.add_service(
        name=SERVICE_NAME,
        config=ServiceConfig(
            image=nginx_params.get("image"),
            ports={
                RPC_PORT_ID: PortSpec(
                    number=RPC_PORT_NUMBER, application_protocol="http"
                ),
            },
            files={NGINX_CONFIG_MOUNT_PATH: nginx_config_artifact},
            cmd=[
                "nginx",
                "-c",
                "{}/nginx.conf".format(NGINX_CONFIG_MOUNT_PATH),
                "-g",
                "daemon off;",
            ],
            max_cpu=shared.MAX_CPU,
            max_memory=shared.MAX_MEM,
            # A JSON-RPC request through the proxy verifies both nginx and
            # upstream connectivity in one probe.
            ready_conditions=ReadyCondition(
                recipe=PostHttpRequestRecipe(
                    port_id=RPC_PORT_ID,
                    endpoint="/",
                    content_type="application/json",
                    body='{"jsonrpc":"2.0","id":1,"method":"eth_blockNumber","params":[]}',
                ),
                field="code",
                assertion="==",
                target_value=200,
            ),
        ),
    )
