constants = import_module("./constants.star")
math = import_module("../math/math.star")
sanity_check = import_module("./sanity_check.star")

DEFAULT_ETHEREUM_PACKAGE_ARGS = {
    "global_log_level": constants.LOG_LEVEL.info,
    "participants": [
        {
            # General
            "count": 1,
            # Consensus client
            "cl_type": "lighthouse",
            "cl_image": constants.DEFAULT_IMAGES.get("l1_cl_image"),
            # Execution client
            "el_type": "geth",
            "el_image": constants.DEFAULT_IMAGES.get("l1_el_image"),
            # Validator client
            "use_separate_vc": True,
            "vc_type": "lighthouse",
            "vc_image": constants.DEFAULT_IMAGES.get("l1_cl_image"),
            # Fulu hard fork config
            # In PeerDAS, a supernode is a node that custodies and samples all data columns (i.e. holds full awareness
            # of the erasure-coded blob data) and helps with distributed blob building — computing proofs and
            # broadcasting data on behalf of the proposer.
            # Since we don't enable perfect PeerDAS in the config, we need to have at least one supernode.
            "supernode": True,
        },
    ],
    "network_params": {
        "network_id": constants.DEFAULT_L1_CHAIN_ID,
        "prefunded_accounts": "",
        "seconds_per_slot": 1,
        # The "minimal" preset is useful for rapid testing and development.
        # It takes 192 seconds to get to finalized epoch vs 1536 seconds with mainnet defaults.
        "preset": "minimal",
        # Ethereum hard fork configurations.
        # Supported fork epochs are documented in `static_files/genesis-generation-config/el-cl/values.env.tmpl`.
        # in the ethereum package repository.
        "altair_fork_epoch": 0,
        "bellatrix_fork_epoch": 0,
        "capella_fork_epoch": 0,
        "deneb_fork_epoch": 1,
        "electra_fork_epoch": 2,
        "fulu_fork_epoch": 3,  # Requires a supernode or perfect PeerDAS to be enabled.
    },
}

DEFAULT_POLYGON_POS_PARTICIPANT = {
    "kind": constants.PARTICIPANT_KIND.validator,
    "cl_type": constants.CL_TYPE.heimdall_v2,
    "cl_image": constants.DEFAULT_IMAGES.get("l2_cl_heimdall_v2_image"),
    "cl_db_image": constants.DEFAULT_IMAGES.get("l2_cl_db_image"),
    "cl_min_retain_blocks": constants.CL_MIN_RETAIN_BLOCKS,
    "cl_compact_enabled": constants.CL_COMPACT_ENABLED,
    "cl_compaction_interval": constants.CL_COMPACTION_INTERVAL,
    "cl_storage_pruning_interval": constants.CL_STORAGE_PRUNING_INTERVAL,
    "cl_indexer_pruning_enabled": constants.CL_INDEXER_PRUNING_ENABLED,
    "el_type": constants.EL_TYPE.bor,
    "el_image": constants.DEFAULT_IMAGES.get("l2_el_bor_image"),
    "count": 1,
}

DEFAULT_POLYGON_POS_EL_BOR_PARTICIPANT = {
    "el_bor_sync_mode": constants.BOR_SYNC_MODES.full,
}

