constants = import_module("./constants.star")
input_parser = import_module("./input_parser.star")
sanity_check = import_module("./sanity_check.star")


def test_sanity_check_valid_config(plan):
    sanity_check.sanity_check_polygon_args(plan, input_parser.POLYGON_POS_PACKAGE_ARGS)


# Erigon was removed as a supported EL client; pin the rejection so it can't
# silently creep back into VALID_EL_CLIENTS.
def test_sanity_check_rejects_erigon_el_type(plan):
    participant = input_parser.POLYGON_POS_PARTICIPANT | {
        "el_type": "erigon",
    }
    args = input_parser.POLYGON_POS_PACKAGE_ARGS | {
        "participants": [participant],
    }
    expect.fails(
        lambda: sanity_check.sanity_check_polygon_args(plan, args),
        'Invalid "el_type" attribute: "erigon"',
    )


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
        'The "el_bor_stateless_parallel_import" parameter can only be enabled when "el_bor_sync_with_witness" is set to true.',
    )


def test_sanity_check_with_parallel_import(plan):
    # Stateless validators can't seal blocks, so include a producing validator
    # alongside the stateless one to satisfy the producer-set sanity check.
    producing_validator = input_parser.POLYGON_POS_PARTICIPANT | {
        "el_type": constants.EL_TYPE.bor,
        "el_bor_sync_with_witness": False,
    }
    stateless_validator = input_parser.POLYGON_POS_PARTICIPANT | {
        "el_type": constants.EL_TYPE.bor,
        "el_bor_sync_with_witness": True,
        "el_bor_stateless_parallel_import": True,
    }
    args = input_parser.POLYGON_POS_PACKAGE_ARGS | {
        "participants": [producing_validator, stateless_validator],
    }
    sanity_check.sanity_check_polygon_args(plan, args)


def test_sanity_check_fails_without_producing_validator(plan):
    stateless_validator = input_parser.POLYGON_POS_PARTICIPANT | {
        "el_type": constants.EL_TYPE.bor,
        "el_bor_sync_with_witness": True,
    }
    args = input_parser.POLYGON_POS_PACKAGE_ARGS | {
        "participants": [stateless_validator],
    }
    expect.fails(
        lambda: sanity_check.sanity_check_polygon_args(plan, args),
        "At least one validator participant must have `el_bor_sync_with_witness: false` so the network has a block producer.",
    )


def test_sanity_check_fails_without_sequence_store_producer(plan):
    producer = input_parser.POLYGON_POS_PARTICIPANT
    consumer = input_parser.POLYGON_POS_PARTICIPANT | {
        "kind": constants.PARTICIPANT_KIND.rpc,
        "el_bor_use_sequence_store": True,
    }
    args = input_parser.POLYGON_POS_PACKAGE_ARGS | {
        "participants": [producer, consumer],
        "sequence_store_params": input_parser.SEQUENCE_STORE_ARGS,
    }
    expect.fails(
        lambda: sanity_check.sanity_check_polygon_args(plan, args),
        "Sequence-store consumers require at least one producing validator with `el_bor_use_sequence_store: true`.",
    )


def test_sanity_check_with_sequence_store_producer_and_consumer(plan):
    producer = input_parser.POLYGON_POS_PARTICIPANT | {
        "el_bor_use_sequence_store": True,
    }
    consumer = input_parser.POLYGON_POS_PARTICIPANT | {
        "kind": constants.PARTICIPANT_KIND.rpc,
        "el_bor_use_sequence_store": True,
    }
    args = input_parser.POLYGON_POS_PACKAGE_ARGS | {
        "participants": [producer, consumer],
        "sequence_store_params": input_parser.SEQUENCE_STORE_ARGS,
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
