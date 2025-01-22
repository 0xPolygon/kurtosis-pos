genesis_constants = import_module("./genesis_constants.star")

PRE_FUNDED_ACCOUNTS = [
    # m/44'/60'/0'/0/0
    genesis_constants.new_prefunded_account(
        # ETH account (address, public key, private key).
        "0x97538585a02A3f1B1297EB9979cE1b34ff953f1E",
        "0x93e8717f46b146ebfb99159eb13a5d044c191998656c8b79007b16051bb1ff762d09884e43783d898dd47f6220af040206cabbd45c9a26bb278a522c3d538a1f",
        "2a4ae8c4c250917781d38d95dafbb0abe87ae2c9aea02ed7c7524685358e49c2",
        # CometBft account (address, public key, private key).
        "99AA9FC116C1E5E741E9EC18BD1FD232130A5C44",
        "BBNYN0nMJsgo0Fp3kVW85PRGBNe7Gdz1XBFuTWQ7D8FnKRb2JYO3i3FK2UiA5+gTSxYu1K66KdYjQYP1mOkH09g=",
        "OP72E0D7GEi/4VySpolVudLW7uPJm+6PWEtFKJmvp1M=",
    ),
    # m/44'/60'/0'/0/1
    genesis_constants.new_prefunded_account(
        # ETH account (address, public key, private key).
        "0xeeE6f79486542f85290920073947bc9672C6ACE5",
        "0x0f554daf002c359281a9c5c3cb6639cab12259f570d6d10cb15e3f82a79e75aa4924f01f530068b4a0113f77e69ba5434ca01100a182fbca2609e29c4a9de91f",
        "f92738db8be69a9694b08acfc8e8fa843578da5adfcf4de77482c5a2b15681ad",
        # CometBft account (address, public key, private key).
        "4A1944A4B8A4BE56220D132D971A8DE74543AAD3",
        "BNPWXoLfaCc3x/ln5gA525biIjkDoz9njB9AGyluokwqJRgdw/R0DzI4AtmweRyBc52j2ctLLF6mZPkJLkhbDmI=",
        "4dgx+SPKWmTjMxXgfc2+MfNwrf+7UavfCuL3Zb3YVLY=",
    ),
]
