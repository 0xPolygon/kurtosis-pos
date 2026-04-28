plasma_bridge_deployer = import_module("./plasma_bridge_deployer.star")
matic_to_pol_migrator = import_module("./matic_to_pol_migrator.star")
pos_bridge_deployer = import_module("./pos_bridge_deployer.star")
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
    return pos_bridge_l1_addresses, validator_config


def deploy_l2_contracts(
    plan,
    polygon_pos_args,
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
        l1_rpc_url,
        l2_rpc_url,
        private_key,
        plasma_bridge_addresses,
    )
    pos_contract_addresses = lst_deployer.deploy_lst_contracts(
        plan,
        polygon_pos_args,
        l1_rpc_url,
        l2_rpc_url,
        private_key,
        admin_address,
        validator_accounts,
        pos_bridge_addresses,
    )
    return pos_contract_addresses
