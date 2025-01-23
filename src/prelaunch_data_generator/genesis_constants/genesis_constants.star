constants = import_module("../../package_io/constants.star")


def new_account(address, public_key, private_key):
    return struct(
        address=address,
        public_key=public_key,
        private_key=private_key,
    )


def to_tendermint_public_key(account):
    # Heimdall's public keys (tendermint) must be in uncompressed format, which starts with the
    # prefix byte 0x04, followed by two 32-byte integers.
    return "0x04{}".format(account.public_key.removeprefix("0x"))


def new_prefunded_account(
    eth_tendermint_account,  # ETH/Tendermint account - used by heimdall validators
    comebft_account,  # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key
):
    return struct(
        eth_tendermint=eth_tendermint_account,
        cometbft=comebft_account,
    )


def to_ethereum_pkg_prefunded_accounts(prefunded_accounts, devnet_cl_type):
    balance = constants.VALIDATORS_BALANCE_ETH
    ethereum_prefunded_accounts = {}
    for pa in prefunded_accounts:
        account = {}
        if devnet_cl_type == constants.CL_TYPE.heimdall:
            account = pa.eth_tendermint
        elif devnet_cl_type == constants.CL_TYPE.heimdall_v2:
            account = pa.cometbft
        ethereum_prefunded_accounts[account.address] = {
            "balance": "{}ETH".format(balance)
        }
