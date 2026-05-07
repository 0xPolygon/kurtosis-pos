account_util = import_module("../account/account.star")
constants = import_module("../config/constants.star")
input_parser = import_module("../config/input_parser.star")
prefunded_accounts_module = import_module("../prefunded_accounts/accounts.star")
wait = import_module("../wait/wait.star")


ETHEREUM_PACKAGE = (
    "github.com/ethpandaops/ethereum-package/main.star@6.1.0"  # 2026-04-02
)

# Canonical EIP-2470 / arachnid CREATE2 deployer. Pre-allocated on L1 for the
# same reason it's pre-allocated on L2 Bor (see static_files/el/genesis/builder.sh):
# Solidity's `new X{salt: y}` compiles to a CALL into this address, and forge
# scripts that use CREATE2 — sPOL's Deploy.s.sol does — fail with "missing
# CREATE2 deployer" if it's not present at this exact address. The standard
# EIP-2470 runtime bootstrap (legacy pre-signed tx) is rejected here too because
# ethereum-package geth sets eip155Block: 0.
CREATE2_DEPLOYER_ADDRESS = "0x4e59b44847b379578588920cA78FbF26c0B4956C"
CREATE2_DEPLOYER_CODE = "0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe03601600081602082378035828234f58015156039578182fd5b8082525050506014600cf3"


def run(plan, ethereum_args, preregistered_validator_keys_mnemonic, admin_address):
    # Sanity check the mnemonic used.
    # TODO: Remove this limitation.
    l2_network_params = input_parser.POLYGON_POS_PACKAGE_ARGS.get("network_params")
    default_l2_mnemonic = l2_network_params.get("preregistered_validator_keys_mnemonic")
    if preregistered_validator_keys_mnemonic != default_l2_mnemonic:
        fail("Using a different mnemonic is not supported for now.")

    # Apply log format and client-specific extra params to each participant.
    log_format = ethereum_args.get("global_log_format")
    participants = [
        _apply_participant_params(p, log_format)
        for p in ethereum_args.get("participants")
    ]

    # Build clean args without custom properties before passing to the ethereum-package.
    clean_ethereum_args = {}
    for k, v in ethereum_args.items():
        if k != "global_log_format":
            clean_ethereum_args[k] = v
    clean_ethereum_args["participants"] = participants

    # Define prefunded accounts on L1.
    l1_network_params = clean_ethereum_args.get("network_params")
    prefunded_accounts = _merge_l1_prefunded_accounts(admin_address, l1_network_params)
    clean_ethereum_args["network_params"] = l1_network_params | {
        "prefunded_accounts": json.encode(prefunded_accounts)
    }

    # Deploy the ethereum package.
    l1 = import_module(ETHEREUM_PACKAGE).run(plan, clean_ethereum_args)
    plan.print(l1)
    if len(l1.all_participants) < 1:
        fail("The L1 package did not start any participants.")

    wait.wait_for_l1_startup(
        plan, str(l1.all_participants[0].cl_context.beacon_http_url)
    )
    return l1


def _apply_participant_params(participant, log_format):
    participant = dict(participant)
    el_type = participant.get("el_type")
    cl_type = participant.get("cl_type")
    vc_type = participant.get("vc_type")

    # Client-specific EL extra params.
    el_extra_params = {
        "geth": [
            "--log.format={}".format(
                "json" if log_format == constants.LOG_FORMAT.json else "terminal"
            ),
        ],
    }
    participant["el_extra_params"] = participant.get(
        "el_extra_params", []
    ) + el_extra_params.get(el_type)

    # Client-specific CL extra params.
    cl_extra_params = {
        "lighthouse": (
            ["--log-format=JSON"] if log_format == constants.LOG_FORMAT.json else []
        )
    }
    participant["cl_extra_params"] = participant.get(
        "cl_extra_params", []
    ) + cl_extra_params.get(cl_type)

    # Client-specific VC extra params.
    vc_extra_params = {
        "lighthouse": (
            ["--log-format=JSON"] if log_format == constants.LOG_FORMAT.json else []
        )
    }
    participant["vc_extra_params"] = participant.get(
        "vc_extra_params", []
    ) + vc_extra_params.get(vc_type)

    return participant


def _merge_l1_prefunded_accounts(admin_address, l1_network_params):
    # Merge the prefunded accounts (admin and validators) with the user-specified prefuned accounts.
    admin_prefunded_account = account_util.to_ethereum_pkg_prefunded_account(
        admin_address, constants.ADMIN_BALANCE_ETH
    )

    validators_prefunded_accounts = {}
    for a in prefunded_accounts_module.PREFUNDED_ACCOUNTS:
        validators_prefunded_accounts |= account_util.to_ethereum_pkg_prefunded_account(
            a.eth_tendermint.address, constants.VALIDATORS_BALANCE_ETH
        )

    create2_deployer = account_util.to_ethereum_pkg_preallocated_contract(
        CREATE2_DEPLOYER_ADDRESS, CREATE2_DEPLOYER_CODE
    )

    user_prefunded_accounts = {}
    user_prefunded_accounts_str = l1_network_params.get("prefunded_accounts")
    if user_prefunded_accounts_str != "":
        user_prefunded_accounts = json.decode(user_prefunded_accounts_str)

    return (
        admin_prefunded_account
        | validators_prefunded_accounts
        | create2_deployer
        | user_prefunded_accounts
    )
