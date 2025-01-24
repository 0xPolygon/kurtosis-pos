#!/usr/bin/env bash
set -euxo pipefail

# Create validator configurations (for both CL and EL).
# Unfortunately, the Heimdall node id can only be retrieved using `heimdall init`.
# Thus, we need to generate the configs of each validator and aggregate all the node identifiers
# to then be able to create the list of persistent peers.

# Checking environment variables.
if [[ -z "${DEVNET_CL_TYPE}" ]]; then
  echo "Error: DEVNET_CL_TYPE environment variable is not set"
  exit 1
fi
if [[ -z "${CL_CHAIN_ID}" ]]; then
  echo "Error: CL_CHAIN_ID environment variable is not set"
  exit 1
fi
if [[ -z "${CL_CLIENT_CONFIG_PATH}" ]]; then
  echo "Error: CL_CLIENT_CONFIG_PATH environment variable is not set"
  exit 1
fi
if [[ -z "${EL_CLIENT_CONFIG_PATH}" ]]; then
  echo "Error: EL_CLIENT_CONFIG_PATH environment variable is not set"
  exit 1
fi
if [[ -z "${CL_VALIDATORS_CONFIGS}" ]]; then
  echo "Error: CL_VALIDATORS_CONFIGS environment variable is not set"
  exit 1
fi
# Note: CL_VALIDATORS_CONFIGS is expected to follow this exact pattern:
# "<private_key_1>,<p2p_url_1>;<private_key_2>,<p2p_url_2>;..."
echo "DEVNET_CL_TYPE: ${DEVNET_CL_TYPE}"
echo "CL_CHAIN_ID: ${CL_CHAIN_ID}"
echo "CL_CLIENT_CONFIG_PATH: ${CL_CLIENT_CONFIG_PATH}"
echo "EL_CLIENT_CONFIG_PATH: ${EL_CLIENT_CONFIG_PATH}"
echo "CL_VALIDATORS_CONFIGS: ${CL_VALIDATORS_CONFIGS}"

setup_validator() {
  local id="${1}"
  local execution_key="${2}"
  local p2p_url="${3}"

  # Generate the validator key (or consensus key) using the execution key.
  local cl_validator_config_path="${CL_CLIENT_CONFIG_PATH}/${id}"
  echo "Generating CL config for validator ${id}..."
  if [[ "${DEVNET_CL_TYPE}" == "heimdall" ]]; then
    # Create an initial dummy configuration. It is needed by `heimdallcli` to run.
    heimdalld init --home "${cl_validator_config_path}" --chain-id "${CL_CHAIN_ID}" --id "${id}"

    # Generate the validator key from the execution key.
    local tmp_dir="$(mktemp -d)"
    pushd "${tmp_dir}"
    heimdallcli generate-validatorkey --home "${cl_validator_config_path}" "${execution_key}"
    mv priv_validator_key.json "${cl_validator_config_path}/config/"
    popd
    # Drop the temporary genesis.
    rm "${cl_validator_config_path}/config/genesis.json"
  elif [[ "${DEVNET_CL_TYPE}" == "heimdall-v2" ]]; then
    mkdir -p "${cl_validator_config_path}/config"
    polycli nodekey --private-key "${execution_key}" --key-type secp256k1 | jq >"${cl_validator_config_path}/config/priv_validator_key.json"
    mkdir -p "${cl_validator_config_path}/data"
    echo '{"height":"0","round":0,"step":0}' | jq >"${cl_validator_config_path}/data/priv_validator_state.json"
  else
    echo "Wrong devnet CL type: ${DEVNET_CL_TYPE}"
    exit 1
  fi

  # Retrieve and store the node identifier.
  if [[ "${DEVNET_CL_TYPE}" == "heimdall" ]]; then
    heimdalld init --home "${cl_validator_config_path}" --chain-id "${CL_CHAIN_ID}" --id "${id}" 2>"${cl_validator_config_path}/init.out"
  elif [[ "${DEVNET_CL_TYPE}" == "heimdall-v2" ]]; then
    heimdalld-v2 init --home "${cl_validator_config_path}" --chain-id "${CL_CHAIN_ID}" "${id}" 2>"${cl_validator_config_path}/init.out"
  else
    echo "Wrong devnet CL type: ${DEVNET_CL_TYPE}"
    exit 1
  fi
  local node_id="$(jq --raw-output '.node_id' ${cl_validator_config_path}/init.out)"
  local node_full_address="${node_id}@${p2p_url}"
  if [ -z "${persistent_peers}" ]; then
    persistent_peers="${node_full_address}"
  else
    persistent_peers+=",${node_full_address}"
  fi

  # Drop the unnecessary files.
  rm -rf "${cl_validator_config_path}/config/app.toml"
  rm -rf "${cl_validator_config_path}/config/config.toml"
  rm -rf "${cl_validator_config_path}/config/heimdall-config.toml"
  rm -rf "${cl_validator_config_path}/config/genesis.json"

  # Copy the validator state.
  cp "${cl_validator_config_path}/data/priv_validator_state.json" "${cl_validator_config_path}/config"

  # Generate EL validator config.
  local el_validator_config_path="${EL_CLIENT_CONFIG_PATH}/${id}"
  echo "Generating EL config for validator ${id}..."
  polycli parseethwallet --hexkey "${execution_key}" --keystore "${el_validator_config_path}/keystore"
  echo "${execution_key}" >"${el_validator_config_path}/nodekey"
  touch "${el_validator_config_path}/password.txt"
}

# Loop through validators and set them up.
persistent_peers=""
id=1
IFS=';' read -ra validator_configs <<<"${CL_VALIDATORS_CONFIGS}"
for config in "${validator_configs[@]}"; do
  IFS=',' read -r execution_key p2p_url <<<"${config}"
  setup_validator "${id}" "${execution_key}" "${p2p_url}"
  ((id++))
done

# Store node identifiers.
echo "${persistent_peers}" >"${CL_CLIENT_CONFIG_PATH}/persistent_peers.txt"
echo "Persistent peers: ${persistent_peers}"
