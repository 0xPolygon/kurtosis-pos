#!/usr/bin/env bash
set -euxo pipefail

# Create validator configurations (for both Heimdall and Bor).
# Unfortunately, the Heimdall node id can only be retrieved using `heimdall init`.
# Thus, we need to generate the configs of each validator and aggregate all the node identifiers
# to then be able to create the list of persistent peers.

# Checking environment variables.
if [[ -z "${HEIMDALL_ID}" ]]; then
  echo "Error: HEIMDALL_ID environment variable is not set"
  exit 1
fi
if [[ -z "${HEIMDALL_CONFIG_PATH}" ]]; then
  echo "Error: HEIMDALL_CONFIG_PATH environment variable is not set"
  exit 1
fi
if [[ -z "${BOR_CONFIG_PATH}" ]]; then
  echo "Error: BOR_CONFIG_PATH environment variable is not set"
  exit 1
fi
if [[ -z "${HEIMDALL_VALIDATOR_CONFIGS}" ]]; then
  echo "Error: HEIMDALL_VALIDATOR_CONFIGS environment variable is not set"
  exit 1
fi
# Note: HEIMDALL_VALIDATOR_CONFIGS is expected to follow this exact pattern:
# "<private_key_1>,<p2p_url_1>;<private_key_2>,<p2p_url_2>;..."
echo "HEIMDALL_ID: ${HEIMDALL_ID}"
echo "HEIMDALL_CONFIG_PATH: ${HEIMDALL_CONFIG_PATH}"
echo "BOR_CONFIG_PATH: ${BOR_CONFIG_PATH}"
echo "HEIMDALL_VALIDATOR_CONFIGS: ${HEIMDALL_VALIDATOR_CONFIGS}"

setup_validator() {
  local validator_id="${1}"
  local validator_private_key="${2}"
  local validator_p2p_url="${3}"

  # Generate heimdall validator config.
  local heimdall_validator_config_path="${HEIMDALL_CONFIG_PATH}/${validator_id}"
  echo "Generating heimdall config for validator ${validator_id}..."

  # Create an initial dummy configuration. It is needed by `heimdallcli` to run.
  heimdalld init --home "${heimdall_validator_config_path}" --chain-id "${HEIMDALL_ID}" --id "${validator_id}"

  # Create the validator key.
  local tmp_dir="$(mktemp -d)"
  pushd "${tmp_dir}"
  heimdallcli generate-validatorkey --home "${heimdall_validator_config_path}" "${validator_private_key}"
  mv priv_validator_key.json "${heimdall_validator_config_path}/config/"
  popd

  # Drop the temporary genesis.
  rm "${heimdall_validator_config_path}/config/genesis.json"

  # Retrive and store the node identifier.
  heimdalld init --home "${heimdall_validator_config_path}" --chain-id "${HEIMDALL_ID}" --id "${validator_id}" 2> "${heimdall_validator_config_path}/init.out"
  local node_id="$(jq --raw-output '.node_id' ${heimdall_validator_config_path}/init.out)"
  local node_full_address="${node_id}@${validator_p2p_url}"
  if [ -z "${persistent_peers}" ]; then
    persistent_peers="${node_full_address}"
  else
    persistent_peers+=",${node_full_address}"
  fi

  # Drop the unnecessary files.
  rm -rf "${heimdall_validator_config_path}/config/app.toml"
  rm -rf "${heimdall_validator_config_path}/config/config.toml"
  rm -rf "${heimdall_validator_config_path}/config/heimdall-config.toml"
  rm -rf "${heimdall_validator_config_path}/config/genesis.json"

  # Copy the validator state.
  cp "${heimdall_validator_config_path}/data/priv_validator_state.json" "${heimdall_validator_config_path}/config"

  # Generate bor validator config.
  local bor_validator_config_path="${BOR_CONFIG_PATH}/${validator_id}"
  echo "Generating bor config for validator ${validator_id}..."

  polycli parseethwallet --hexkey "${validator_private_key}" --keystore "${bor_validator_config_path}/keystore"
  echo "${validator_private_key}" > "${bor_validator_config_path}/nodekey"
  touch "${bor_validator_config_path}/password.txt"
}

# Loop through validators and set them up.
persistent_peers=""
id=1
IFS=';' read -ra validator_configs <<< "${HEIMDALL_VALIDATOR_CONFIGS}"
for config in "${validator_configs[@]}"; do
  IFS=',' read -r private_key p2p_url <<< "${config}"
  setup_validator "${id}" "${private_key}" "${p2p_url}"
  ((id++))
done

# Store node identifiers.
echo "${persistent_peers}" > "${HEIMDALL_CONFIG_PATH}/persistent_peers.txt"
echo "Persistent peers: ${persistent_peers}"
