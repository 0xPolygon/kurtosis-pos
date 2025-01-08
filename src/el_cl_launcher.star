bor = import_module("./el/bor/bor_launcher.star")
constants = import_module("./package_io/constants.star")
erigon = import_module("./el/erigon/erigon_launcher.star")
pre_funded_accounts = import_module(
    "./prelaunch_data_generator/genesis_constants/pre_funded_accounts.star"
)
heimdall = import_module("./cl/heimdall/heimdall_launcher.star")


VALIDATOR_CONFIG_GENERATOR_FOLDER_PATH = "../static_files/validator"


def launch(
    plan,
    participants,
    validator_accounts,
    polygon_pos_args,
    el_genesis_artifact,
    cl_genesis_artifact,
    l1_rpc_url,
):
    prefunded_accounts = pre_funded_accounts.PRE_FUNDED_ACCOUNTS
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

    # Generate CL node artifacts.
    validator_config_artifacts = _generate_validator_config(
        plan, participants, prefunded_accounts, polygon_pos_args
    )

    # Aggregate CL node identifiers.
    persistent_peers_artifact = validator_config_artifacts.persistent_peers
    cl_node_ids = _read_cl_persistent_peers(plan, persistent_peers_artifact)

    # Get CL node rpc urls.
    cl_node_rpc_urls = _get_cl_rpc_urls(plan, participants)
    cl_node_url = cl_node_rpc_urls[0]

    # Aggregate EL node enodes.
    # Format: static-nodes = [ "enode://<eth_public_key>@<hostname>:<discovery_port_number>", "enode://<eth_public_key>@<hostname>:<discovery_port_number>" ]
    # Example: static-nodes = [ "enode://ad9180a1468702c7c6a7210544593b4bd444768ca754382d1da92fe9abaf408e58160dc72505936df63ca6afc3052e993cade199fe3ff067a5f11b0ee3c6e378@13.209.168.182:30303", "enode://7cf051238a3f92bbee811472a84592ab547ab2692ec09bd2104182551ca6de55f5a7cea48a3d36b411deccb4df976f27076d32019d9ccc4486a916c0e30f3a74@43.201.242.62:30303" ]
    bor_static_nodes = _aggregate_el_enodes(participants, prefunded_accounts)

    for i, participant in enumerate(participants):
        el_type = participant["el_type"]
        if el_type not in el_launchers:
            fail(
                "Unsupported EL launcher '{0}', need one of '{1}'".format(
                    el_type, ",".join(el_launchers.keys())
                )
            )
        el_launch_method = el_launchers[el_type]["launch_method"]

        cl_type = participant["cl_type"]
        if cl_type not in cl_launchers:
            fail(
                "Unsupported CL launcher '{0}', need one of '{1}'".format(
                    cl_type, ",".join(cl_launchers.keys())
                )
            )
        cl_launch_method = cl_launchers[cl_type]["launch_method"]

        is_validator = participant["is_validator"]
        plan.print(
            "Launching {} {} ({}/{} validator) with config: {}".format(
                "validator" if is_validator else "rpc",
                i,
                cl_type,
                el_type,
                str(participant),
            )
        )

        el_node_name = "l2-el-{}-{}-{}".format(
            i + 1,
            el_type,
            cl_type,
        )
        cl_node_name = "l2-cl-{}-{}-{}".format(
            i + 1,
            cl_type,
            el_type,
        )

        if is_validator:
            cl_validator_config_artifact = validator_config_artifacts.cl_configs[i]
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
            cl_node_url = cl_context.ports[
                "http"
            ].url  # TODO: Do not hardcode the port name!

        el_validator_config_artifact = None
        if is_validator:
            el_validator_config_artifact = validator_config_artifacts.el_configs[i]

        el_context = el_launch_method(
            plan,
            el_node_name,
            participant,
            el_genesis_artifact,
            el_validator_config_artifact,
            cl_node_url,
            prefunded_accounts[i],
            bor_static_nodes,
        )


