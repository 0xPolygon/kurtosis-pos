constants = import_module("./constants.star")
input_parser = import_module("./input_parser.star")


def test_parse_empty_args(plan):
    input_parser.input_parser(plan, {})


def test_parse_additional_services(plan):
    args = {
        "additional_services": [
            constants.ADDITIONAL_SERVICES.blockscout,
            constants.ADDITIONAL_SERVICES.bridge_spammer,
            constants.ADDITIONAL_SERVICES.ethstats_server,
            constants.ADDITIONAL_SERVICES.observability,
            constants.ADDITIONAL_SERVICES.status_checker,
            constants.ADDITIONAL_SERVICES.tx_spammer,
        ]
    }
    input_parser.input_parser(plan, args)


def test_parse_polygon_pos_args_with_global_log_params(plan):
    args = {
        "log_level": "debug",
        "log_format": "json",
        "participants": [],
    }
    parsed_args = input_parser._parse_polygon_pos_args(plan, args)

    expect.eq(parsed_args["log_level"], "debug")
    expect.eq(parsed_args["log_format"], "json")

    participants = parsed_args["participants"]
    expect.eq(len(participants), 1)
    participant0 = participants[0]
    expect.eq(participant0["el_log_level"], "debug")
    expect.eq(participant0["el_log_format"], "json")
    expect.eq(participant0["cl_log_level"], "debug")
    expect.eq(participant0["cl_log_format"], "json")


def test_parse_polygon_pos_args_without_log_params(plan):
    args = {
        "participants": [],
    }
    parsed_args = input_parser._parse_polygon_pos_args(plan, args)

    expect.eq(parsed_args["log_level"], "info")
    expect.eq(parsed_args["log_format"], "text")

    participants = parsed_args["participants"]
    expect.eq(len(participants), 1)
    participant0 = participants[0]
    expect.eq(participant0["el_log_level"], "info")
    expect.eq(participant0["el_log_format"], "text")
    expect.eq(participant0["cl_log_level"], "info")
    expect.eq(participant0["cl_log_format"], "text")


def test_parse_dev_args_lst_deployer_params_defaults(plan):
    # Omitted lst_deployer_params should be filled in from DEV_ARGS defaults.
    parsed_args = input_parser._parse_dev_args(plan, {})
    lst_params = parsed_args["lst_deployer_params"]
    expect.eq(lst_params["reward_fee"], 50)
    expect.eq(lst_params["max_divergence"], 10)
    expect.eq(lst_params["fee_receiver"], "")


def test_parse_dev_args_lst_deployer_params_partial_override(plan):
    # User-supplied keys win; unspecified keys fall back to defaults.
    parsed_args = input_parser._parse_dev_args(
        plan, {"lst_deployer_params": {"reward_fee": 100}}
    )
    lst_params = parsed_args["lst_deployer_params"]
    expect.eq(lst_params["reward_fee"], 100)
    expect.eq(lst_params["max_divergence"], 10)


def test_parse_dev_args_lst_requires_deploy_l1(plan):
    expect.fails(
        lambda: input_parser._parse_dev_args(
            plan,
            {
                "should_deploy_l1": False,
                "l1_rpc_url": "http://example:8545",
                "deploy_lst_contracts": True,
            },
        ),
        "deploy_lst_contracts requires should_deploy_l1=True",
    )
