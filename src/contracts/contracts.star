plasma_bridge_deployer = import_module("./plasma_bridge_deployer.star")
matic_to_pol_migrator = import_module("./matic_to_pol_migrator.star")
pos_bridge_deployer = import_module("./pos_bridge_deployer.star")
upgrade_validator_share = import_module("./upgrade_validator_share.star")
lst_deployer = import_module("./lst_deployer.star")


def deploy_l1_contracts(
    plan, polygon_pos_args, l1_rpc_url, private_key, validator_accounts
):
    plasma_bridge_addresses, validator_config = plasma_bridge_deployer.deploy_l1(
        plan,
        polygon_pos_args,
        l1_rpc_url,
        private_key,
        validator_accounts,
    )
    pol_migration_addresses = matic_to_pol_migrator.migrate(
        plan,
        polygon_pos_args,
        l1_rpc_url,
        private_key,
        plasma_bridge_addresses,
    )
    pos_bridge_l1_addresses = pos_bridge_deployer.deploy_l1(
        plan,
        polygon_pos_args,
        l1_rpc_url,
        private_key,
        pol_migration_addresses,
    )
    # Mirror mainnet's ValidatorShare upgrade (Feb 2026) so sPOL's
    # `restakeAndStakePOL(uint256)` resolves to a real implementation. Reads
    # /opt/data/addresses, writes the new impl to .root.ValidatorShareImpl.
    upgraded_addresses = upgrade_validator_share.upgrade(
        plan,
        polygon_pos_args,
        l1_rpc_url,
        private_key,
        pos_bridge_l1_addresses,
    )
    return upgraded_addresses, validator_config


def deploy_l2_contracts(
    plan,
    polygon_pos_args,
    dev_args,
    l1_rpc_url,
    l2_rpc_url,
    private_key,
    admin_address,
    validator_accounts,
    l1_addresses,
):
    plasma_bridge_addresses = plasma_bridge_deployer.deploy_l2(
        plan,
        polygon_pos_args,
        l1_rpc_url,
        l2_rpc_url,
        private_key,
        l1_addresses,
    )
    pos_bridge_addresses = pos_bridge_deployer.deploy_l2(
        plan,
        polygon_pos_args,
        dev_args,
        l1_rpc_url,
        l2_rpc_url,
        private_key,
        plasma_bridge_addresses,
    )

    # LST is the only L2 deploy that uses CREATE2 on L1 (via vm.createSelectFork),
    # so re-running it against an L1 that already has sPOL deployed at the same
    # salt-derived addresses fails with CreateCollision. Skip it whenever we're
    # reusing pre-deployed contracts (should_deploy_matic_contracts=false), in
    # which case sPOL was deployed by the prior run that produced the supplied
    # addresses file.
    if not dev_args.get("should_deploy_matic_contracts"):
        return pos_bridge_addresses

    return lst_deployer.deploy_lst_contracts(
        plan,
        polygon_pos_args,
        l1_rpc_url,
        l2_rpc_url,
        private_key,
        admin_address,
        validator_accounts,
        pos_bridge_addresses,
    )
