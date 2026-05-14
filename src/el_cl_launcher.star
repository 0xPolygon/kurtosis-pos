cl_launcher = import_module("./cl/launcher.star")
cl_shared = import_module("./cl/shared.star")
heimdall_v2_genesis = import_module("./cl/heimdall_v2/genesis.star")
constants = import_module("./config/constants.star")
el_launcher = import_module("./el/launcher.star")
el_shared = import_module("./el/shared.star")
participant_module = import_module("./participant.star")
prefunded_accounts = import_module("./prefunded_accounts/accounts.star")
wait = import_module("./wait/wait.star")


CL_KEYS_GENERATOR_FOLDER_PATH = "../static_files/cl/keys"

CONTAINER_PROC_MANAGER_FILE_PATH = "../static_files/scripts/container-proc-manager.sh"


def launch(
    plan,
    participants,
    polygon_pos_args,
    el_genesis_artifact,
    cl_genesis_artifact,
    l1_rpc_url,
    participant_start_index=0,
):
    network_params = polygon_pos_args.get("network_params")

    # Comma-separated val IDs of validators eligible to produce blocks (i.e.,
    # validators not running in stateless sync mode). All validator bridges
    # vote for this same list via heimdall's `producer_votes` config so that
    # VeBlop's stake-weighted election converges on the producing subset.
    producer_votes_str = heimdall_v2_genesis.get_producer_vote_val_ids(participants)

    # Prepare network data for ALL participants (existing + new) so that
    # static nodes, persistent peers, and the relayer's bp-rpc-endpoints
    # default include the full network topology.
    network_data = _prepare_network_data(participants, participant_start_index)

    # For existing EL nodes, replace the generated enode URLs with the actual
    # ones from the running services. The generated enode URLs use prefunded
    # account public keys which should match, but querying the actual enodes
    # ensures correctness (similar to _read_existing_cl_peer_ids for Heimdall).
    existing_el_enodes = _read_existing_el_enodes(
        plan, participants, participant_start_index
    )
    for i, enode in enumerate(existing_el_enodes):
        network_data.el_static_nodes[i] = enode

    # Generate validator keys and peer IDs.
    # For new deployments, run the config generator to create keys.
    # For existing validators (before participant_start_index), query their
    # actual node IDs from the running services since the config generator
    # is not deterministic for node keys.
    cl_validator_config_artifacts = None
    cl_node_ids = ""

    # Collect peer IDs from existing (already running) validators.
    existing_peer_ids = _read_existing_cl_peer_ids(
        plan, participants, participant_start_index
    )

    # Generate keys for new validators (if any).
    new_validator_configs_str = network_data.new_cl_validator_configs_str
    if new_validator_configs_str:
        cl_validator_config_artifacts = _generate_cl_validator_config(
            plan,
            new_validator_configs_str,
            network_data.new_cl_validator_keystores,
            polygon_pos_args,
        )
        new_peer_ids = _read_cl_persistent_peers(
            plan, cl_validator_config_artifacts.persistent_peers
        )
        cl_node_ids = ",".join([p for p in [existing_peer_ids, new_peer_ids] if p])
    else:
        cl_node_ids = existing_peer_ids

    # Generate file artifact for the container process manager.
    # This script is used to stop heimdall client processes running inside the container without
    # stopping the container itself.
    # Note: It doesn't work well with EL clients such as bor and erigon unfortunately.
    container_proc_manager_artifact = plan.upload_files(
        name="container-proc-manager-script",
        src=CONTAINER_PROC_MANAGER_FILE_PATH,
    )

    # Two-pass launch sequence (refactored for multi-Heimdall coverage):
    #
    #   Pass 1 — launch every CL container, capturing its context in slot
    #            order so a later EL can see the full set of CL endpoints
    #            and build a comma-separated `--bor.heimdall.urls` list.
    #   Pass 2 — launch every EL container, passing it the list of CL
    #            api_urls / ws_rpc_urls (single-element by default; the
    #            full list when `cl_failover: true` is set on the
    #            participant).
    #
    # The two-pass split is structural — bor's MultiHeimdallClient
    # failover (eth/ethconfig/config.go::parseURLs) accepts a comma-
    # separated `[heimdall].url` and a comma-separated WS address, so
    # any non-empty failover list must be available *before* the EL
    # service is created.
    ethstats_server_params = polygon_pos_args.get("ethstats_server_params")

    # Pass 1: launch all CLs and remember the slot ↔ participant mapping.
    # Participants with index < participant_start_index are already running
    # from a prior `kurtosis run` (enclave extension) and are skipped here.
    # Each slot is {participant, participant_index, is_validator, is_private_relay, cl_context}.
    slots = []
    participant_index = 0
    # validator_index indexes into cl_validator_config_artifacts.keys, which
    # only contains keys for NEW validators (skipping those already deployed).
    validator_index = 0
    for _, participant in enumerate(participants):
        is_validator = participant.get("kind") == constants.PARTICIPANT_KIND.validator
        is_private_relay = participant.get("el_bor_enable_private_tx_relay")
        for _ in range(participant.get("count")):
            if participant_index >= participant_start_index:
                plan.print(
                    "Launching CL for participant {} with config: {}".format(
                        participant_index + 1, str(participant)
                    )
                )

                # Validators use pre-generated keys and run the bridge; rpc/archive nodes use
                # auto-generated keys and run as full nodes without the bridge.
                cl_keys_artifact = None
                if is_validator and cl_validator_config_artifacts:
                    cl_keys_artifact = cl_validator_config_artifacts.keys[
                        validator_index
                    ]
                cl_context = cl_launcher.launch(
                    plan,
                    participant,
                    participant_index + 1,
                    network_params,
                    cl_genesis_artifact,
                    cl_keys_artifact,
                    cl_node_ids,
                    l1_rpc_url,
                    container_proc_manager_artifact,
                    producer_votes_str,
                )

                slots.append(
                    struct(
                        participant=participant,
                        participant_index=participant_index,
                        is_validator=is_validator,
                        is_private_relay=is_private_relay,
                        cl_context=cl_context,
                    )
                )

                if is_validator:
                    validator_index += 1
            participant_index += 1

    # Pass 2: launch all ELs, each with the full set of CL endpoints
    # available for failover plumbing.
    all_cl_api_urls = [s.cl_context.api_url for s in slots]
    all_cl_ws_rpc_urls = [s.cl_context.ws_rpc_url for s in slots]

    # Names of validator EL services launched so far. Used to gate relayer
    # startup on validator RPC readiness — bor's relay multiClient dials each
    # bp-rpc-endpoint at boot via eth_blockNumber and silently disables the
    # ones that don't respond (eth/relay/multiclient.go:60). If a relayer
    # boots before its BPs are ready, the relay service ends up with zero
    # working endpoints. See "[tx-relay] Failed to dial all rpc endpoints" in
    # bor logs for the symptom.
    launched_validator_el_names = []

    all_participants = []
    for slot_index, slot in enumerate(slots):
        participant = slot.participant
        plan.print(
            "Launching EL for participant {} with config: {}".format(
                slot.participant_index + 1, str(participant)
            )
        )

        if participant.get("cl_failover"):
            # Own endpoint first, then every other CL as fallback. Order
            # matters: bor probes the primary, then fails over to the
            # next entry on error. See bor's eth/ethconfig/config.go.
            cl_api_urls = [slot.cl_context.api_url] + [
                u for i, u in enumerate(all_cl_api_urls) if i != slot_index
            ]
            cl_ws_rpc_urls = [slot.cl_context.ws_rpc_url] + [
                u for i, u in enumerate(all_cl_ws_rpc_urls) if i != slot_index
            ]
        else:
            cl_api_urls = [slot.cl_context.api_url]
            cl_ws_rpc_urls = [slot.cl_context.ws_rpc_url]

        # Block on validator EL readiness before bringing up a relayer EL.
        if slot.is_private_relay and len(launched_validator_el_names) > 0:
            for v_name in launched_validator_el_names:
                el_launcher.wait_for_node_startup(plan, v_name)

        el_account = prefunded_accounts.PREFUNDED_ACCOUNTS[slot.participant_index]
        el_context = el_launcher.launch(
            plan,
            participant,
            slot.participant_index + 1,
            network_params,
            el_genesis_artifact,
            cl_api_urls,
            cl_ws_rpc_urls,
            el_account,
            network_data.el_static_nodes,
            network_data.el_validator_rpc_urls,
            container_proc_manager_artifact,
            ethstats_server_params,
        )

        if slot.is_validator:
            launched_validator_el_names.append(el_context.service_name)

        all_participants.append(
            participant_module.new_participant(
                kind=participant.get("kind"),
                cl_type=participant.get("cl_type"),
                el_type=participant.get("el_type"),
                cl_context=slot.cl_context,
                el_context=el_context,
            )
        )

    # Make sure that the RPC of all the participants can be reached.
    for participant in all_participants:
        cl_launcher.wait_for_node_startup(
            plan,
            participant.cl_context.service_name,
        )
        el_launcher.wait_for_node_startup(
            plan,
            participant.el_context.service_name,
        )

    # Wait for the devnet to reach a certain state.
    # The first producer should have committed a span.
    # Skip this step when no validators are deployed (e.g. adding nodes to a running network).
    validators = [
        p for p in all_participants if p.kind == constants.PARTICIPANT_KIND.validator
    ]
    if len(validators) > 0:
        first_validator = validators[0]
        wait.wait_for_l2_startup(plan, first_validator.cl_context.api_url)

    # Return the L2 context.
    return struct(
        all_participants=all_participants,
    )