DEFAULT_POLYGON_POS_PACKAGE_ARGS = {
    "global_log_level": constants.LOG_LEVEL.info,
    "global_log_format": constants.LOG_FORMAT.text,
    "participants": [DEFAULT_POLYGON_POS_PARTICIPANT],
    "setup_images": {
        "contract_deployer": constants.DEFAULT_IMAGES.get(
            "pos_contract_deployer_image"
        ),
        "el_genesis_builder": constants.DEFAULT_IMAGES.get(
            "pos_el_genesis_builder_image"
        ),
        "validator_config_generator": constants.DEFAULT_IMAGES.get(
            "pos_validator_config_generator_image"
        ),
    },
    "network_params": {
        # Admin account generated using `cast wallet new`.
        # This private key is used to deploy Polygon PoS contracts on both L1 and L2.
        "admin_private_key": "0xd40311b5a5ca5eaeb48dfba5403bde4993ece8eccf4190e98e19fcd4754260ea",
        # Validators params.
        "preregistered_validator_keys_mnemonic": "sibling lend brave explain wait orbit mom alcohol disorder message grace sun",
        "validator_stake_amount_eth": 10000,  # in ether
        "validator_top_up_fee_amount_eth": 2000,  # in ether
        # CL network params.
        "cl_chain_id": constants.DEFAULT_CL_CHAIN_ID,
        "cl_span_poll_interval": "0m15s",
        "cl_checkpoint_poll_interval": "1m0s",
        "cl_max_age_num_blocks": 100000,
        # EL network params.
        "el_chain_id": constants.DEFAULT_EL_CHAIN_ID,
        "el_block_interval_seconds": 1,
        "el_sprint_duration": 16,
        "el_span_duration": 128,
        "el_gas_limit": 45000000,
    },
    "additional_services": [
        constants.ADDITIONAL_SERVICES.test_runner,
    ],
    "test_runner_params": {
        "image": constants.DEFAULT_IMAGES.get("e2e_image"),
    },
    "status_checker_params": {
        "image": constants.DEFAULT_IMAGES.get("status_checker_image"),
    },
}

DEFAULT_DEV_ARGS = {
    "should_deploy_l1": True,
    "should_deploy_matic_contracts": True,
}


def input_parser(plan, input_args):
    plan.print("Parsing the L1 input args")
    ethereum_input_args = input_args.get("ethereum_package", {})
    ethereum_args = _parse_ethereum_args(plan, ethereum_input_args)
    plan.print("L1 input args parsed: {}".format(str(ethereum_args)))

    plan.print("Parsing the L2 input args")
    polygon_pos_input_args = input_args.get("polygon_pos_package", {})
    (polygon_pos_args, devnet_cl_type) = _parse_polygon_pos_args(
        plan, polygon_pos_input_args
    )
    plan.print("L2 input args parsed: {}".format(str(polygon_pos_args)))

    plan.print("Parsing the dev input args")
    dev_input_args = input_args.get("dev", {})
    dev_args = _parse_dev_args(plan, dev_input_args)
    plan.print("Dev input args parsed: {}".format(str(dev_args)))

    return (ethereum_args, polygon_pos_args, dev_args, devnet_cl_type)


def _parse_ethereum_args(plan, ethereum_args):
    # Create a mutable copy of ethereum_args.
    if ethereum_args:
        ethereum_args = dict(ethereum_args)

    # Set default params if not provided.
    if "network_params" not in ethereum_args:
        ethereum_args = dict(DEFAULT_ETHEREUM_PACKAGE_ARGS)

    for k, v in DEFAULT_ETHEREUM_PACKAGE_ARGS.get("network_params", {}).items():
        ethereum_args.get("network_params", {}).setdefault(k, v)

    # Sort the dict and return the result.
    return _sort_dict_by_values(ethereum_args)


