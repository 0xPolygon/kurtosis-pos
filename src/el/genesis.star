constants = import_module("../config/constants.star")
hex = import_module("../hex/hex.star")
math = import_module("../math/math.star")


EL_GENESIS_BUILDER_SCRIPT_FILE_PATH = "../../static_files/el/genesis/builder.sh"
EL_GENESIS_TEMPLATE_FILE_PATH = "../../static_files/el/genesis/genesis.json"


def generate(plan, polygon_pos_args, validator_config_artifact, admin_address):
    network_params = polygon_pos_args.get("network_params")
    setup_images = polygon_pos_args.get("setup_images")

    # Generate a temporary EL genesis with an empty `alloc` field.
    el_genesis_temporary_artifact = plan.render_templates(
        name="l2-el-genesis-tmp",
        config={
            "genesis.json": struct(
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

    # Generate the alloc field of the EL genesis and return the final EL genesis.
    el_genesis_builder_script_artifact = plan.upload_files(
        src=EL_GENESIS_BUILDER_SCRIPT_FILE_PATH,
        name="l2-el-genesis-builder-config",
    )
    result = plan.run_sh(
        name="l2-el-genesis-generator",
        description="Generating L2 EL genesis",
        image=setup_images.get("el_genesis_builder"),
        env_vars={
            "EL_CHAIN_ID": network_params.get("el_chain_id"),
            "DEFAULT_EL_CHAIN_ID": constants.EL_CHAIN_ID,
            "CL_CHAIN_ID": network_params.get("cl_chain_id"),
            "DEFAULT_CL_CHAIN_ID": constants.CL_CHAIN_ID,
            # Note that we don't add the admin address to the alloc in starlark because
            # admin_address is a Kurtosis future string. We can't perform any string
            # operations on it like removing the "0x" prefix. We do it in the bash script.
            "ADMIN_ADDRESS": admin_address,
            "ADMIN_BALANCE_WEI": hex.int_to_hex(
                math.ether_to_wei(constants.ADMIN_BALANCE_ETH)
            ),
        },
        files={
            # Load the artefacts one by one instead of using a Directory because it is not
            # supported by Kurtosis when using plan.run_sh unfortunately.
            "/opt/data/genesis": el_genesis_temporary_artifact,
            "/opt/data/genesis-builder": el_genesis_builder_script_artifact,
            "/opt/data/validator": validator_config_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/data/genesis/genesis.json",
                name="l2-el-genesis",
            ),
        ],
        run="bash /opt/data/genesis-builder/builder.sh",
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