def _prepare_network_data(participants, participant_start_index=0):
    # An array of EL enode URLs for the full network.
    el_static_nodes = []
    # In-cluster JSON-RPC URLs of every validator EL node. Used as the default
    # value for the relayer's [relay] bp-rpc-endpoints when the participant
    # config does not provide an explicit override. Service DNS in kurtosis is
    # the el_node_name; rpc port is el_shared.RPC_PORT_NUMBER (8545).
    el_validator_rpc_urls = []
    # Validator configs and keystores for NEW validators only (to be generated).
    new_cl_validator_configs = []
    new_cl_validator_keystores = []

    # Iterate through all participants in the network and generate necessary configurations.
    participant_index = 0
    new_validator_index = 0
    for _, p in enumerate(participants):
        for _ in range(p.get("count")):
            el_node_name = _generate_el_node_name(p, participant_index + 1)
            account = prefunded_accounts.PREFUNDED_ACCOUNTS[participant_index]

            # Generate the EL enode url for ALL participants.
            enode_url = _generate_enode_url(
                p,
                account.eth_tendermint.public_key.removeprefix("0x"),
                el_node_name,
            )
            el_static_nodes.append(enode_url)

            # Track validator EL RPC URLs for bp-rpc-endpoints default.
            if p.get("kind") == constants.PARTICIPANT_KIND.validator:
                el_validator_rpc_urls.append(
                    "http://{}:{}".format(el_node_name, el_shared.RPC_PORT_NUMBER)
                )

            # Generate validator configurations only for NEW validators.
            is_validator = p.get("kind") == constants.PARTICIPANT_KIND.validator
            is_new = participant_index >= participant_start_index
            if is_validator and is_new:
                cl_node_name = _generate_cl_node_name(p, participant_index + 1)

                # Generate the CL validator config.
                cl_validator_config = "{},{},{},{},{}:{}".format(
                    account.eth_tendermint.private_key,
                    account.cometbft.address,
                    account.cometbft.public_key,
                    account.cometbft.private_key,
                    cl_node_name,
                    cl_shared.NODE_LISTEN_PORT_NUMBER,
                )
                new_cl_validator_configs.append(cl_validator_config)

                # Generate the validator CL keystores.
                new_cl_validator_keystores.append(
                    StoreSpec(
                        src="{}/{}/config/".format(
                            constants.CL_CLIENT_CONFIG_PATH, new_validator_index + 1
                        ),
                        name="{}-keys".format(cl_node_name),
                    )
                )

                # Increment the new validator index.
                new_validator_index += 1

            # Increment the participant index.
            participant_index += 1

    return struct(
        new_cl_validator_configs_str=";".join(new_cl_validator_configs),
        new_cl_validator_keystores=new_cl_validator_keystores,
        el_static_nodes=el_static_nodes,
        el_validator_rpc_urls=el_validator_rpc_urls,
    )


