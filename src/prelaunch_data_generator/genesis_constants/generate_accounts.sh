#!/usr/bin/env bash
set -uxo pipefail

# Generate a number of Ethereum/Tendermint/CometBFT accounts to be prefunded.

# Checking environment variables.
if [[ -z "${ACCOUNTS_NUMBER}" ]]; then
  echo "Error: ACCOUNTS_NUMBER environment variable is not set"
  exit 1
fi
if [[ -z "${MNEMONIC}" ]]; then
  echo "Error: MNEMONIC environment variable is not set"
  exit 1
fi
echo "ACCOUNTS_NUMBER: ${ACCOUNTS_NUMBER}"
echo "MNEMONIC: ${MNEMONIC}"

# Generating Ethereum/Tendermint accounts.
echo "Generating Ethereum accounts..."
polycli wallet inspect --mnemonic "${MNEMONIC}" --addresses "${ACCOUNTS_NUMBER}" |
  jq '[.Addresses[] | {Path: .Path, ETHAddress: .ETHAddress, ETHPublicKey: ("0x" + .HexFullPublicKey), ETHPrivateKey: .HexPrivateKey}]' \
    >eth_accounts.json

# Generating CometBFT accounts (secp256k1).
jq --compact-output '.[]' eth_accounts.json | while read -r account; do
  eth_private_key=$(echo "${account}" | jq --raw-output '.ETHPrivateKey')
  secp256k1_nodekey=$(polycli nodekey --private-key "${eth_private_key}" --key-type secp256k1 | jq)
  echo "${account}" | jq --argjson nk "${secp256k1_nodekey}" '. + {CometBftAddress: ("0x" + $nk.address), CometBftPublicKey: $nk.pub_key.value, CometBftPrivateKey: $nk.priv_key.value}'
done | jq --slurp '.' >eth_cometbft_accounts.json

echo "Generating the Starlark pre_funded_accounts.star file..."
jq --raw-output '[.[] | "    # \(.Path)\n    genesis_constants.new_prefunded_account(\n        # ETH/Tendermint account - used by heimdall validators.\n        genesis_constants.new_account(\n            \"\(.ETHAddress)\",\n            \"\(.ETHPublicKey)\",\n            \"\(.ETHPrivateKey)\",\n        ),\n        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.\n        genesis_constants.new_account(\n            \"\(.CometBftAddress)\",\n            \"\(.CometBftPublicKey)\",\n            \"\(.CometBftPrivateKey)\",\n        ),\n    ),"] | "genesis_constants = import_module(\"./genesis_constants.star\")\n\nPRE_FUNDED_ACCOUNTS = [\n" + (join("\n")) + "\n]"' eth_cometbft_accounts.json >pre_funded_accounts.star

echo "Cleaning up..."
rm -rf eth_accounts.json eth_cometbft_accounts.json priv_validator_key.json logs.txt data/

echo "✅ Done!"
