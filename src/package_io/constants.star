EL_TYPE = struct(
    bor="bor",
    bor_modified_for_heimdall_v2="bor-modified-for-heimdall-v2",
    erigon="erigon",
)

CL_TYPE = struct(
    heimdall="heimdall",
    heimdall_v2="heimdall-v2",
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

DEFAULT_EL_CHAIN_ID = "4927"
DEFAULT_CL_CHAIN_ID = "heimdall-4927"  # Follows the standard "heimdall-<el_chain_id>".

VALIDATORS_BALANCE_ETH = 1000000000  # 10^9 ether

CL_CLIENT_CONFIG_PATH = "/etc/cl"
EL_CLIENT_CONFIG_PATH = "/etc/el"

RABBITMQ_USERNAME = "guest"
RABBITMQ_PASSWORD = "guest"