def _read_existing_cl_peer_ids(plan, participants, participant_start_index):
    """Query running validators for their actual CometBFT node IDs."""
    if participant_start_index == 0:
        return ""

    peer_entries = []
    participant_index = 0
    for _, p in enumerate(participants):
        is_validator = p.get("kind") == constants.PARTICIPANT_KIND.validator
        for _ in range(p.get("count")):
            if participant_index >= participant_start_index:
                break
            if is_validator:
                cl_node_name = _generate_cl_node_name(p, participant_index + 1)
                result = plan.run_sh(
                    name="read-peer-id-{}".format(cl_node_name),
                    description="Reading node ID from running service '{}'".format(
                        cl_node_name
                    ),
                    image=constants.IMAGES.get("toolbox_image"),
                    run='curl -sf http://{}:{} -d \'{{"method":"status","params":[],"id":1,"jsonrpc":"2.0"}}\' | jq -r \'.result.node_info.id\' | tr -d \'\\n\''.format(
                        cl_node_name,
                        cl_shared.RPC_PORT_NUMBER,
                    ),
                )
                node_id = result.output
                peer_entry = "{}@{}:{}".format(
                    node_id,
                    cl_node_name,
                    cl_shared.NODE_LISTEN_PORT_NUMBER,
                )
                peer_entries.append(peer_entry)
            participant_index += 1
        if participant_index >= participant_start_index:
            break

    return ",".join(peer_entries)


