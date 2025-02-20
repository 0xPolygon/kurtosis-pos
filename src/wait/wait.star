constants = import_module("../package_io/constants.star")


def wait_for_l1_startup(plan, cl_rpc_url):
    plan.run_sh(
        name="wait-for-l1-startup",
        description="Wait for L1 to start up - it can take up to 2 minutes",
        env_vars={
            "CL_RPC_URL": cl_rpc_url,
        },
        run="while true; do sleep 5; echo 'L1 Chain is starting up...'; if [ \"$(curl -s $CL_RPC_URL/eth/v1/beacon/headers/ | jq -r '.data[0].header.message.slot')\" != \"0\" ]; then echo '✅ L1 Chain has started!'; break; fi; done",
        wait="5m",
    )


def wait_for_l2_startup(plan, cl_api_url, cl_type):
    endpoint = ""
    json_path = ""
    if cl_type == constants.CL_TYPE.heimdall:
        endpoint = "bor/latest-span"
        json_path = ".result.span_id"
    elif cl_type == constants.CL_TYPE.heimdall_v2:
        endpoint = "bor/span/latest"
        json_path = ".span.id"
    else:
        fail(
            'Wrong CL type: "{}". Allowed values: "{}."'.format(
                cl_type,
                [constants.CL_TYPE.heimdall, constants.CL_TYPE.heimdall_v2],
            )
        )

    plan.run_sh(
        name="wait-for-l2-startup",
        description="Wait for L2 to start up - it can take up to 2 minutes",
        env_vars={
            "CL_RPC_URL": cl_api_url,
            "ENDPOINT": endpoint,
            "JSON_PATH": json_path,
        },
        run='while true; do sleep 5; echo "L2 Chain is starting up..."; if [ "$(curl -s $CL_RPC_URL/$ENDPOINT | jq -r ".result.span_id")" != "0" ]; then echo "✅ L2 Chain has started!"; break; fi; done',
        wait="300s",
    )
