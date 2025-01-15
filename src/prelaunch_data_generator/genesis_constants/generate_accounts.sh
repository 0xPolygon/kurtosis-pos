#!/usr/bin/env bash
set -euxo pipefail

# Generate a number of Ethereum/Tendermint accounts to be prefunded.

# Checking environment variables.
if [[ -z "${ACCOUNTS_NUMBER}" ]]; then
  echo "Error: ACCOUNTS_NUMBER environment variable is not set"
  exit 1
fi
if [[ -z "${MNEMONIC}" ]]; then
  echo "Error: MNEMONIC environment variable is not set"
  exit 1
fi

# Generating accounts.
cl_client_config_path="/etc/cl"
echo "Generating Ethereum accounts..."
polycli wallet inspect --mnemonic "${MNEMONIC}" --addresses "${ACCOUNTS_NUMBER}" |
  jq '[.Addresses[] | {Path: .Path, ETHAddress: .ETHAddress, ETHPublicKey: ("0x" + .HexFullPublicKey), PrivateKey: .HexPrivateKey}]' \
    >eth_accounts.json

echo "Generating Tendermint public keys... It might take a while..."
jq --compact-output '.[]' eth_accounts.json | while read -r account; do
  # Generate validator key.
  private_key=$(echo "${account}" | jq --raw-output '.PrivateKey')
  heimdallcli generate-validatorkey --home "${cl_client_config_path}" --logs_writer_file logs.txt "${private_key}"
  cp ./priv_validator_key.json "${cl_client_config_path}"/config
  tendermint_public_key=$(heimdalld show-account --home "${cl_client_config_path}" --logs_writer_file logs.txt | jq --raw-output '.pub_key')
  echo "${account}" | jq --arg v "${tendermint_public_key}" '. + {TendermintPublicKey: $v}'
done | jq --slurp '.' >eth_tendermint_accounts.json

echo "Generating the Starlark pre_funded_accounts.star file..."
jq --raw-output '[.[] | "    # \(.Path)\n    genesis_constants.new_prefunded_account(\n        \"\(.ETHAddress)\",\n        \"\(.ETHPublicKey)\",\n        \"\(.TendermintPublicKey)\",\n        \"\(.PrivateKey)\",\n    ),"] | "genesis_constants = import_module(\"./genesis_constants.star\")\n\nPRE_FUNDED_ACCOUNTS = [\n" + (join("\n")) + "\n]"' eth_tendermint_accounts.json >pre_funded_accounts.star

echo "Cleaning up..."
rm -rf eth_accounts.json eth_tendermint_accounts.json priv_validator_key.json logs.txt

echo "✅ Done!"
