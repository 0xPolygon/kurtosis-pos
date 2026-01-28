constants = import_module("../config/constants.star")


def new(plan):
    result = plan.run_sh(
        name="private-key-generator",
        description="Generating a new private key",
        image=constants.IMAGES.get("toolbox_image"),
        run="cast wallet new --json | jq --raw-output '.[0].private_key' | tr -d '\n'",
    )
    private_key = result.output
    address = derive_address_from_private_key(plan, private_key)
    return struct(
        address=address,
        private_key=private_key,
    )


def derive_address_from_private_key(plan, private_key):
    result = plan.run_sh(
        name="address-deriver",
        description="Deriving address from private key",
        image=constants.IMAGES.get("toolbox_image"),
        run="cast wallet address --private-key ${PRIVATE_KEY} | tr -d '\n'",
        env_vars={
            "PRIVATE_KEY": private_key,
        },
    )
    return result.output


def fund(
    plan,
    receiver_address,
    rpc_url,
    funder_private_key,
    value="1000000ether",
    extra_flags="",  # optional string of additional cast flags
):
    plan.run_sh(
        name="address-funder",
        description="Funding address on network {}".format(rpc_url),
        image=constants.IMAGES.get("toolbox_image"),
        run="cast send --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} --value ${VALUE} ${EXTRA_FLAGS} ${RECEIVER_ADDRESS}",
        env_vars={
            "RPC_URL": rpc_url,
            "PRIVATE_KEY": funder_private_key,
            "VALUE": value,
            "EXTRA_FLAGS": extra_flags,
            "RECEIVER_ADDRESS": receiver_address,
        },
    )


def send_erc20_tokens(
    plan,
    contract_address,
    receiver_address,
    rpc_url,
    funder_private_key,
    token_amount="1000000000000000000000000",  # cast to-unit 1000000ether wei
):
    plan.run_sh(
        name="erc20-token-sender",
        description="Sending ERC20 tokens on network {}".format(rpc_url),
        image=constants.IMAGES.get("toolbox_image"),
        run="cast send --rpc-url ${RPC_URL} --private-key ${PRIVATE_KEY} ${CONTRACT_ADDRESS} 'transfer(address,uint256)' ${RECEIVER_ADDRESS} ${TOKEN_AMOUNT}",
        env_vars={
            "RPC_URL": rpc_url,
            "PRIVATE_KEY": funder_private_key,
            "CONTRACT_ADDRESS": contract_address,
            "RECEIVER_ADDRESS": receiver_address,
            "TOKEN_AMOUNT": token_amount,
        },
    )
