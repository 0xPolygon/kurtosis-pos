constants = import_module("./constants.star")
math = import_module("../math/math.star")
prefunded_accounts_module = import_module("../prefunded_accounts/accounts.star")


POLYGON_POS_PARAMS = {
    "log_level": [],
    "log_format": [],
    "participants": [
        "kind",
        "cl_type",
        "cl_image",
        "cl_log_level",
        "cl_log_format",
        "cl_queue_image",
        "cl_min_retain_blocks",
        "cl_compact_enabled",
        "cl_compaction_interval",
        "cl_storage_pruning_interval",
        "cl_indexer_pruning_enabled",
        "el_type",
        "el_image",
        "el_log_level",
        "el_log_format",
        "el_bor_produce_witness",  # Allow bor to start producing witnesses.
        "el_bor_sync_with_witness",  # Enable bor to sync new blocks using witnesses.
        "el_bor_stateless_parallel_import",  # Enable bor to use parallel import in stateless mode.
        "count",
    ],
    "setup_images": [
        "contract_deployer",
        "el_genesis_builder",
        "validator_config_generator",
    ],
    "network_params": [
        "admin_private_key",
        "preregistered_validator_keys_mnemonic",
        "validator_stake_amount_eth",
        "validator_top_up_fee_amount_eth",
        # consensus layer
        "cl_chain_id",
        "cl_environment",
        "cl_span_poll_interval",
        "cl_checkpoint_poll_interval",
        "cl_max_age_num_blocks",
        # execution layer
        "el_chain_id",
        "el_block_interval_seconds",
        "el_sprint_duration",
        "el_span_duration",
        "el_gas_limit",
        # hardforks
        "jaipur_fork_block",
        "delhi_fork_block",
        "indore_fork_block",
        "agra_fork_block",
        "napoli_fork_block",
        "ahmedabad_fork_block",
        "bhilai_fork_block",
        "rio_fork_block",
        "madhugiri_fork_block",
        "madhugiri_pro_fork_block",
        "dandeli_fork_block",
        "lisovo_fork_block",
    ],
    "additional_services": [
        getattr(constants.ADDITIONAL_SERVICES, field)
        for field in dir(constants.ADDITIONAL_SERVICES)
    ],
    "status_checker_params": [
        "image",
    ],
    "ethstats_server_params": [
        "image",
        "ws_secret",
    ],
}

VALID_L1_BACKENDS = [
    constants.L1_BACKEND.anvil,
    constants.L1_BACKEND.ethereum_package,
]

VALID_PARTICIPANT_KINDS = [
    constants.PARTICIPANT_KIND.validator,
    constants.PARTICIPANT_KIND.rpc,
    constants.PARTICIPANT_KIND.archive,
]

VALID_CL_CLIENTS = [constants.CL_TYPE.heimdall_v2]
VALID_EL_CLIENTS = [constants.EL_TYPE.bor, constants.EL_TYPE.erigon]
VALID_CLIENT_COMBINATIONS = {
    constants.CL_TYPE.heimdall_v2: [
        constants.EL_TYPE.bor,
        constants.EL_TYPE.erigon,
    ],
}

VALID_CL_ENVIRONMENTS = [
    constants.CL_ENVIRONMENT.mainnet,
    constants.CL_ENVIRONMENT.mumbai,
    constants.CL_ENVIRONMENT.local,
]

VALID_LOG_LEVELS = [
    constants.LOG_LEVEL.error,
    constants.LOG_LEVEL.warn,
    constants.LOG_LEVEL.info,
    constants.LOG_LEVEL.debug,
    constants.LOG_LEVEL.trace,
]

VALID_LOG_FORMATS = [
    constants.LOG_FORMAT.text,
    constants.LOG_FORMAT.json,
]

DEV_PARAMS = [
    "l1_backend",
    "should_deploy_l1",  # boolean
    "l1_rpc_url",
    "should_deploy_matic_contracts",  # boolean
    "l2_el_genesis_filepath",
    "l2_cl_genesis_filepath",
    "matic_contract_addresses_filepath",
]


