constants = import_module("./constants.star")
input_parser = import_module("./input_parser.star")
sanity_check = import_module("./sanity_check.star")


def test_sanity_check_valid_config(plan):
    sanity_check.sanity_check_polygon_args(plan, input_parser.POLYGON_POS_PACKAGE_ARGS)


def test_sanity_check_with_invalid_parallel_import(plan):
    participant = input_parser.POLYGON_POS_PARTICIPANT | {
        "el_type": constants.EL_TYPE.bor,
        "el_bor_sync_with_witness": False,
        "el_bor_stateless_parallel_import": True,
    }
    args = input_parser.POLYGON_POS_PACKAGE_ARGS | {
        "participants": [participant],
    }
    expect.fails(
        lambda: sanity_check.sanity_check_polygon_args(plan, args),
        'The "el_bor_stateless_parallel_import" parameter can only be enabled with bor EL client and when "el_bor_sync_with_witness" is set to true.',
    )


def test_sanity_check_with_parallel_import(plan):
    participant = input_parser.POLYGON_POS_PARTICIPANT | {
        "el_type": constants.EL_TYPE.bor,
        "el_bor_sync_with_witness": True,
        "el_bor_stateless_parallel_import": True,
    }
    args = input_parser.POLYGON_POS_PACKAGE_ARGS | {
        "participants": [participant],
    }
    sanity_check.sanity_check_polygon_args(plan, args)


def test_sanity_check_with_status_checker_missing_image(plan):
    args = input_parser.POLYGON_POS_PACKAGE_ARGS | {
        "additional_services": [
            constants.ADDITIONAL_SERVICES.status_checker,
        ],
        "status_checker_params": {},
    }
    expect.fails(
        lambda: sanity_check.sanity_check_polygon_args(plan, args),
        '`status_checker_params` must include the "image" field when the status checker is deployed',
    )


def test_sanity_check_with_status_checker(plan):
    args = input_parser.POLYGON_POS_PACKAGE_ARGS | {
        "additional_services": [
            constants.ADDITIONAL_SERVICES.status_checker,
        ],
        "status_checker_params": {
            "image": constants.IMAGES.get("status_checker_image"),
        },
    }


def test_sanity_check_with_ethstats_server_missing_image(plan):
    args = input_parser.POLYGON_POS_PACKAGE_ARGS | {
        "additional_services": [
            constants.ADDITIONAL_SERVICES.ethstats_server,
        ],
        "ethstats_server_params": {},
    }
    expect.fails(
        lambda: sanity_check.sanity_check_polygon_args(plan, args),
        '`ethstats_server_params` must include the "image" field when the status checker is deployed',
    )


def test_sanity_check_with_ethstats_server(plan):
    args = input_parser.POLYGON_POS_PACKAGE_ARGS | {
        "additional_services": [
            constants.ADDITIONAL_SERVICES.ethstats_server,
        ],
        "ethstats_server_params": {
            "image": constants.IMAGES.get("ethstats_server_image"),
        },
    }


def test_sanity_check_with_private_tx_endpoints_without_relay(plan):
    participant = input_parser.POLYGON_POS_PARTICIPANT | {
        "el_type": constants.EL_TYPE.bor,
        "el_bor_enable_private_tx_relay": False,
        "el_bor_private_tx_bp_endpoints": ["http://bp:8545"],
    }
    args = input_parser.POLYGON_POS_PACKAGE_ARGS | {
        "participants": [participant],
    }
    expect.fails(
        lambda: sanity_check.sanity_check_polygon_args(plan, args),
        '"el_bor_private_tx_bp_endpoints" is set but "el_bor_enable_private_tx_relay" is False',
    )


def test_sanity_check_with_private_tx_relay_topology(plan):
    bp = input_parser.POLYGON_POS_PARTICIPANT | {
        "el_type": constants.EL_TYPE.bor,
        "el_bor_accept_private_tx": True,
    }
    relayer = input_parser.POLYGON_POS_PARTICIPANT | {
        "kind": constants.PARTICIPANT_KIND.rpc,
        "el_type": constants.EL_TYPE.bor,
        "el_bor_enable_private_tx_relay": True,
    }
    args = input_parser.POLYGON_POS_PACKAGE_ARGS | {
        "participants": [bp, relayer],
    }
    sanity_check.sanity_check_polygon_args(plan, args)
