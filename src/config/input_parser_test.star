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
            constants.ADDITIONAL_SERVICES.test_runner,
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
