math = import_module("../math/math.star")

PARTICIPANT_KIND = struct(
    validator="validator",
    rpc="rpc",
    archive="archive",
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
    stateless="stateless",
)

ADDITIONAL_SERVICES = struct(
    blockscout="blockscout",
    bridge_spammer="bridge_spammer",
    observability="observability",
    test_runner="test_runner",
    tx_spammer="tx_spammer",
    status_checker="status_checker",
    ethstats_server="ethstats_server",
)

DEFAULT_IMAGES = {
    # layer 1
    "l1_el_image": "ethereum/client-go:v1.16.7",
    "l1_cl_image": "sigp/lighthouse:v8.0.0",
    # layer 2
    "l2_cl_heimdall_v2_image": "0xpolygon/heimdall-v2:0.4.5",
    "l2_el_bor_image": "0xpolygon/bor:2.5.1",
    "l2_el_erigon_image": "0xpolygon/erigon:v3.3.0",
    "l2_cl_db_image": "rabbitmq:4.2.1",
    # utilities
    "e2e_image": "ghcr.io/agglayer/e2e:9fd2d09",
    "pos_contract_deployer_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/pos-contract-deployer:d96d592",
    "pos_el_genesis_builder_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/pos-el-genesis-builder:96a19dd",
    "pos_validator_config_generator_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/pos-validator-config-generator:0.4.5",
    "status_checker_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/status-checker:0.2.9",
    "toolbox_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/toolbox:0.0.12",
    # observability
    "prometheus_image": "prom/prometheus:v3.2.1",
    "grafana_image": "grafana/grafana:11.6.0",
    "panoptichain_image": "ghcr.io/0xpolygon/panoptichain:v4.1.1",
    "ethstats_server_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/ethstats-server:9da2124",
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

ETHSTATS_SERVER_PORT_NUMBER = 3000
ETHSTATS_SERVER_WS_SECRET = "sharedsecret"

EL_HARD_FORK_BLOCKS = {
    "jaipur": 0,
    "delhi": 0,
    "indore": 0,
    "agra": 0,
    "napoli": 0,
    "ahmedabad": 0,
    "bhilai": 0,
    "rio": 256,
    "madhugiri": 300,
    "madhugiriPro": 300,
}
