math = import_module("../math/math.star")

L1_BACKEND = struct(
    anvil="anvil",  # lightweight devnet
    ethereum_package="ethereum-package",  # complete devnet with multi-client support
)

PARTICIPANT_KIND = struct(
    validator="validator",
    rpc="rpc",
)

EL_TYPE = struct(
    bor="bor",
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

ADDITIONAL_SERVICES = struct(
    blockscout="blockscout",
    bridge_spammer="bridge_spammer",
    observability="observability",
    tx_spammer="tx_spammer",
    status_checker="status_checker",
    ethstats_server="ethstats_server",
)

IMAGES = {
    # layer 1
    "l1_el_image": "ethereum/client-go:v1.17.5",
    "l1_cl_image": "sigp/lighthouse:v8.2.2",
    "l1_anvil_image": "ghcr.io/foundry-rs/foundry:v1.7.1",
    # layer 2
    "l2_cl_heimdall_v2_image": "0xpolygon/heimdall-v2:0.11.0",
    "l2_el_bor_image": "0xpolygon/bor:2.10.1",
    "l2_cl_queue_image": "rabbitmq:4.3.5",
    # utilities
    "pos_contract_deployer_image": "ghcr.io/0xpolygon/pos-contract-deployer:0.0.4",
    "pos_el_genesis_builder_image": "ghcr.io/0xpolygon/pos-el-genesis-builder:96a19dd",
    "pos_validator_config_generator_image": "ghcr.io/0xpolygon/pos-validator-config-generator:0.10.0",
    "toolbox_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/toolbox:0.0.12",
    # additional services
    "status_checker_image": "ghcr.io/0xpolygon/status-checker:v0.2.9",
    # observability
    "prometheus_image": "prom/prometheus:v3.14.0",
    "grafana_image": "grafana/grafana:13.2.0",
    "panoptichain_image": "ghcr.io/0xpolygon/panoptichain:v6.3.2",
    "ethstats_server_image": "europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public/ethstats-server:9da2124",
    # sequence store (preconfirmation experiment)
    "seqstore_redpanda_image": "redpandadata/redpanda:v26.2.2",
    "seqstore_envoy_image": "envoyproxy/envoy:v1.39.0",
}

# The sequence-store image is built locally from the sequence-store repo.
# Deliberately not in IMAGES: CI mirrors that dict through the GAR remote
# registry, and a local-only tag is not pullable from anywhere.
SEQSTORE_DEFAULT_IMAGE = "seqstore:local"

# Sequence-store service names and gRPC port, shared between the store
# launcher and the bor config template (the [sequencer] endpoints).
SEQSTORE_INGRESS_SERVICE_NAME = "seqstore-ingress"
SEQSTORE_GATEWAY_SERVICE_NAME = "seqstore-gateway"
SEQSTORE_GRPC_PORT_NUMBER = 9550

L1_CHAIN_ID = "3151908"  # 0x301824

# Do NOT change EL_CHAIN_ID / CL_CHAIN_ID — both are baked into pre-built
# artifacts at image-build time:
#   - `pos-el-genesis-builder`: ChainIdMixin.sol (borChainId) + BorValidatorSet.sol
#     (borChainId + heimdallChainId) are rendered from templates and compiled;
#     the resulting bytecode is embedded into the L2 genesis alloc.
#   - `pos-contract-deployer`: ChainIdMixin.sol + TransferWithSigUtils.sol
#     (borChainId) are rendered and compiled into the L1 pos-contracts bytecode.
# Changing these values here would leave the package pointing at contracts
# compiled for a different chain and break every deposit/withdraw. To use
# different chain ids, rebuild both images with matching build args and bump
# the values below.
EL_CHAIN_ID = "4927"
CL_CHAIN_ID = "heimdall-" + EL_CHAIN_ID  # follows "heimdall-<el_chain_id>"
EL_SPRINT_DURATION = 16
EL_SPAN_DURATION = EL_SPRINT_DURATION * 8

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
    # rio must be enabled at block 128 because it's hardcoded in heimdall-v2 codebase
    # https://github.com/0xPolygon/heimdall-v2/blob/4ff4059d7d83bcadc81e88d513f178ca3ba15fd8/helper/config.go#L488
    "rio": 128,
    # hardforks happening after rio should also be enabled at block 128 or later
    "madhugiri": 128,
    "madhugiriPro": 128,
    "dandeli": 128,
    "lisovo": 128,
    "lisovoPro": 128,
    "giugliano": 128,
    "chicago": 128,
    "valencia": 128,
    # Newest bor EL fork; after valencia. Enabled at 128 like the other
    # post-rio forks. Requires bor >= 2.10.0 (older public bor images ignore
    # the unknown austinBlock genesis field).
    "austin": 128,
}