def _read_existing_el_enodes(plan, participants, participant_start_index):
    """Query running EL nodes for their actual enode URLs."""
    if participant_start_index == 0:
        return []

    enodes = []
    participant_index = 0
    for _, p in enumerate(participants):
        for _ in range(p.get("count")):
            if participant_index >= participant_start_index:
                break
            el_node_name = _generate_el_node_name(p, participant_index + 1)
            # Query admin_nodeInfo and extract just the hex public key from the
            # enode URL using sed (avoids Starlark string parsing issues on
            # result.output).
            result = plan.run_sh(
                name="read-enode-{}".format(el_node_name),
                description="Reading enode public key from running service '{}'".format(
                    el_node_name
                ),
                image=constants.IMAGES.get("toolbox_image"),
                run='curl -sf http://{}:{} -X POST -H \'Content-Type: application/json\' -d \'{{"method":"admin_nodeInfo","params":[],"id":1,"jsonrpc":"2.0"}}\' | jq -r \'.result.enode\' | sed \'s|enode://||;s|@.*||\' | tr -d \'\\n\''.format(
                    el_node_name,
                    el_shared.RPC_PORT_NUMBER,
                ),
            )
            pubkey = result.output
            enode = _generate_enode_url(p, pubkey, el_node_name)
            enodes.append(enode)
            participant_index += 1
        if participant_index >= participant_start_index:
            break

    return enodes


def _generate_enode_url(participant, eth_public_key, el_node_name):
    return "enode://{}@{}:{}?discport=0".format(
        eth_public_key,
        el_node_name,
        el_shared.DISCOVERY_PORT_NUMBER,
    )


def _generate_cl_validator_config(
    plan,
    cl_validator_configs_str,
    cl_validator_keystores,
    polygon_pos_args,
):
    # Generate CL validators configuration such as the public/private keys and node identifiers.
    setup_images = polygon_pos_args.get("setup_images")
    network_params = polygon_pos_args.get("network_params")
    cl_keys_generator_artifact = plan.upload_files(
        name="l2-cl-validator-keys-generator-config",
        src=CL_KEYS_GENERATOR_FOLDER_PATH,
    )
    result = plan.run_sh(
        name="l2-cl-validator-keys-generator",
        description="Generating L2 CL validator keys and node configuration",
        image=setup_images.get("validator_config_generator"),
        env_vars={
            "CL_CHAIN_ID": constants.CL_CHAIN_ID,
            "CL_CLIENT_CONFIG_PATH": constants.CL_CLIENT_CONFIG_PATH,
            "CL_VALIDATORS_CONFIGS": cl_validator_configs_str,
        },
        files={
            "/opt/data": cl_keys_generator_artifact,
        },
        store=cl_validator_keystores
        + [
            StoreSpec(
                src="{}/persistent_peers.txt".format(constants.CL_CLIENT_CONFIG_PATH),
                name="l2-cl-persistent-peers",
            )
        ],
        run="bash /opt/data/setup.sh",
    )

    # Artifacts are ordered to match the `StoreSpec` definitions.
    cl_keys_artifacts = result.files_artifacts[:-1]
    cl_persistent_peers_artifact = result.files_artifacts[-1]

    return struct(
        keys=cl_keys_artifacts,
        persistent_peers=cl_persistent_peers_artifact,
    )


def _read_cl_persistent_peers(plan, cl_persistent_peers_artifact):
    result = plan.run_sh(
        name="l2-cl-validator-node-ids-reader",
        description="Reading CL validator node ids",
        files={
            "/opt/data": cl_persistent_peers_artifact,
        },
        # Return the result as a list instead of a string.
        run="cat /opt/data/persistent_peers.txt | tr -d '\n'",
    )
    return result.output


def _generate_cl_node_name(participant, id):
    return cl_launcher.generate_name(participant, id)


def _generate_el_node_name(participant, id):
    return el_launcher.generate_name(participant, id)