def _parse_polygon_pos_args(plan, polygon_pos_args):
    # Create a mutable copy of polygon_pos_args.
    if polygon_pos_args:
        polygon_pos_args = dict(polygon_pos_args)

    # Parse the polygon pos input args and set defaults if needed.
    result = {}

    global_log_level = polygon_pos_args.get(
        "global_log_level", constants.LOG_LEVEL.info
    )
    global_log_format = polygon_pos_args.get(
        "global_log_format", constants.LOG_FORMAT.text
    )
    result["global_log_level"] = global_log_level
    result["global_log_format"] = global_log_format

    participants = polygon_pos_args.get("participants", [])
    result["participants"] = _parse_participants(
        participants, global_log_level, global_log_format
    )
    devnet_cl_type = _get_devnet_cl_type(result["participants"])

    setup_images = polygon_pos_args.get("setup_images", {})
    result["setup_images"] = _parse_setup_images(setup_images)

    network_params = polygon_pos_args.get("network_params", {})
    result["network_params"] = _parse_network_params(network_params)

    additional_services = polygon_pos_args.get("additional_services", [])
    result["additional_services"] = _parse_additional_services(additional_services)

    is_test_runner_deployed = (
        constants.ADDITIONAL_SERVICES.test_runner in result["additional_services"]
    )
    test_runner_params = polygon_pos_args.get("test_runner_params", {})
    result["test_runner_params"] = _parse_test_runner_params(
        is_test_runner_deployed, test_runner_params
    )

    is_status_checker_deployed = (
        constants.ADDITIONAL_SERVICES.status_checker in result["additional_services"]
    )
    status_checker_params = polygon_pos_args.get("status_checker_params", {})
    result["status_checker_params"] = _parse_status_checker_params(
        is_status_checker_deployed, status_checker_params
    )

    # Sanity check and return the result.
    sanity_check.sanity_check_polygon_args(plan, result)
    return (_sort_dict_by_values(result), devnet_cl_type)


def _parse_dev_args(plan, dev_args):
    # Create a mutable copy of dev_args.
    if dev_args:
        dev_args = dict(dev_args)

    # Set default params if not provided.
    if "should_deploy_l1" not in dev_args:
        dev_args["should_deploy_l1"] = DEFAULT_DEV_ARGS.get("should_deploy_l1", True)

    if "should_deploy_matic_contracts" not in dev_args:
        dev_args["should_deploy_matic_contracts"] = DEFAULT_DEV_ARGS.get(
            "should_deploy_matic_contracts", True
        )

    # Sanity check and return the result.
    sanity_check.sanity_check_dev_args(plan, dev_args)
    return _sort_dict_by_values(dev_args)


def _parse_participants(participants, global_log_level, global_log_format):
    devnet_cl_type = ""
    participants_with_defaults = []

    # Set default participant if not provided.
    if len(participants) == 0:
        participants = DEFAULT_POLYGON_POS_PACKAGE_ARGS.get("participants", [])

    for p in participants:
        # Create a mutable copy of participant.
        p = dict(p)

        # Set default CL image based on `cl_type` if provided
        cl_type = p.get("cl_type", "")
        cl_image = p.get("cl_image", "")
        if cl_type and not cl_image:
            if cl_type == constants.CL_TYPE.heimdall_v2:
                p["cl_image"] = constants.DEFAULT_IMAGES.get("l2_cl_heimdall_v2_image")
            else:
                fail("Invalid CL client type: '{}'.".format(cl_type))

        # Set default EL image based on `el_type` if provided.
        el_type = p.get("el_type", "")
        el_image = p.get("el_image", "")
        if el_type and not el_image:
            if el_type == constants.EL_TYPE.bor:
                p["el_image"] = constants.DEFAULT_IMAGES.get("l2_el_bor_image")
            elif el_type == constants.EL_TYPE.erigon:
                p["el_image"] = constants.DEFAULT_IMAGES.get("l2_el_erigon_image")
            else:
                fail("Invalid EL client type: '{}'.".format(el_type))

        # Set log levels to global log level if not provided.
        cl_log_level = p.get("cl_log_level", "")
        el_log_level = p.get("el_log_level", "")
        if global_log_level:
            if not cl_log_level:
                p["cl_log_level"] = global_log_level
            if not el_log_level:
                p["el_log_level"] = global_log_level

        cl_log_format = p.get("cl_log_format", "")
        el_log_format = p.get("el_log_format", "")
        if global_log_format:
            if not cl_log_format:
                p["cl_log_format"] = global_log_format
            if not el_log_format:
                p["el_log_format"] = global_log_format

        # Fill in any missing fields with default values.
        for k, v in DEFAULT_POLYGON_POS_PARTICIPANT.items():
            p.setdefault(k, v)

        # Fill in any missing fields with default values for bor participants.
        if el_type == constants.EL_TYPE.bor:
            for k, v in DEFAULT_POLYGON_POS_EL_BOR_PARTICIPANT.items():
                p.setdefault(k, v)

        # Set devnet CL type using the first participant CL type.
        if devnet_cl_type == "":
            devnet_cl_type = p.get("cl_type")

        # Make sure that CL types have not been mixed.
        if p.get("cl_type") != devnet_cl_type:
            fail(
                'Mixing different CL types is not supported. Got "{}" and "{}".'.format(
                    devnet_cl_type, cl_type
                )
            )

        # Assign the modified dictionary back to the list.
        participants_with_defaults.append(p)

    # Sort each participant dictionary and return the result
    return [_sort_dict_by_values(p) for p in participants_with_defaults]


