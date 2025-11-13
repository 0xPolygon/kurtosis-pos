additional_services_launcher = import_module("./src/additional_services/launcher.star")
cl_genesis = import_module("./src/cl/genesis.star")
constants = import_module("./src/config/constants.star")
contract_deployer = import_module("./src/contracts/deployer.star")
el_cl_launcher = import_module("./src/el_cl_launcher.star")
el_genesis = import_module("./src/el/genesis.star")
hex = import_module("./src/hex/hex.star")
input_parser = import_module("./src/config/input_parser.star")
l1_launcher = import_module("./src/l1/launcher.star")
math = import_module("./src/math/math.star")
prefunded_accounts_module = import_module("./src/prefunded_accounts/accounts.star")
wallet = import_module("./src/wallet/wallet.star")


def run(plan, args):
    # Parse input arguments.
    (
        l1_args,
        polygon_pos_args,
        dev_args,
        devnet_cl_type,
    ) = input_parser.input_parser(plan, args)

    participants = polygon_pos_args.get("participants")
    validator_accounts = get_validator_accounts(participants)
    l2_network_params = polygon_pos_args.get("network_params")
    admin_private_key = hex.normalize(l2_network_params.get("admin_private_key"))
    admin_address = wallet.derive_address_from_private_key(
        plan, l2_network_params.get("admin_private_key")
    )

    # Deploy a local L1 if needed.
    # Otherwise, use the provided rpc url.
    if dev_args.get("should_deploy_l1"):
        l1_backend = dev_args.get("l1_backend")
        plan.print(
            "Deploying a local L1 with backend: {} with the following input args: {}".format(
                l1_backend, l1_args
            )
        )
        l1_context = l1_launcher.launch(
            plan,
            l1_backend,
            l1_args,
            l2_network_params.get("preregistered_validator_keys_mnemonic"),
            admin_private_key,
            admin_address,
        )

    else:
        plan.print("Using an external l1")
        l1_rpc_url = dev_args.get("l1_rpc_url")
        l1_chain_id = plan.run_sh(
            name="l1-chain-id-reader",
            description="Reading external L1 chain id from the RPC",
            image="ghcr.io/foundry-rs/foundry:stable",
            run="cast to-dec $(cast rpc eth_chainId --rpc-url ${L1_RPC_URL} | sed 's/\"//g') | tr -d '\n'",
            env_vars={
                "L1_RPC_URL": l1_rpc_url,
            },
        )
        l1_context = struct(
            chain_id=l1_chain_id,
            private_key=admin_private_key,
            rpc_url=l1_rpc_url,
            all_participants=None,
        )

    # Deploy MATIC contracts to L1 and generate the EL and CL genesis files if needed.
    # Otherwise, use the provided EL and CL genesis files.
    if dev_args.get("should_deploy_matic_contracts"):
        plan.print("Number of validators: {}".format(len(validator_accounts)))
        plan.print(validator_accounts)

        (
            l1_contract_addresses_artifact,
            validator_config_artifact,
        ) = contract_deployer.deploy_l1_contracts(
            plan,
            polygon_pos_args,
            l1_context.rpc_url,
            admin_private_key,
            validator_accounts,
        )

        l2_cl_genesis_artifact = cl_genesis.generate(
            plan,
            polygon_pos_args,
            devnet_cl_type,
            validator_accounts,
            l1_contract_addresses_artifact,
        )
        l2_el_genesis_artifact = el_genesis.generate(
            plan,
            polygon_pos_args,
            validator_config_artifact,
            admin_address,
        )
    else:
        plan.print("Using L2 EL/CL genesis provided")
        l2_el_genesis_artifact = plan.render_templates(
            name="l2-el-genesis",
            config={
                "genesis.json": struct(
                    template=read_file(src=dev_args.get("l2_el_genesis_filepath")),
                    data={},
                )
            },
        )
        l2_cl_genesis_artifact = plan.render_templates(
            name="l2-cl-genesis",
            config={
                "genesis.json": struct(
                    template=read_file(src=dev_args.get("l2_cl_genesis_filepath")),
                    data={},
                )
            },
        )

        plan.print("Using matic contract addresses provided")
        l1_contract_addresses_artifact = plan.render_templates(
            name="matic-contract-addresses",
            config={
                "contractAddresses.json": struct(
                    template=read_file(
                        src=dev_args.get("matic_contract_addresses_filepath", "")
                    ),
                    data={},
                )
            },
        )

    # Deploy network participants.
    participants_count = math.sum([p.get("count") for p in participants])
    plan.print(
        "Launching a Polygon PoS devnet with {} participants, including {} validators, and the following network params: {}".format(
            participants_count, len(validator_accounts), participants
        )
    )
    l2_context = el_cl_launcher.launch(
        plan,
        participants,
        polygon_pos_args,
        l2_el_genesis_artifact,
        l2_cl_genesis_artifact,
        l1_context.rpc_url,
        devnet_cl_type,
    )
    l2_rpc_url = l2_context.all_participants[0].el_context.rpc_http_url

    # Deploy MATIC contracts to L2.
    contract_addresses_artifact = (
        contract_deployer.deploy_l2_contracts_and_synchronise_l1_state(
            plan,
            polygon_pos_args,
            l1_context.rpc_url,
            l2_rpc_url,
            admin_private_key,
            l1_contract_addresses_artifact,
        )
    )

    # Deploy additional services.
    additional_services_launcher.launch(
        plan,
        polygon_pos_args,
        l1_context,
        l2_context,
        l2_network_params,
        l2_el_genesis_artifact,
        contract_addresses_artifact,
    )


def get_validator_accounts(participants):
    prefunded_accounts = prefunded_accounts_module.PREFUNDED_ACCOUNTS

    validator_accounts = []
    id = 0
    for p in participants:
        for _ in range(p.get("count")):
            is_validator = p.get("kind") == constants.PARTICIPANT_KIND.validator
            if is_validator:
                account = prefunded_accounts[id]
                validator_accounts.append(account)
            id += 1

    if len(validator_accounts) == 0:
        fail("There must be at least one validator among the participants!")

    return validator_accounts
