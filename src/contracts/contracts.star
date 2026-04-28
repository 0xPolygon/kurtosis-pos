plasma_bridge_deployer = import_module("./plasma_bridge_deployer.star")
matic_to_pol_migrator = import_module("./matic_to_pol_migrator.star")
pos_bridge_deployer = import_module("./pos_bridge_deployer.star")
lst_deployer = import_module("./lst_deployer.star")


def deploy_l1_contracts(plan, polygon_pos_args, l1_rpc_url, private_key, validator_accounts):
    l1_addresses, validator_config = plasma_bridge_deployer.deploy_l1(
        plan, polygon_pos_args, l1_rpc_url, private_key, validator_accounts,
    )
    l1_addresses = matic_to_pol_migrator.migrate(
        plan, polygon_pos_args, l1_rpc_url, private_key, l1_addresses,
    )
    l1_addresses = pos_bridge_deployer.deploy_l1(
        plan, polygon_pos_args, l1_rpc_url, private_key, l1_addresses,
    )
    return l1_addresses, validator_config


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
    addresses = plasma_bridge_deployer.deploy_l2(
        plan, polygon_pos_args, l1_rpc_url, l2_rpc_url, private_key, l1_addresses,
    )
    addresses = pos_bridge_deployer.deploy_l2(
        plan, polygon_pos_args, l1_rpc_url, l2_rpc_url, private_key, addresses,
    )
    lst_deployer.deploy_lst_contracts(
        plan,
        polygon_pos_args,
        l1_rpc_url,
        l2_rpc_url,
        private_key,
        admin_address,
        validator_accounts,
        addresses,
    )
    return addresses
