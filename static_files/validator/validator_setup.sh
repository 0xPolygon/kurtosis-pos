#!/usr/bin/env bash
set -euxo pipefail

# Create validator configurations (for both CL and EL).
# Unfortunately, the Heimdall node id can only be retrieved using `heimdall init`.
# Thus, we need to generate the configs of each validator and aggregate all the node identifiers
# to then be able to create the list of persistent peers.

# Checking environment variables.
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
echo "CL_CHAIN_ID: ${CL_CHAIN_ID}"
echo "CL_CLIENT_CONFIG_PATH: ${CL_CLIENT_CONFIG_PATH}"
echo "EL_CLIENT_CONFIG_PATH: ${EL_CLIENT_CONFIG_PATH}"
echo "CL_VALIDATORS_CONFIGS: ${CL_VALIDATORS_CONFIGS}"

setup_validator() {
  local validator_id="${1}"
  local validator_private_key="${2}"
  local validator_p2p_url="${3}"

  # Generate CL validator config.
  local cl_validator_config_path="${CL_CLIENT_CONFIG_PATH}/${validator_id}"
  echo "Generating CL config for validator ${validator_id}..."

  # Create an initial dummy configuration. It is needed by `heimdallcli` to run.
  heimdalld init --home "${cl_validator_config_path}" --chain-id "${CL_CHAIN_ID}" --id "${validator_id}"

  # Create the validator key.
  local tmp_dir="$(mktemp -d)"
  pushd "${tmp_dir}"
  heimdallcli generate-validatorkey --home "${cl_validator_config_path}" "${validator_private_key}"
  mv priv_validator_key.json "${cl_validator_config_path}/config/"
  popd

  # Drop the temporary genesis.
  rm "${cl_validator_config_path}/config/genesis.json"

  # Retrive and store the node identifier.
  heimdalld init --home "${cl_validator_config_path}" --chain-id "${CL_CHAIN_ID}" --id "${validator_id}" 2>"${cl_validator_config_path}/init.out"
  local node_id="$(jq --raw-output '.node_id' ${cl_validator_config_path}/init.out)"
  local node_full_address="${node_id}@${validator_p2p_url}"
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
  local el_validator_config_path="${EL_CLIENT_CONFIG_PATH}/${validator_id}"
  echo "Generating EL config for validator ${validator_id}..."

  polycli parseethwallet --hexkey "${validator_private_key}" --keystore "${el_validator_config_path}/keystore"
  echo "${validator_private_key}" >"${el_validator_config_path}/nodekey"
  touch "${el_validator_config_path}/password.txt"
}

# Loop through validators and set them up.
persistent_peers=""
id=1
IFS=';' read -ra validator_configs <<<"${CL_VALIDATORS_CONFIGS}"
for config in "${validator_configs[@]}"; do
  IFS=',' read -r private_key p2p_url <<<"${config}"
  setup_validator "${id}" "${private_key}" "${p2p_url}"
  ((id++))
done

# Store node identifiers.
echo "${persistent_peers}" >"${CL_CLIENT_CONFIG_PATH}/persistent_peers.txt"
echo "Persistent peers: ${persistent_peers}"
