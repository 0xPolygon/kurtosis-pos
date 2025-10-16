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

LOG_FORMAT = struct(
    text="text",
    json="json",
)

BOR_SYNC_MODES = struct(
    full="full",
    snap="snap",
    archive="archive",
    stateless="stateless",
)

ADDITIONAL_SERVICES = struct(
    blockscout="blockscout",
    bridge_spammer="bridge_spammer",
    observability="observability",
    test_runner="test_runner",
    tx_spammer="tx_spammer",
    status_checker="status_checker",
)

DEFAULT_IMAGES = {
    # layer 1
    "l1_el_image": "ethereum/client-go:v1.16.5",
    "l1_cl_image": "sigp/lighthouse:v8.0.0-rc.1",
    # layer 2
    "l2_cl_heimdall_v2_image": "0xpolygon/heimdall-v2:0.3.1",
    "l2_el_bor_image": "0xpolygon/bor:2.2.11",
    "l2_el_erigon_image": "0xpolygon/erigon:v3.0.18",
    "l2_cl_db_image": "rabbitmq:4.1.4",
    # utilities
    "e2e_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/e2e:9cf122d",
    "pos_contract_deployer_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/pos-contract-deployer:d96d592",
    "pos_el_genesis_builder_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/pos-el-genesis-builder:96a19dd",
    "pos_validator_config_generator_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/pos-validator-config-generator:0.3.1",
    "status_checker_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/status-checker:0.2.9",
    "toolbox_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/toolbox:0.0.12",
    # observability
    "prometheus_image": "prom/prometheus:v3.2.1",
    "grafana_image": "grafana/grafana:11.6.0",
    "panoptichain_image": "ghcr.io/0xpolygon/panoptichain:v4.1.1",
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

CL_MIN_RETAIN_BLOCKS = 0
CL_COMPACT_ENABLED = False
CL_COMPACTION_INTERVAL = 1000
CL_STORAGE_PRUNING_INTERVAL = "10m0s"
CL_INDEXER_PRUNING_ENABLED = False