def _generate_validator_config(
    plan, participants, prefunded_accounts, polygon_pos_args
):
    # Get CL validator node and private keys.
    # Also generate the store spec that will be used to save such keys later.
    cl_validator_configs = []
    cl_validator_keys_store = []
    el_validator_keys_store = []
    for i, participant in enumerate(participants):
        if participant["is_validator"]:
            validator_id = i + 1
            cl_type = participant["cl_type"]
            el_type = participant["el_type"]
            private_key = prefunded_accounts[i].private_key
            p2p_url = "l2-cl-{}-{}-{}-validator:{}".format(
                validator_id,
                cl_type,
                el_type,
                heimdall.HEIMDALL_NODE_LISTEN_PORT_NUMBER,
            )
            cl_validator_configs.append("{},{}".format(private_key, p2p_url))

            cl_validator_keys_store.append(
                StoreSpec(
                    src="{}/{}/config/".format(
                        constants.HEIMDALL_CONFIG_PATH, validator_id
                    ),
                    name="l2-cl-{}-{}-{}-validator-config".format(
                        validator_id, cl_type, el_type
                    ),
                )
            )
            el_validator_keys_store.append(
                StoreSpec(
                    src="{}/{}".format(constants.BOR_CONFIG_PATH, validator_id),
                    name="l2-el-{}-{}-{}-validator-config".format(
                        validator_id, el_type, cl_type
                    ),
                ),
            )
    cl_validator_configs_str = ";".join(cl_validator_configs)

    # Generate CL validators configuration such as the public/private keys and node identifiers.
    validator_config_generator_artifact = plan.upload_files(
        src=VALIDATOR_CONFIG_GENERATOR_FOLDER_PATH,
        name="l2-validator-config-generator-config",
    )

    matic_contracts_params = polygon_pos_args["matic_contracts_params"]
    validator_config_generator_image = matic_contracts_params[
        "validator_config_generator_image"
    ]

    network_params = polygon_pos_args["network_params"]
    heimdall_id = network_params["heimdall_id"]
    result = plan.run_sh(
        name="l2-validators-config-generator",
        image=validator_config_generator_image,
        env_vars={
            "HEIMDALL_ID": heimdall_id,
            "HEIMDALL_CONFIG_PATH": constants.HEIMDALL_CONFIG_PATH,
            "BOR_CONFIG_PATH": constants.BOR_CONFIG_PATH,
            "HEIMDALL_VALIDATOR_CONFIGS": cl_validator_configs_str,
        },
        files={
            "/opt/data": validator_config_generator_artifact,
        },
        store=cl_validator_keys_store
        + el_validator_keys_store
        + [
            StoreSpec(
                src="{}/persistent_peers.txt".format(constants.HEIMDALL_CONFIG_PATH),
                name="l2-cl-persistent-peers",
            )
        ],
        run="bash /opt/data/validator_setup.sh",
    )
    # Artifacts are ordered to match the `StoreSpec` definitions.
    n = len(result.files_artifacts) // 2  # Assuming equal number of cl and el configs.
    cl_validator_config_artifacts = result.files_artifacts[:n]
    el_validator_config_artifacts = result.files_artifacts[n:-1]
    cl_persistent_peers_artifact = result.files_artifacts[-1]

    return struct(
        cl_configs=cl_validator_config_artifacts,
        el_configs=el_validator_config_artifacts,
        persistent_peers=cl_persistent_peers_artifact,
    )


def _read_cl_persistent_peers(plan, cl_persistent_peers):
    result = plan.run_sh(
        description="Reading CL validator node ids",
        files={
            "/opt/data": cl_persistent_peers,
        },
        run="cat /opt/data/persistent_peers.txt | tr -d '\n'",
    )
    # Return the result as a list instead of a string.
    return result.output


def _get_cl_rpc_urls(plan, participants):
    return [
        {
            "name": "l2-cl-{}-{}-{}-validator".format(
                i + 1,
                participant["cl_type"],
                participant["el_type"],
            ),
            "rpc_url": "http://l2-cl-{}-{}-{}:{}".format(
                i + 1,
                participant["cl_type"],
                participant["el_type"],
                heimdall.HEIMDALL_RPC_PORT_NUMBER,
            ),
        }
        for i, participant in enumerate(participants)
        if participant["is_validator"]
    ]


def _aggregate_el_enodes(participants, prefunded_accounts):
    return [
        "enode://{}@l2-el-{}-{}-{}-validator:{}?discport=0".format(
            prefunded_accounts[i].eth_public_key[2:],  # Remove the 0x prefix.
            i + 1,
            participant["el_type"],
            participant["cl_type"],
            bor.BOR_DISCOVERY_PORT_NUMBER,
        )
        for i, participant in enumerate(participants)
        if participant["is_validator"]
    ]
