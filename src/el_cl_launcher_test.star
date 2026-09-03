constants = import_module("./config/constants.star")
el_cl_launcher = import_module("./el_cl_launcher.star")
input_parser = import_module("./config/input_parser.star")


def test_sequence_store_node_roles(plan):
    producer = input_parser.POLYGON_POS_PARTICIPANT | {
        "el_bor_use_sequence_store": True,
    }
    consumer = input_parser.POLYGON_POS_PARTICIPANT | {
        "kind": constants.PARTICIPANT_KIND.rpc,
        "el_bor_use_sequence_store": True,
    }
    stateless_validator = input_parser.POLYGON_POS_PARTICIPANT | {
        "el_bor_use_sequence_store": True,
        "el_bor_sync_with_witness": True,
    }

    expect.eq(el_cl_launcher._is_sequence_store_producer(producer), True)
    expect.eq(el_cl_launcher._is_sequence_store_relay_consumer(producer), False)
    expect.eq(el_cl_launcher._is_sequence_store_producer(consumer), False)
    expect.eq(el_cl_launcher._is_sequence_store_relay_consumer(consumer), True)
    expect.eq(el_cl_launcher._is_sequence_store_producer(stateless_validator), False)
