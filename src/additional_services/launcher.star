blockscout = import_module("./blockscout.star")
bridge_spammer = import_module("./bridge_spammer.star")
constants = import_module("../config/constants.star")
ethstats_server = import_module("./ethstats_server.star")
observability = import_module("./observability.star")
status_checker = import_module("./status_checker.star")
tx_spammer = import_module("./tx_spammer.star")


def launch(
    plan,
    polygon_pos_args,
    l1_context,
    l2_context,
    l2_network_params,
    l2_el_genesis_artifact,
    contract_addresses_artifact,
):
    additional_services = polygon_pos_args.get("additional_services")
    for svc in additional_services:
        if svc == constants.ADDITIONAL_SERVICES.blockscout:
            blockscout.launch(plan)
        elif svc == constants.ADDITIONAL_SERVICES.bridge_spammer:
            bridge_spammer.launch(
                plan, l1_context, l2_network_params, contract_addresses_artifact
            )
        elif svc == constants.ADDITIONAL_SERVICES.ethstats_server:
            ethstats_server_params = polygon_pos_args.get("ethstats_server_params")
            ethstats_server.launch(plan, ethstats_server_params)
        elif svc == constants.ADDITIONAL_SERVICES.observability:
            observability.launch(
                plan,
                l1_context,
                l2_context,
                l2_el_genesis_artifact,
                contract_addresses_artifact,
            )
        elif svc == constants.ADDITIONAL_SERVICES.status_checker:
            status_checker_params = polygon_pos_args.get("status_checker_params")
            status_checker.launch(plan, status_checker_params, l1_context, l2_context)
        elif svc == constants.ADDITIONAL_SERVICES.tx_spammer:
            tx_spammer.launch(plan, l1_context, l2_context, l2_network_params)
        else:
            fail("Invalid additional service: %s" % (svc))
