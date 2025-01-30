EL_TYPE = struct(
    bor="bor",
    erigon="erigon",
)

CL_TYPE = struct(
    heimdall="heimdall",
)

LOG_LEVEL = struct(
    error="error",
    warn="warn",
    info="info",
    debug="debug",
    trace="trace",
)

ADDITIONAL_SERVICES = struct(
    tx_spammer="tx_spammer",
)

DEFAULT_L1_CHAIN_ID = "3151908"  # 0x301824
DEFAULT_EL_CHAIN_ID = "4927"
DEFAULT_CL_CHAIN_ID = "heimdall-P5rXwg"
VALIDATORS_BALANCE_ETH = 1000000000  # 10^9 ether

CL_CLIENT_CONFIG_PATH = "/etc/cl"
EL_CLIENT_CONFIG_PATH = "/etc/el"
