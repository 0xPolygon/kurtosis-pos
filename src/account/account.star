constants = import_module("../config/constants.star")


def new(address, public_key, private_key):
    return struct(
        address=address,
        public_key=public_key,
        private_key=private_key,
    )


def new_validator(
    eth_tendermint_account,  # ETH/Tendermint account.
    comebft_account,  # CometBFT account (secp256k1), derived from the ETH private key.
):
    return struct(
        eth_tendermint=eth_tendermint_account,
        cometbft=comebft_account,
    )


def to_ethereum_pkg_prefunded_account(address, balance):
    return {address: {"balance": "{}ETH".format(balance)}}
