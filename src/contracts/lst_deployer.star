constants = import_module("../config/constants.star")

CONTRACTS_CONFIG_FILE_PATH = "../../static_files/contracts"
SETUP_VALIDATORS_TEMPLATE_PATH = "../../static_files/contracts/l1/scripts/setupInitialValidators.s.sol"


def deploy_lst_contracts(
    plan,
    polygon_pos_args,
    l1_rpc_url,
    l2_rpc_url,
    private_key,
    admin_address,
    validator_accounts,
    pos_contract_addresses_artifact,
):
    setup_images = polygon_pos_args.get("setup_images")

    contract_deployer_config_artifact = plan.upload_files(
        src=CONTRACTS_CONFIG_FILE_PATH,
        name="lst-deployer-config",
    )

    setup_validators_artifact = plan.render_templates(
        name="lst-setup-validators-script",
        config={
            "setupInitialValidators.s.sol": struct(
                template=read_file(SETUP_VALIDATORS_TEMPLATE_PATH),
                data={
                    "validator_count": len(validator_accounts),
                },
            ),
        },
    )

    result = plan.run_sh(
        name="lst-contracts-deployer",
        description="Deploying sPOL/LST contracts to L1 and L2",
        image=setup_images.get("contract_deployer"),
        env_vars={
            "PRIVATE_KEY": private_key,
            "L1_RPC_URL": l1_rpc_url,
            "L2_RPC_URL": l2_rpc_url,
            "L1_CHAIN_ID": str(constants.L1_CHAIN_ID),
            "L2_CHAIN_ID": str(constants.EL_CHAIN_ID),
            "ADMIN_ADDRESS": admin_address,
            "REWARD_FEE": "50",  # basis-points-of-ten — 100 = 10%
            "FEE_RECEIVER": "",  # empty string falls back to ADMIN_ADDRESS
            "MAX_DIVERGENCE": "10",  # basis-points — 10 = 1%
        },
        files={
            "/opt/data": contract_deployer_config_artifact,
            "/opt/data/pos-addresses": pos_contract_addresses_artifact,
            "/opt/data/setup-validators": setup_validators_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/contracts/contractAddresses.json",
                name="pos-contract-addresses",
            ),
        ],
        run="bash /opt/data/l1/deploy-lst-contracts.sh",
        wait="5m",
    )
    return result.files_artifacts[0]
