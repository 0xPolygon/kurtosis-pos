#!/usr/bin/env bash
set -uxo pipefail

# Generate Ethereum/Tendermint/CometBFT accounts with vanity addresses.
# Each account's address starts with a 5-char hex prefix derived from its
# 1-based index by cyclic repeat:
#   1   -> 0x11111
#   2   -> 0x22222
#   10  -> 0x10101
#   100 -> 0x10010
#   999 -> 0x99999
#
# Run on the HOST (not inside the polycli container) — this script shells out
# to `docker` for the vanity miner and uses host `cast` to derive public keys.
#
# Usage:
#   ACCOUNTS_NUMBER=20 bash generate-vanity.sh

# Checking environment variables.
if [[ -z "${ACCOUNTS_NUMBER}" ]]; then
  echo "Error: ACCOUNTS_NUMBER environment variable is not set"
  exit 1
fi
echo "ACCOUNTS_NUMBER: ${ACCOUNTS_NUMBER}"

# Dependencies.
command -v docker > /dev/null || {
  echo "Error: docker not found in PATH"
  exit 1
}
command -v cast > /dev/null || {
  echo "Error: cast (foundry) not found in PATH"
  exit 1
}
command -v jq > /dev/null || {
  echo "Error: jq not found in PATH"
  exit 1
}
command -v xxd > /dev/null || {
  echo "Error: xxd not found in PATH"
  exit 1
}
command -v base64 > /dev/null || {
  echo "Error: base64 not found in PATH"
  exit 1
}

mkdir -p db
: > eth_cometbft_accounts.json.lines

echo "Mining ${ACCOUNTS_NUMBER} vanity accounts (this will take a while)..."
for ((i = 1; i <= ACCOUNTS_NUMBER; i++)); do
  # Cyclic 5-char prefix: "$i" repeated, truncated to 5 chars.
  s="${i}${i}${i}${i}${i}"
  prefix="${s:0:5}"
  echo "[${i}/${ACCOUNTS_NUMBER}] mining 0x${prefix}..."

  line=$(docker run --rm -v "${PWD}/db:/db:rw" planxthanee/ethereum-wallet-generator:latest \
    -mode 2 -contains "0x${prefix}" -n -1 -limit 1 -c 16 |
    tail -n 8 | head -n 1)

  # Output line format: "<0xaddress> <privkey-without-0x>"
  read -r eth_address eth_private_key <<< "${line}"
  if [[ -z "${eth_address}" || -z "${eth_private_key}" ]]; then
    echo "Error: failed to parse vanity generator output for prefix 0x${prefix}: '${line}'"
    exit 1
  fi

  # Uncompressed public key (X||Y, no 04 prefix) — matches ETHPublicKey format.
  eth_public_key=$(cast wallet public-key --private-key "0x${eth_private_key}")

  # CometBFT pubkey: 04 || X || Y, base64-encoded.
  cometbft_public_key=$(printf '04%s' "${eth_public_key#0x}" | xxd -r -p | base64 | tr -d '\n')
  # CometBFT privkey: raw 32-byte privkey, base64-encoded.
  cometbft_private_key=$(printf '%s' "${eth_private_key}" | xxd -r -p | base64 | tr -d '\n')

  jq --null-input --compact-output \
    --arg path "vanity/0x${prefix}" \
    --arg eth_addr "${eth_address}" \
    --arg eth_pub "${eth_public_key}" \
    --arg eth_priv "${eth_private_key}" \
    --arg cb_pub "${cometbft_public_key}" \
    --arg cb_priv "${cometbft_private_key}" \
    '{
      Path: $path,
      ETHAddress: $eth_addr,
      ETHPublicKey: $eth_pub,
      ETHPrivateKey: $eth_priv,
      CometBftAddress: $eth_addr,
      CometBftPublicKey: $cb_pub,
      CometBftPrivateKey: $cb_priv
    }' >> eth_cometbft_accounts.json.lines
done

jq --slurp '.' eth_cometbft_accounts.json.lines > eth_cometbft_accounts.json

echo "Generating the Starlark accounts.star file..."
jq --raw-output '[.[] | "    # \(.Path)\n    account.new_validator(\n        # ETH/Tendermint account - used by heimdall validators.\n        account.new(\n            \"\(.ETHAddress)\",\n            \"\(.ETHPublicKey)\",\n            \"\(.ETHPrivateKey)\",\n        ),\n        # CometBFT account (secp256k1) - used by heimdall-v2 validators and derived from the ETH private key.\n        account.new(\n            \"\(.CometBftAddress)\",\n            \"\(.CometBftPublicKey)\",\n            \"\(.CometBftPrivateKey)\",\n        ),\n    ),"] | "account = import_module(\"../account/account.star\")\n\nPREFUNDED_ACCOUNTS = [\n" + (join("\n")) + "\n]"' eth_cometbft_accounts.json > accounts.star

echo "Cleaning up..."
rm -rf eth_cometbft_accounts.json eth_cometbft_accounts.json.lines db/

echo "✅ Done!"
