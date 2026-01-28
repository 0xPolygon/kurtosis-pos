constants = import_module("../config/constants.star")
hex = import_module("../hex/hex.star")
math = import_module("../math/math.star")


EL_GENESIS_BUILDER_SCRIPT_FILE_PATH = "../../static_files/el/genesis/builder.sh"
EL_GENESIS_TEMPLATE_FILE_PATH = "../../static_files/el/genesis/genesis.json"


def generate(plan, polygon_pos_args, validator_accounts, admin_address):
    network_params = polygon_pos_args.get("network_params")
    setup_images = polygon_pos_args.get("setup_images")

    # Generate a temporary EL genesis with hardcoded contracts allocation.
    el_genesis_temporary_artifact = plan.render_templates(
        name="l2-el-genesis-tmp",
        config={
            "genesis-tmp.json": struct(
                template=read_file(EL_GENESIS_TEMPLATE_FILE_PATH),
                data={
                    # chain params
                    "el_chain_id": network_params.get("el_chain_id"),
                    "el_sprint_duration": network_params.get("el_sprint_duration"),
                    "el_gas_limit_hex": hex.int_to_hex(
                        network_params.get("el_gas_limit")
                    ),
                    # hardfork configurations
                    "jaipur_fork_block": network_params.get("jaipur_fork_block"),
                    "delhi_fork_block": network_params.get("delhi_fork_block"),
                    "indore_fork_block": network_params.get("indore_fork_block"),
                    "agra_fork_block": network_params.get("agra_fork_block"),
                    "napoli_fork_block": network_params.get("napoli_fork_block"),
                    "ahmedabad_fork_block": network_params.get("ahmedabad_fork_block"),
                    "bhilai_fork_block": network_params.get("bhilai_fork_block"),
                    "rio_fork_block": network_params.get("rio_fork_block"),
                    "madhugiri_fork_block": network_params.get("madhugiri_fork_block"),
                    "madhugiri_pro_fork_block": network_params.get(
                        "madhugiri_pro_fork_block"
                    ),
                    "dandeli_fork_block": network_params.get("dandeli_fork_block"),
                },
            )
        },
    )

    # The template that Kurtosis generates is not a valid json thus if you want to check the content
    # of the file artifact, Kurtosis will render an empty file... This is a hack to format the file
    # with jq and get a working artifact.
    el_genesis_builder_script_artifact = plan.upload_files(
        src=EL_GENESIS_BUILDER_SCRIPT_FILE_PATH,
        name="l2-el-genesis-builder-config",
    )
    validator_alloc = _generator_validator_alloc(validator_accounts)
    result = plan.run_sh(
        name="l2-el-genesis-generator",
        description="Generating L2 EL genesis",
        env_vars={
            "VALIDATOR_ALLOC": json.indent(json.encode(validator_alloc)),
            # Note that we don't add the admin address to the alloc in starlark because
            # admin_address is a Kurtosis future string. We can't perform any string
            # operations on it like removing the "0x" prefix. We do it in the bash script.
            "ADMIN_ADDRESS": admin_address,
            "ADMIN_BALANCE_WEI": hex.int_to_hex(
                math.ether_to_wei(constants.ADMIN_BALANCE_ETH)
            ),
        },
        files={
            "/opt/data/genesis": el_genesis_temporary_artifact,
            "/opt/data/genesis-builder": el_genesis_builder_script_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/data/genesis/genesis.json",
                name="l2-el-genesis",
            ),
        ],
        run="sh /opt/data/genesis-builder/builder.sh",
    )
    artifact_count = len(result.files_artifacts)
    if artifact_count != 1:
        fail(
            "The EL genesis generator should have generated 1 artifact, got {}.".format(
                artifact_count
            )
        )
    l2_el_genesis_artifact = result.files_artifacts[0]
    return l2_el_genesis_artifact


def _generator_validator_alloc(validator_accounts):
    alloc = {}
    balance_wei = hex.int_to_hex(math.ether_to_wei(constants.VALIDATORS_BALANCE_ETH))
    for v in validator_accounts:
        validator_address = v.cometbft.address.removeprefix("0x")
        alloc[validator_address] = {"balance": balance_wei}
    return alloc
