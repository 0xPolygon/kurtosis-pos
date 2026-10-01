constants = import_module("./constants.star")

# Production order the pos-e2e cl-forks patch activates on the local chain.
# A drift here fails pos-e2e patch-constants-star.sh before a devnet boots.
_CL_ORDER = [
    "phuket",
    "feeWithdrawValidatorGate",
    "zurich",
    "ithaca",
    "kyoto",
    "lugano",
]
_CL_HEIGHTS = {
    "phuket": 640,
    "feeWithdrawValidatorGate": 768,
    "zurich": 832,
    "ithaca": 960,
    "kyoto": 1024,
    "lugano": 1088,
}


def test_cl_hard_fork_blocks_match_the_devnet_ladder(plan):
    forks = constants.CL_HARD_FORK_BLOCKS
    expect.eq(len(forks), len(_CL_ORDER))
    previous = 0
    for name in _CL_ORDER:
        height = forks[name]
        expect.eq(height, _CL_HEIGHTS[name])
        expect.eq(height > previous, True)
        previous = height
    # One 64-block step past kyoto, after valencia (896) and before the
    # austin "never" sentinel. Collapsing this to 1 would erase the
    # Kyoto-to-Lugano window the nesting-guard switch needs.
    expect.eq(forks["lugano"] - forks["kyoto"], 64)
    expect.eq(forks["lugano"] > constants.EL_HARD_FORK_BLOCKS["valencia"], True)
    expect.eq(forks["lugano"] < constants.EL_HARD_FORK_BLOCKS["austin"], True)
