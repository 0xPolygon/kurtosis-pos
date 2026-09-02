constants = import_module("../config/constants.star")
shared = import_module("./shared.star")
util = import_module("./util.star")

ERPC_CONFIG_FILE_PATH = "../../static_files/additional_services/erpc/erpc.yaml"

SERVICE_NAME = "erpc"
RPC_PORT_ID = "rpc"
RPC_PORT_NUMBER = 4000
METRICS_PORT_ID = "metrics"
METRICS_PORT_NUMBER = 4001
METRICS_PATH = "/metrics"


def launch(plan, erpc_params, l2_context):
    erpc_config_artifact = plan.render_templates(
        name="erpc-config",
        config={
            "erpc.yaml": struct(
                template=read_file(ERPC_CONFIG_FILE_PATH),
                data={
                    "ChainId": constants.EL_CHAIN_ID,
                    "Upstreams": util.l2_el_rpc_urls(l2_context),
                    "RpcPort": RPC_PORT_NUMBER,
                    "MetricsPort": METRICS_PORT_NUMBER,
                },
            )
        },
    )

    plan.add_service(
        name=SERVICE_NAME,
        config=ServiceConfig(
            image=erpc_params.get("image"),
            ports={
                RPC_PORT_ID: PortSpec(
                    number=RPC_PORT_NUMBER, application_protocol="http"
                ),
                METRICS_PORT_ID: PortSpec(
                    number=METRICS_PORT_NUMBER, application_protocol="http"
                ),
            },
            # The image runs /erpc-server as a nonroot user with workdir
            # /home/nonroot, and erpc probes ./erpc.yaml first — so mount the
            # config there and no cmd override is needed.
            files={"/home/nonroot": erpc_config_artifact},
            max_cpu=shared.MAX_CPU,
            max_memory=shared.MAX_MEM,
            ready_conditions=ReadyCondition(
                recipe=GetHttpRequestRecipe(
                    port_id=RPC_PORT_ID, endpoint="/healthcheck"
                ),
                field="code",
                assertion="==",
                target_value=200,
            ),
        ),
    )


def metrics_job():
    # Static target rather than a service port url: prometheus may launch
    # before erpc (additional services start in list order), and it scrapes
    # by DNS name, so the job resolves once the erpc service is up.
    return {
        "Name": SERVICE_NAME,
        "Endpoint": "{}:{}".format(SERVICE_NAME, METRICS_PORT_NUMBER),
        "MetricsPath": METRICS_PATH,
    }
