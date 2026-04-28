constants = import_module("../config/constants.star")

CONTRACTS_CONFIG_FILE_PATH = "../../static_files/contracts"
SETUP_VALIDATORS_TEMPLATE_PATH = "../../static_files/contracts/l1/scripts/setupInitialValidators.s.sol"

# sPOLController parameters baked at deploy time.
REWARD_FEE = 50  # basis-points-of-ten — 100 = 10%
FEE_RECEIVER = ""  # empty string falls back to the kurtosis admin account
MAX_DIVERGENCE = 10  # basis-points — 10 = 1%


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
    """Deploy sPOL/LST contracts to L1 and L2.

    Runs inside the pos-contract-deployer image, which bundles the spol-contracts
    source, soldeer deps, and a warm forge cache under /opt/spol-contracts
    (alongside pos-contracts and pos-portal). The kurtosis-specific validator
    setup script is rendered at deploy time so VALIDATOR_COUNT matches the
    actual number of validators registered on this devnet. Reads
    PolygonMigration and RootChainManager from the accumulated PoS
    contractAddresses.json (no mocks needed — main deploys both for real).

    Downstream consumers read the resulting `lst-contract-addresses` kurtosis
    artifact by name, so this function does not return it.
    """
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

    plan.run_sh(
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
            "REWARD_FEE": str(REWARD_FEE),
            "FEE_RECEIVER": FEE_RECEIVER,
            "MAX_DIVERGENCE": str(MAX_DIVERGENCE),
        },
        files={
            "/opt/data": contract_deployer_config_artifact,
            "/opt/data/pos-addresses": pos_contract_addresses_artifact,
            "/opt/data/setup-validators": setup_validators_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/lst/lstContractAddresses.json",
                name="lst-contract-addresses",
            ),
        ],
        run="bash /opt/data/l1/deploy-lst-contracts.sh",
        wait="5m",
    )
