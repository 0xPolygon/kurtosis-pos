constants = import_module("../../package_io/constants.star")
hex = import_module("../../hex/hex.star")


EL_GENESIS_BUILDER_SCRIPT_FILE_PATH = (
    "../../../static_files/genesis/el/genesis-builder.sh"
)
EL_GENESIS_TEMPLATE_FILE_PATH = "../../../static_files/genesis/el/genesis.json"


def generate_el_genesis_data(plan, polygon_pos_args, validator_config_artifact):
    network_params = polygon_pos_args.get("network_params", {})
    matic_contracts_params = polygon_pos_args.get("matic_contracts_params", {})

    # Generate a temporary EL genesis with an empty `alloc` field.
    el_genesis_temporary_artifact = plan.render_templates(
        name="l2-el-genesis-tmp",
        config={
            "genesis.json": struct(
                template=read_file(EL_GENESIS_TEMPLATE_FILE_PATH),
                data={
                    "bor_chain_id": network_params.get("bor_id", ""),
                    "bor_block_interval_seconds": network_params.get(
                        "bor_block_interval_seconds", ""
                    ),
                    "bor_sprint_duration": network_params.get(
                        "bor_sprint_duration", ""
                    ),
                    "bor_gas_limit_hex": hex.int_to_hex(
                        network_params.get("bor_gas_limit", 0)
                    ),
                },
            )
        },
    )

    # Generate the alloc field of the EL genesis and return the final EL genesis.
    el_genesis_builder_script_artifact = plan.upload_files(
        src=EL_GENESIS_BUILDER_SCRIPT_FILE_PATH,
        name="l2-genesis-builder-config",
    )
    return plan.run_sh(
        name="l2-el-genesis-generator",
        description="Generating L2 EL genesis",
        image=matic_contracts_params.get("el_genesis_builder_image"),
        env_vars={
            "BOR_ID": network_params.get("bor_id", ""),
            "DEFAULT_BOR_ID": constants.DEFAULT_BOR_ID,
            "CL_ID": network_params.get("cl_id", ""),
            "DEFAULT_CL_ID": constants.DEFAULT_CL_ID,
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
        run="&&".join(
            [
                # Generate the L2 EL genesis alloc field.
                "bash /opt/data/genesis-builder/genesis-builder.sh",
                # Add the alloc field to the temporary EL genesis to create the final EL genesis.
                "jq --arg key 'alloc' '. + {($key): input | .[$key]}' /opt/data/genesis/genesis.json /opt/genesis-contracts/genesis.json > tmp.json",
                "mv tmp.json /opt/data/genesis/genesis.json",
                # Print the final EL genesis.
                "cat /opt/data/genesis/genesis.json",
            ]
        ),
    )