def sanity_check_polygon_args(plan, input_args):
    # Validate top-level config.
    for param in input_args.keys():
        if param not in POLYGON_POS_PARAMS.keys():
            fail(
                'Invalid parameter: "{}". Allowed fields: {}.'.format(
                    param, POLYGON_POS_PARAMS.keys()
                )
            )

    # Validate keys.
    _validate_str(input_args, "log_level", VALID_LOG_LEVELS)
    _validate_str(input_args, "log_format", VALID_LOG_FORMATS)
    _validate_list_of_dict(input_args, "participants")
    _validate_dict(input_args, "setup_images")
    _validate_dict(input_args, "network_params")
    _validate_list(input_args, "additional_services")

    # Validate values.
    network_params = input_args.get("network_params")
    cl_chain_id = network_params.get("cl_chain_id")
    el_chain_id = network_params.get("el_chain_id")
    _validate_chain_ids(cl_chain_id, el_chain_id)

    participants = input_args.get("participants")
    _validate_participants_count(participants)
    for p in participants:
        _validate_participant(p)

    setup_images = input_args.get("setup_images")
    validator_config_generator_image = setup_images.get("validator_config_generator")
    heimdall_v2_image = participants[0].get("cl_image")
    _validate_validator_config_generator_image(
        plan, validator_config_generator_image, heimdall_v2_image
    )

    cl_environment = network_params.get("cl_environment")
    _validate_cl_environment(cl_environment)

    # Make sure status checker params are defined only if the status checker is deployed.
    additional_services = input_args.get("additional_services", [])
    if constants.ADDITIONAL_SERVICES.status_checker in additional_services:
        _validate_dict(input_args, "status_checker_params")
        status_checker_params = input_args.get("status_checker_params")
        if not "image" in status_checker_params:
            fail(
                '`status_checker_params` must include the "image" field when the status checker is deployed'
            )
    else:
        status_checker_params = input_args.get("status_checker_params", {})
        if status_checker_params:
            fail(
                "`status_checker_params` must be empty when the status checker is not deployed."
            )

    # Make sure ethstats server params are defined only if the ethstats server is deployed.
    if constants.ADDITIONAL_SERVICES.ethstats_server in additional_services:
        _validate_dict(input_args, "ethstats_server_params")
        ethstats_server_params = input_args.get("ethstats_server_params")
        if not "image" in ethstats_server_params:
            fail(
                '`ethstats_server_params` must include the "image" field when the status checker is deployed'
            )
    else:
        ethstats_server_params = input_args.get("ethstats_server_params", {})
        if ethstats_server_params:
            fail(
                "`ethstats_server_params` must be empty when the status checker is not deployed."
            )

    plan.print("Sanity check passed")


def sanity_check_dev_args(plan, input_args):
    # Validate top-level config.
    for param in input_args.keys():
        if param not in DEV_PARAMS:
            fail(
                'Invalid parameter: "{}". Allowed fields: {}.'.format(param, DEV_PARAMS)
            )

    # Validate values.
    l1_backend = input_args.get("l1_backend")
    if l1_backend not in VALID_L1_BACKENDS:
        fail(
            'Invalid L1 backend: "{}". Allowed values: {}.'.format(
                l1_backend, VALID_L1_BACKENDS
            )
        )

    should_deploy_l1 = input_args.get("should_deploy_l1")
    if not should_deploy_l1:
        l1_rpc_url = input_args.get("l1_rpc_url")
        if l1_rpc_url == "":
            fail(
                "`dev.l1_rpc_url` must be specified when `dev.should_deploy_l1` is set to false!"
            )

    should_deploy_matic_contracts = input_args.get("should_deploy_matic_contracts")
    if not should_deploy_matic_contracts:
        l2_el_genesis_filepath = input_args.get("l2_el_genesis_filepath")
        if l2_el_genesis_filepath == "":
            fail(
                "`dev.l2_el_genesis_filepath` must be specified when `dev.should_deploy_matic_contracts` is set to false!"
            )

        l2_cl_genesis_filepath = input_args.get("l2_cl_genesis_filepath")
        if l2_cl_genesis_filepath == "":
            fail(
                "`dev.l2_cl_genesis_filepath` must be specified when `dev.should_deploy_matic_contracts` is set to false!"
            )

        matic_contract_addresses_filepath = input_args.get(
            "matic_contract_addresses_filepath", ""
        )
        if matic_contract_addresses_filepath == "":
            fail(
                "`dev.matic_contract_addresses_filepath` must be specified when `dev.should_deploy_matic_contracts` is set to false!"
            )


def _validate_list(input_args, category):
    allowed_values = POLYGON_POS_PARAMS[category]
    if category in input_args:
        for item in input_args[category]:
            if item not in allowed_values:
                fail(
                    'Invalid item: "{}" in "{}" list. Allowed items: {}.'.format(
                        item,
                        category,
                        allowed_values,
                    )
                )


def _validate_dict(input_args, category):
    allowed_params = POLYGON_POS_PARAMS[category]
    if category in input_args:
        item = input_args[category]
        if item:
            for param in item.keys():
                if param not in allowed_params:
                    fail(
                        'Invalid key: "{}" in "{}" dict. Allowed keys: {}.'.format(
                            param, category, allowed_params
                        )
                    )


