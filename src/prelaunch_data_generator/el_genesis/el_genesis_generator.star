constants = import_module("../../package_io/constants.star")
hex = import_module("../../hex/hex.star")


EL_GENESIS_CONFIG_FOLDER_PATH = "../../../static_files/genesis/el"
EL_GENESIS_TEMPLATE_FILE_PATH = "../../../static_files/genesis/el/genesis.json"


def generate_el_genesis_data(plan, polygon_pos_args, validator_config_artifact):
    network_params = polygon_pos_args.get("network_params", {})
    matic_contracts_params = polygon_pos_args.get("matic_contracts_params", {})

    # Generate a temporary EL genesis.
    el_genesis_config_artifact = plan.upload_files(
        src=EL_GENESIS_CONFIG_FOLDER_PATH,
        name="l2-genesis-builder-config",
    )

    result = plan.run_sh(
        name="l2-el-genesis-generator",
        description="Generating L2 EL genesis",
        image=matic_contracts_params.get("genesis_builder_image"),
        env_vars={
            "BOR_ID": network_params.get("bor_id", ""),
            "DEFAULT_BOR_ID": constants.DEFAULT_BOR_ID,
            "HEIMDALL_ID": network_params.get("heimdall_id", ""),
            "DEFAULT_HEIMDALL_ID": constants.DEFAULT_HEIMDALL_ID,
        },
        files={
            # Load the artefacts one by one instead of using a Directory because it is not
            # supported by Kurtosis when using plan.run_sh unfortunately.
            "/opt/data/genesis": el_genesis_config_artifact,
            "/opt/data/validator": validator_config_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/genesis-contracts/genesis.json",
                name="l2-el-genesis-tmp",
            ),
        ],
        run="bash /opt/data/genesis/genesis-builder.sh && cat /opt/genesis-contracts/genesis.json",
    )
    artifact_count = len(result.files_artifacts)
    if artifact_count != 1:
        fail(
            "The EL genesis generator should have generated 1 artifact, got {}.".format(
                artifact_count
            )
        )
    el_genesis_temporary_artifact = result.files_artifacts[0]

    # Retrieve the allocs field from the temporary EL genesis.
    el_genesis_allocs = _read_el_genesis_allocs(plan, el_genesis_config_artifact)

    # Render the final genesis of the EL using the template.
    return plan.render_templates(
        name="l2-el-genesis",
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
                    "allocs": el_genesis_allocs,
                },
            )
        },
    )


def _read_el_genesis_allocs(plan, el_genesis_artifact):
    result = plan.run_sh(
        description="Reading EL genesis allocs",
        files={
            "/opt/data": el_genesis_artifact,
        },
        # Return the result as a list instead of a string.
        run="jq --raw-output '.allocs' /opt/data/genesis.json",
    )
    return result.output
