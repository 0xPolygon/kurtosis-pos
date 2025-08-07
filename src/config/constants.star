math = import_module("../math/math.star")

PARTICIPANT_KIND = struct(
    validator="validator",
    rpc="rpc",
)

EL_TYPE = struct(
    bor="bor",
    erigon="erigon",
)

CL_TYPE = struct(
    heimdall_v2="heimdall-v2",
)

CL_ENVIRONMENT = struct(
    mainnet="mainnet",
    mumbai="mumbai",
    local="local",
)

LOG_LEVEL = struct(
    error="error",
    warn="warn",
    info="info",
    debug="debug",
    trace="trace",
)

BOR_SYNC_MODES = struct(
    full="full",
    snap="snap",
    archive="archive",
)

ADDITIONAL_SERVICES = struct(
    blockscout="blockscout",
    prometheus_grafana="prometheus_grafana",
    test_runner="test_runner",
    tx_spammer="tx_spammer",
)

DEFAULT_IMAGES = {
    # layer 1
    "l1_el_image": "ethereum/client-go:v1.15.11",
    "l1_cl_image": "ethpandaops/lighthouse:unstable-6135f41",
    # layer 2
    "l2_cl_heimdall_v2_image": "0xpolygon/heimdall-v2:0.2.15",
    "l2_el_bor_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/bor:v2.2.9-fix",  # Based on 0xpolygon/bor:2.2.9 with heimdall migration monitor fix (https://github.com/0xPolygon/bor/compare/master...leovct:bor:2.2.9-fix).
    "l2_el_erigon_image": "erigontech/erigon:v3.0.15",
    "l2_cl_db_image": "rabbitmq:4.1.2",
    # utilities
    "e2e_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/e2e:50ebf3e",
    "pos_contract_deployer_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/pos-contract-deployer:d96d592",
    "pos_el_genesis_builder_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/pos-el-genesis-builder:96a19dd",
    "pos_validator_config_generator_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/pos-validator-config-generator:0.2.15",
    "toolbox_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/toolbox:0.0.8",
}

DEFAULT_L1_CHAIN_ID = "3151908"  # 0x301824
DEFAULT_EL_CHAIN_ID = "4927"
DEFAULT_CL_CHAIN_ID = "heimdall-4927"  # Follows the standard "heimdall-<el_chain_id>".

ADMIN_BALANCE_ETH = math.pow(10, 9)
VALIDATORS_BALANCE_ETH = math.pow(10, 4)

CL_CLIENT_CONFIG_PATH = "/etc/cl"
EL_CLIENT_CONFIG_PATH = "/etc/el"

RABBITMQ_USERNAME = "guest"
RABBITMQ_PASSWORD = "guest"
