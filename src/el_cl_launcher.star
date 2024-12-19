bor = import_module("./el/bor/bor_launcher.star")
constants = import_module("./package_io/constants.star")
erigon = import_module("./el/erigon/erigon_launcher.star")
genesis_constants = import_module(
    "./prelaunch_data_generator/genesis_constants/genesis_constants.star"
)
heimdall = import_module("./cl/heimdall/heimdall_launcher.star")


HEIMDALL_VALIDATOR_CONFIG_GENERATOR_FOLDER_PATH = "../static_files/heimdall"


def launch(
    plan,
    participants,
    validator_accounts,
    polygon_pos_args,
    el_genesis_artifact,
    cl_genesis_artifact,
    l1_rpc_url,
):
    network_params = polygon_pos_args["network_params"]
    matic_contracts_params = polygon_pos_args["matic_contracts_params"]

    el_launchers = {
        "bor": {
            "launch_method": bor.launch,
        },
        "erigon": {
            "launch_method": erigon.launch,
        },
    }

    cl_launchers = {
        "heimdall": {
            "launch_method": heimdall.launch,
        }
    }

    prefunded_accounts = genesis_constants.PRE_FUNDED_ACCOUNTS
    heimdall_config_generator_artifacts = _generate_heimdall_config(
        plan, participants, prefunded_accounts, polygon_pos_args
    )
    persistent_peers_artifact = heimdall_config_generator_artifacts.persistent_peers
    plan.print(persistent_peers_artifact)

    cl_node_ids = _read_heimdall_persistent_peers(plan, persistent_peers_artifact)
    plan.print(cl_node_ids)

    # TODO: Transform node ids into persistent peers.

    "node_id@node_address,"

    for i, participant in enumerate(participants):
        plan.print(
            "Launching participant {} with config {}".format(i, str(participant))
        )

        el_type = participant["el_type"]
        if el_type not in el_launchers:
            fail(
                "Unsupported EL launcher '{0}', need one of '{1}'".format(
                    el_type, ",".join(el_launchers.keys())
                )
            )

        cl_type = participant["cl_type"]
        if cl_type not in cl_launchers:
            fail(
                "Unsupported CL launcher '{0}', need one of '{1}'".format(
                    cl_type, ",".join(cl_launchers.keys())
                )
            )

        el_launch_method = el_launchers[el_type]["launch_method"]
        cl_launch_method = cl_launchers[cl_type]["launch_method"]

        el_node_name = "{}-{}".format(el_type, i)
        cl_node_name = "{}-{}".format(cl_type, i)
        cl_validator_config_artifact = heimdall_config_generator_artifacts.configs[i]
        cl_context = cl_launch_method(
            plan,
            i,
            cl_node_name,
            el_node_name,
            participant,
            network_params,
            cl_genesis_artifact,
            cl_validator_config_artifact,
            cl_node_ids,
            l1_rpc_url,
        )


def _generate_heimdall_config(plan, participants, prefunded_accounts, polygon_pos_args):
    # Get Heimdall validator node and private keys.
    # Also generate the store spec that will be used to save such keys later.
    heimdall_validator_configs = []
    heimdall_validator_keys_store = []
    for i, participant in enumerate(participants):
        cl_type = participant["cl_type"]
        if cl_type == constants.CL_TYPE.heimdall:
            private_key = prefunded_accounts[i].private_key
            p2p_url = "{}-{}:{}".format(
                cl_type, i, 26656
            )  # TODO: Don't hardcode this port!
            heimdall_validator_configs.append("{},{}".format(private_key, p2p_url))

            validator_id = i + 1
            heimdall_validator_keys_store.append(
                StoreSpec(
                    src="{}/{}/config".format(
                        constants.HEIMDALL_CONFIG_PATH, validator_id
                    ),
                    name="heimdall-validator-{}-config".format(validator_id),
                )
            )
    heimdall_validator_configs_str = ";".join(heimdall_validator_configs)
    plan.print(
        "DEBUG: heimdall_validator_configs_str {}".format(
            heimdall_validator_configs_str
        )
    )

    # Generate Heimdall validators configuration such as the public/private keys and node identifiers.
    heimdall_config_generator_artifact = plan.upload_files(
        src=HEIMDALL_VALIDATOR_CONFIG_GENERATOR_FOLDER_PATH,
        name="heimdall-config-generator-config",
    )

    matic_contracts_params = polygon_pos_args["matic_contracts_params"]
    heimdall_config_generator_image = matic_contracts_params[
        "heimdall_config_generator_image"
    ]

    network_params = polygon_pos_args["network_params"]
    heimdall_id = network_params["heimdall_id"]
    result = plan.run_sh(
        name="heimdall-validators-config-generator",
        image=heimdall_config_generator_image,
        env_vars={
            "HEIMDALL_ID": heimdall_id,
            "HEIMDALL_CONFIG_PATH": constants.HEIMDALL_CONFIG_PATH,
            "HEIMDALL_VALIDATOR_CONFIGS": heimdall_validator_configs_str,
        },
        files={
            "/opt/data": heimdall_config_generator_artifact,
        },
        store=heimdall_validator_keys_store
        + [
            StoreSpec(
                src="{}/persistent_peers.txt".format(constants.HEIMDALL_CONFIG_PATH),
                name="heimdall-persistent-peers",
            )
        ],
        run="bash /opt/data/validator_setup.sh",
    )
    # Artifacts are ordered to match the `StoreSpec` definitions.
    heimdall_validator_config_artifacts = result.files_artifacts[:-1]
    heimdall_persistent_peers_artifact = result.files_artifacts[-1]
    return struct(
        configs=heimdall_validator_config_artifacts,
        persistent_peers=heimdall_persistent_peers_artifact,
    )


def _read_heimdall_persistent_peers(plan, heimdall_persistent_peers):
    result = plan.run_sh(
        description="Read heimdall validator node ids",
        image="leovct/toolbox:0.0.7",
        files={
            "/opt/data": heimdall_persistent_peers,
        },
        run="cat /opt/data/persistent_peers.txt | tr -d '\n'",
    )
    # Return the result as a list instead of a string.
    return result.output
