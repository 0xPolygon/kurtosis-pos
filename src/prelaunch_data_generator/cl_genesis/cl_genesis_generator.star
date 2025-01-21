constants = import_module("../../package_io/constants.star")
contract_util = import_module("../../contracts/util.star")


CL_GENESIS_TEMPLATE_FOLDER_PATH = "../../../static_files/genesis/cl/"
HEIMDALL_GENESIS_TEMPLATE_FILE_NAME = {
    constants.CL_TYPE.heimdall: "heimdall-genesis.json",
    constants.CL_TYPE.heimdall_v2: "heimdall-v2-genesis.json",
}


def generate_cl_genesis_data(
    plan,
    polygon_pos_args,
    devnet_cl_type,
    validator_accounts,
    contract_addresses_artifact,
):
    network_params = polygon_pos_args.get("network_params", {})
    validators_number = len(validator_accounts)

    validator_data = _get_validator_data(validator_accounts, devnet_cl_type)
    accounts = validator_data.accounts
    dividends = validator_data.dividends
    signing_infos = validator_data.signing_infos
    validator_set = validator_data.validator_set
    proposer = []
    if validators_number > 0:
        proposer = validator_set[0]

    el_span_duration = network_params.get("el_span_duration", "")
    contract_addresses = contract_util.read_contract_addresses(
        plan, contract_addresses_artifact
    )

    cl_genesis_temporary_artifact = plan.render_templates(
        name="l2-cl-genesis-tmp",
        config={
            "genesis-tmp.json": struct(
                template=read_file(
                    "{}/{}".format(
                        CL_GENESIS_TEMPLATE_FOLDER_PATH,
                        HEIMDALL_GENESIS_TEMPLATE_FILE_NAME[devnet_cl_type],
                    )
                ),
                data={
                    # chain params
                    "cl_chain_id": network_params.get("cl_chain_id", ""),
                    "el_chain_id": network_params.get("el_chain_id", ""),
                    "el_sprint_duration": network_params.get("el_sprint_duration", ""),
                    "el_span_duration": el_span_duration,
                    "el_first_span_end_block": el_span_duration - 1,
                    # # validator set, proposer, etc.
                    "accounts": json.indent(json.encode(accounts)),
                    "dividend_accounts": json.indent(json.encode(dividends)),
                    "signing_infos": json.indent(json.encode(signing_infos)),
                    "validators": json.indent(json.encode(validator_set)),
                    "proposer": json.indent(json.encode(proposer)),
                    # contract addresses
                    "matic_token_address": contract_addresses.get("matic_token", ""),
                    "staking_manager_address": contract_addresses.get(
                        "staking_manager", ""
                    ),
                    "slash_manager_address": contract_addresses.get(
                        "slashing_manager", ""
                    ),
                    "root_chain_address": contract_addresses.get("root_chain", ""),
                    "staking_info_address": contract_addresses.get("staking_info", ""),
                    "state_sender_address": contract_addresses.get("state_sender", ""),
                },
            ),
        },
    )

    # The template that Kurtosis generates is not a valid json thus if you want to check the content
    # of the file artifact, Kurtosis will render an empty file... This is a hack to format the file
    # with jq and get a working artifact.
    return plan.run_sh(
        name="l2-cl-genesis-generator",
        description="Generating L2 CL genesis",
        files={
            "/opt/data/genesis": cl_genesis_temporary_artifact,
        },
        store=[
            StoreSpec(
                src="/opt/data/genesis/genesis.json",
                name="l2-cl-genesis",
            ),
        ],
        run="jq . /opt/data/genesis/genesis-tmp.json > /opt/data/genesis/genesis.json && cat /opt/data/genesis/genesis.json",
    )


def _get_validator_data(validator_accounts, devnet_cl_type):
    accounts = []
    dividends = []
    signing_infos = {}
    validator_set = []

    for i, account in enumerate(validator_accounts):
        validator_id = str(i + 1)

        # Determine the format of the genesis (heimdall or heimdall-v2).
        if devnet_cl_type == constants.CL_TYPE.heimdall:
            denom = "matic"
            accounts_params = {
                "sequence_number": "0",
                "account_number": "0",
                "module_name": "",
                "module_permissions": None,
            }
            validator_params = {
                "ID": validator_id,
                "power": str(constants.VALIDATORS_BALANCE_ETH),
                "accum": "0",
            }
        elif devnet_cl_type == constants.CL_TYPE.heimdall_v2:
            denom = "pol"
            accounts_params = {}
            validator_params = {
                "valId": validator_id,
                "votingPower": str(constants.VALIDATORS_BALANCE_ETH),
                "proposerPriority": "0",
            }

        # Accounts.
        accounts.append(
            {
                "address": account.eth_address,
                "coins": [
                    {
                        "denom": denom,
                        "amount": "{}000000000000000000".format(
                            constants.VALIDATORS_BALANCE_ETH
                        ),  # 18 zeros
                    }
                    | accounts_params
                ],
            }
        )

        # Dividends.
        dividends.append(
            {
                "user": account.eth_address,
                "feeAmount": "0",
            }
        )

        # Signing infos.
        signing_infos[validator_id] = {
            "valID": validator_id,
            "startHeight": "0",
            "indexOffset": "0",
        }

        # Validator set.
        validator_set.append(
            {
                "startEpoch": "0",
                "endEpoch": "0",
                "nonce": "1",
                "pubKey": account.tendermint_public_key,
                "signer": account.eth_address,
                "last_updated": "",
                "jailed": False,
            }
            | validator_params
        )

    return struct(
        accounts=accounts,
        dividends=dividends,
        signing_infos=signing_infos,
        validator_set=validator_set,
    )
