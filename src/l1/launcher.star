anvil = import_module("./anvil.star")
constants = import_module("../config/constants.star")
ethereum_package = import_module("./ethereum_package.star")


def launch(
    plan,
    l1_backend,
    l1_args,
    preregistered_validator_keys_mnemonic,
    admin_private_key,
    admin_address,
):
    if l1_backend == constants.L1_BACKEND.ethereum_package:
        l1 = ethereum_package.run(
            plan,
            l1_args,
            preregistered_validator_keys_mnemonic,
            admin_address,
        )
        prefunded_accounts_count = len(l1.pre_funded_accounts)
        if prefunded_accounts_count < 13:
            fail(
                "The L1 package did not prefund enough accounts. Expected at least 13 accounts but got {}".format(
                    prefunded_accounts_count
                )
            )
        if len(l1.all_participants) < 1:
            fail("The L1 package did not start any participants.")
        l1_context = struct(
            chain_id=l1.network_id,
            private_key=admin_private_key,
            rpc_url=l1.all_participants[0].el_context.rpc_http_url,
            all_participants=l1.all_participants,
        )
        check_l1_hardfork_from_beacon(
            plan, str(l1.all_participants[0].cl_context.beacon_http_url)
        )
    elif l1_backend == constants.L1_BACKEND.anvil:
        rpc_url = anvil.run(
            plan,
            l1_args,
            preregistered_validator_keys_mnemonic,
            admin_address,
        )
        l1_context = struct(
            chain_id=l1_args.get("network_id"),
            private_key=admin_private_key,
            rpc_url=rpc_url,
            all_participants=None,
        )
        check_l1_hardfork_from_anvil(plan, rpc_url)
    else:
        fail('Unsupported L1 backend: "{}".'.format(l1_backend))
    return l1_context


# Warn (never fail) when the L1 does not run constants.L1_HARDFORK: forge would then
# simulate L1 scripts with the wrong gas schedule.
def check_l1_hardfork_from_beacon(plan, cl_rpc_url):
    _check_l1_hardfork(
        plan,
        cl_rpc_url,
        [
            "version=$(curl -s $URL/eth/v1/beacon/states/head/fork | jq -r .data.current_version)",
            'cl_fork=$(curl -s $URL/eth/v1/config/spec | jq -r --arg v "$version" \'.data | to_entries[] | select((.key | endswith("_FORK_VERSION")) and .value == $v) | .key | sub("_FORK_VERSION$"; "") | ascii_downcase\')',
            # Consensus fork -> execution fork, the name forge and anvil take.
            'case "$cl_fork" in gloas) actual=amsterdam;; fulu) actual=osaka;; electra) actual=prague;; deneb) actual=cancun;; capella) actual=shanghai;; *) actual="$cl_fork";; esac',
        ],
    )


def check_l1_hardfork_from_anvil(plan, rpc_url):
    _check_l1_hardfork(
        plan,
        rpc_url,
        [
            'actual=$(curl -s -X POST -H \'Content-Type: application/json\' --data \'{"jsonrpc":"2.0","id":1,"method":"anvil_nodeInfo","params":[]}\' $URL | jq -r .result.hardFork | tr \'[:upper:]\' \'[:lower:]\')',
        ],
    )


def warn_external_l1_hardfork(plan):
    plan.print(
        "WARNING: external L1 in use, its hard fork cannot be checked. Make sure it runs {}, the fork forge simulates L1 scripts with (L1_HARDFORK in src/config/constants.star).".format(
            constants.L1_HARDFORK
        )
    )


def _check_l1_hardfork(plan, url, read_actual):
    plan.run_sh(
        name="l1-hardfork-check",
        description="Check that the L1 runs the expected hard fork ({})".format(
            constants.L1_HARDFORK
        ),
        env_vars={
            "URL": url,
            "EXPECTED": constants.L1_HARDFORK,
        },
        run="\n".join(
            read_actual
            + [
                'if [ "$actual" = "$EXPECTED" ]; then',
                '  echo "L1 runs the expected hard fork: $actual"',
                "else",
                '  echo "WARNING: L1 runs hard fork \\"$actual\\" but L1_HARDFORK is \\"$EXPECTED\\": forge simulates L1 scripts with the wrong gas schedule. Update L1_HARDFORK in src/config/constants.star."',
                "fi",
            ]
        ),
    )
