constants = import_module("../config/constants.star")


def wait_for_l1_startup(plan, cl_rpc_url):
    plan.run_sh(
        name="l1-startup-monitor",
        description="Wait for L1 to start up - it can take up to 5 minutes",
        env_vars={
            "CL_RPC_URL": cl_rpc_url,
        },
        run="\n".join(
            [
                "while true; do",
                '  slot=$(curl $CL_RPC_URL/eth/v1/beacon/headers/ | jq --raw-output ".data[0].header.message.slot");',
                '  echo "L1 chain is starting up... Current slot: $slot";',
                '  if [[ "$slot" =~ ^[0-9]+$ ]] && [[ "$slot" -gt "0" ]]; then',
                '    echo "L1 chain has started!";',
                "    break;",
                "  fi;",
                "  sleep 5;",
                "done",
            ]
        ),
        wait="5m",
    )


def wait_for_l2_startup(plan, cl_api_url):
    plan.run_sh(
        name="l2-startup-monitor",
        description="Wait for L2 to start up - it can take up to 5 minutes",
        env_vars={
            "CL_RPC_URL": cl_api_url,
        },
        run="\n".join(
            [
                "while true; do",
                "  span_id=$(curl $CL_RPC_URL/bor/spans/latest | jq --raw-output '.span.id');",
                '  echo "L2 chain is starting up... Current span id: $span_id";',
                '  if [[ "$span_id" =~ ^[0-9]+$ ]] && [[ "$span_id" -gt "0" ]]; then',
                '    echo "L2 chain has started!";',
                "    break;",
                "  fi;",
                "  sleep 5;",
                "done",
            ]
        ),
        wait="5m",
    )
