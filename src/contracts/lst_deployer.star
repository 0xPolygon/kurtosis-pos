constants = import_module("../config/constants.star")

CONTRACTS_CONFIG_FILE_PATH = "../../static_files/contracts"

# 100 sPOL bootstrap deposit, locked at 0xdead. Mirrors mainnet's
# spol-contracts/script/SetupInitialValidators.s.sol bootstrap.
INITIAL_DEPOSIT_WEI = "100000000000000000000"


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

    result = plan.run_sh(
        name="lst-deployer",
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
            # Validator setup (formerly in setupInitialValidators.s.sol).
            "VALIDATOR_COUNT": str(len(validator_accounts)),
            "INITIAL_DEPOSIT_WEI": INITIAL_DEPOSIT_WEI,
        },
        files={
            "/opt/data": contract_deployer_config_artifact,
            "/opt/data/pos-addresses": pos_contract_addresses_artifact,
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
