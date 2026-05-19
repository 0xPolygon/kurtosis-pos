constants = import_module("../../config/constants.star")


def get_producer_vote_val_ids(participants):
    # Walks `participants` in declared order, assigns val ID `i+1` to each
    # validator slot (respecting `count`), and returns the comma-separated list
    # of val IDs for validators *without* `el_bor_sync_with_witness: true`.
    # Mirrors the val ID assignment in `main.star`'s `get_validator_accounts`
    # and `get_validator_data` below so IDs stay consistent.
    val_id = 0
    producer_ids = []
    for p in participants:
        is_validator = p.get("kind") == constants.PARTICIPANT_KIND.validator
        for _ in range(p.get("count")):
            if is_validator:
                val_id += 1
                if not p.get("el_bor_sync_with_witness"):
                    producer_ids.append(str(val_id))
    return ",".join(producer_ids)


def get_validator_data(validator_accounts):
    accounts = []
    balances = []
    dividends = []
    validator_set = []

    for i, validator_account in enumerate(validator_accounts):
        validator_id = str(i + 1)

        # Accounts.
        accounts.append(
            {
                "@type": "/cosmos.auth.v1beta1.BaseAccount",
                "address": validator_account.cometbft.address,
                "pub_key": {
                    "@type": "/cosmos.crypto.secp256k1.PubKey",
                    "key": validator_account.cometbft.public_key,
                },
                "account_number": validator_id,
                "sequence": "0",
            }
        )

        # Token balances.
        balances.append(
            {
                "address": validator_account.cometbft.address,
                "coins": [
                    {
                        "denom": "pol",
                        "amount": "{}000000000000000000".format(
                            constants.VALIDATORS_BALANCE_ETH
                        ),  # 18 zeros
                    },
                ],
            }
        )

        # Dividends.
        dividends.append(
            {
                "user": validator_account.cometbft.address,
                "fee_amount": "0",
            }
        )

        # Validator set.
        validator_set.append(
            {
                "start_epoch": "0",
                "end_epoch": "0",
                "nonce": "1",
                "pub_key": validator_account.cometbft.public_key,
                "signer": validator_account.cometbft.address,
                "last_updated": "",
                "jailed": False,
                "val_id": validator_id,
                "voting_power": str(constants.VALIDATORS_BALANCE_ETH),
                "proposer_priority": "0",
            }
        )

    # Token supply.
    supply = [
        {
            "denom": "pol",
            "amount": "{}000000000000000000".format(
                constants.VALIDATORS_BALANCE_ETH * len(validator_accounts)
            ),  # 18 zeros
        }
    ]

    return struct(
        accounts=accounts,
        balances=balances,
        supply=supply,
        dividends=dividends,
        validator_set=validator_set,
        total_voting_power=constants.VALIDATORS_BALANCE_ETH * len(validator_accounts),
    )