def _validate_list_of_dict(input_args, category):
    allowed_keys = POLYGON_POS_PARAMS[category]
    if category in input_args:
        for item in input_args[category]:
            for key in item.keys():
                if key not in allowed_keys:
                    fail(
                        'Invalid key: "{}" in "{}" list of dict. Allowed keys: {}.'.format(
                            key, category, allowed_keys
                        )
                    )


# Heimdall-v2 expects that the cl chain id follows the standard "heimdall-<el_chain_id>".
def _validate_chain_ids(cl_chain_id, el_chain_id):
    if not cl_chain_id and not el_chain_id:
        return

    expected_cl_chain_id = "heimdall-" + str(el_chain_id)
    if cl_chain_id != expected_cl_chain_id:
        fail(
            'CL chain id must follow the standard "heimdall-<el_chain_id>". Expected "{}" but got: "{}".'.format(
                expected_cl_chain_id, cl_chain_id
            )
        )


def _validate_participants_count(participants):
    participants_count = math.sum([p.get("count") for p in participants])
    if participants_count >= len(prefunded_accounts_module.PREFUNDED_ACCOUNTS):
        fail(
            "The total number of participants '{}' exceeds the number of prefunded accounts '{}'. Please generate additional prefunded accounts by following the instructions in 'src/prefunded_accounts/README.md'.".format(
                participants_count, len(prefunded_accounts_module.PREFUNDED_ACCOUNTS)
            )
        )


def _validate_participant(p):
    _validate_str(p, "kind", VALID_PARTICIPANT_KINDS)
    _validate_str(p, "cl_type", VALID_CL_CLIENTS)
    _validate_str(p, "el_type", VALID_EL_CLIENTS)

    # Validate client combination.
    cl_type = p.get("cl_type")
    el_type = p.get("el_type")
    if cl_type in VALID_CLIENT_COMBINATIONS:
        valid_combinations = VALID_CLIENT_COMBINATIONS[cl_type]
        if el_type not in valid_combinations:
            fail(
                'Invalid client combination. The CL client "{}" does not support the EL client "{}". Valid combinations are: "{}".'.format(
                    cl_type, el_type, valid_combinations
                )
            )
    else:
        fail('The CL client "{}" has no valid client combination.'.format(cl_type))

    _validate_str(p, "cl_log_level", VALID_LOG_LEVELS)
    _validate_str(p, "el_log_level", VALID_LOG_LEVELS)
    _validate_str(p, "cl_log_format", VALID_LOG_FORMATS)
    _validate_str(p, "el_log_format", VALID_LOG_FORMATS)
    _validate_strictly_positive_int(p, "count")

    # Validate bor specific parameters.
    if el_type != constants.EL_TYPE.bor:
        _fail_if_not_bor_el_type(p, "el_bor_produce_witness")
        _fail_if_not_bor_el_type(p, "el_bor_sync_with_witness")

    if not (el_type == constants.EL_TYPE.bor and p.get("el_bor_sync_with_witness")):
        stateless_parallel_import = p.get("el_bor_stateless_parallel_import")
        if stateless_parallel_import:
            fail(
                'The "el_bor_stateless_parallel_import" parameter can only be enabled with bor EL client and when "el_bor_sync_with_witness" is set to true.'
            )


def _validate_validator_config_generator_image(plan, image, heimdall_v2_image):
    validator_config_generator_tag = image.split(":")[1]
    heimdall_v2_tag = heimdall_v2_image.split(":")[1]
    if validator_config_generator_tag != heimdall_v2_tag:
        plan.print(
            'WARN: The validator_config_generator image tag "{}" does not match the heimdall-v2 image tag "{}".'.format(
                validator_config_generator_tag, heimdall_v2_tag
            )
        )


# The CL environment is used to specify the height for applying specific selection algorithms, span
# overrides, or hardforks. It also determines the default seeds.
def _validate_cl_environment(cl_environment):
    if cl_environment:
        if cl_environment not in VALID_CL_ENVIRONMENTS:
            fail(
                'Invalid CL environment: "{}". Allowed values: {}.'.format(
                    cl_environment, VALID_CL_ENVIRONMENTS
                )
            )


def _fail_if_not_bor_el_type(input, attribute):
    value = input.get(attribute)
    if input.get("el_type") != constants.EL_TYPE.bor and value:
        fail(
            'The "{}" parameter is only valid for the bor EL client.'.format(attribute)
        )


def _validate_str(input, attribute, allowed_values):
    value = input.get(attribute)
    if value and value not in allowed_values:
        fail(
            'Invalid "{}" attribute: "{}". Allowed value(s): {}.'.format(
                attribute, value, allowed_values
            )
        )


def _validate_strictly_positive_int(input, attribute):
    value = input.get(attribute)
    if value == 0:
        fail(
            'Invalid "{}": must be strictly positive, got: {}.'.format(attribute, value)
        )
