constants = import_module("../../package_io/constants.star")


def new_account(address, public_key, private_key):
    return struct(
        address=address,
        public_key=public_key,
        private_key=private_key,
    )


def new_prefunded_account(
    eth_account,
    cometbft_account,
):
    return struct(
        eth=eth_account,
        cometbft=cometbft_account,
    )


def to_ethereum_pkg_pre_funded_accounts(pre_funded_accounts):
    balance = constants.VALIDATORS_BALANCE_ETH
    return {
        account.eth.address: {"balance": "{}ETH".format(balance)}
        for account in pre_funded_accounts
    }


def to_tendermint_public_key(account):
    # Heimdall's public keys (tendermint) must be in uncompressed format, which starts with the
    # prefix byte 0x04, followed by two 32-byte integers.
    return "0x04{}".format(account.eth.public_key.removeprefix("0x"))