def _get_devnet_cl_type(participants):
    # Determine the devnet CL type to be able to select the appropriate validator address format later.
    return participants[0].get("cl_type")


def _parse_setup_images(setup_images):
    # Create a mutable copy of setup_images.
    if setup_images:
        # Create a mutable copy of setup_images.
        setup_images = dict(setup_images)
    else:
        # Set default matic contracts params if not provided.
        setup_images = dict(DEFAULT_POLYGON_POS_PACKAGE_ARGS.get("setup_images", {}))

    for k, v in DEFAULT_POLYGON_POS_PACKAGE_ARGS.get("setup_images", {}).items():
        setup_images.setdefault(k, v)

    # Sort the dict and return the result.
    return _sort_dict_by_values(setup_images)


def _parse_network_params(network_params):
    if network_params:
        # Create a mutable copy of network_params.
        network_params = dict(network_params)
    else:
        # Set default network params if not provided.
        network_params = dict(
            DEFAULT_POLYGON_POS_PACKAGE_ARGS.get("network_params", {})
        )

    for k, v in DEFAULT_POLYGON_POS_PACKAGE_ARGS.get("network_params", {}).items():
        network_params.setdefault(k, v)

    # Sort the dict and return the result.
    return _sort_dict_by_values(network_params)


def _parse_additional_services(additional_services):
    # Set default additional services if not provided.
    if len(additional_services) == 0:
        additional_services = DEFAULT_POLYGON_POS_PACKAGE_ARGS.get(
            "additional_services", []
        )
    return additional_services


def _parse_test_runner_params(is_test_runner_deployed, test_runner_params):
    # If the test runner is not deployed, return an empty dict.
    if not is_test_runner_deployed:
        return {}

    # Create a mutable copy of test_runner_params.
    if test_runner_params:
        test_runner_params = dict(test_runner_params)
    else:
        # Set default test runner params if not provided.
        test_runner_params = dict(
            DEFAULT_POLYGON_POS_PACKAGE_ARGS.get("test_runner_params", {})
        )

    for k, v in DEFAULT_POLYGON_POS_PACKAGE_ARGS.get("test_runner_params", {}).items():
        test_runner_params.setdefault(k, v)

    # Sort the dict and return the result.
    return _sort_dict_by_values(test_runner_params)


def _parse_status_checker_params(is_status_checker_deployed, status_checker_params):
    # If the status checker is not deployed, return an empty dict.
    if not is_status_checker_deployed:
        return {}

    # Create a mutable copy of status_checker_params.
    if status_checker_params:
        status_checker_params = dict(status_checker_params)
    else:
        # Set default status checker params if not provided.
        status_checker_params = dict(
            DEFAULT_POLYGON_POS_PACKAGE_ARGS.get("status_checker_params", {})
        )

    for k, v in DEFAULT_POLYGON_POS_PACKAGE_ARGS.get(
        "status_checker_params", {}
    ).items():
        status_checker_params.setdefault(k, v)

    # Sort the dict and return the result.
    return _sort_dict_by_values(status_checker_params)


def _sort_dict_by_values(d):
    sorted_items = sorted(d.items(), key=lambda x: x[0])
    return {k: v for k, v in sorted_items}
