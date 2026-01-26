anvil = import_module("./anvil.star")
constants = import_module("../config/constants.star")
ethereum_package = import_module("./ethereum_package.star")


def launch(
    plan,
    l1_backend,
    l1_args,
    preregistered_validator_keys_mnemonic,
    admin_private_key,
    admin_address,
):
    if l1_backend == constants.L1_BACKEND.ethereum_package:
        l1 = ethereum_package.run(
            plan,
            l1_args,
            preregistered_validator_keys_mnemonic,
            admin_address,
        )
        prefunded_accounts_count = len(l1.pre_funded_accounts)
        if prefunded_accounts_count < 13:
            fail(
                "The L1 package did not prefund enough accounts. Expected at least 13 accounts but got {}".format(
                    prefunded_accounts_count
                )
            )
        if len(l1.all_participants) < 1:
            fail("The L1 package did not start any participants.")
        l1_context = struct(
            chain_id=l1.network_id,
            private_key=admin_private_key,
            rpc_url=l1.all_participants[0].el_context.rpc_http_url,
            all_participants=l1.all_participants,
        )
    elif l1_backend == constants.L1_BACKEND.anvil:
        rpc_url = anvil.run(
            plan,
            l1_args,
            preregistered_validator_keys_mnemonic,
            admin_address,
        )
        l1_context = struct(
            chain_id=l1_args.get("network_id"),
            private_key=admin_private_key,
            rpc_url=rpc_url,
            all_participants=None,
        )
    else:
        fail('Unsupported L1 backend: "{}".'.format(l1_backend))
    return l1_context
