#!/usr/bin/env bash
set -uo pipefail

# This script simulates blockchain activity by performing L1 to L2 and L2 to L1 bridges.

# Helper function to log messages in JSON format.
log_error() {
  echo "{\"error\": \"$1\"}"
}

log_info() {
  echo "{\"info\": \"$1\"}"
}

# Checking environment variables.
if [[ -z "${PRIVATE_KEY}" ]]; then
  log_error "PRIVATE_KEY environment variable is not set"
  exit 1
fi
if [[ -z "${L1_RPC_URL}" ]]; then
  log_error "L1_RPC_URL environment variable is not set"
  exit 1
fi
if [[ -z "${L1_MATIC_TOKEN_ADDRESS}" ]]; then
  log_error "L1_MATIC_TOKEN_ADDRESS environment variable is not set"
  exit 1
fi
if [[ -z "${L1_ERC20_TOKEN_ADDRESS}" ]]; then
  log_error "L1_ERC20_TOKEN_ADDRESS environment variable is not set"
  exit 1
fi
if [[ -z "${L1_DEPOSIT_MANAGER_PROXY_ADDRESS}" ]]; then
  log_error "L1_DEPOSIT_MANAGER_PROXY_ADDRESS environment variable is not set"
  exit 1
fi
log_info "PRIVATE_KEY: $PRIVATE_KEY"
log_info "L1_RPC_URL: $L1_RPC_URL"
log_info "L1_MATIC_TOKEN_ADDRESS: $L1_MATIC_TOKEN_ADDRESS"
log_info "L1_ERC20_TOKEN_ADDRESS: $L1_ERC20_TOKEN_ADDRESS"
log_info "L1_DEPOSIT_MANAGER_PROXY_ADDRESS: $L1_DEPOSIT_MANAGER_PROXY_ADDRESS"

# Derive address from private key.
eth_address=$(cast wallet address --private-key "$PRIVATE_KEY")
log_info "eth_address: $eth_address"

# Function to handle errors and continue execution.
handle_error() {
  log_error "An error occurred. Continuing execution..."
}
trap handle_error ERR

# 1 MATIC/POL token = 1000000000000000000 wei.
bridge_amount=$(cast to-unit 1ether wei)
log_info "bridge_amount: $bridge_amount"

# Start depositing on L2.
while true; do
  log_info "Bridging MATIC/POL tokens from L1 to L2"
  log_info "Approving the DepositManager contract to spend MATIC/POL tokens on our behalf"
  cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" --json \
    "${L1_MATIC_TOKEN_ADDRESS}" "approve(address,uint)" "${L1_DEPOSIT_MANAGER_PROXY_ADDRESS}" "${bridge_amount}"

  log_info "Depositing MATIC/POL tokens"
  cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" --json \
    "${L1_DEPOSIT_MANAGER_PROXY_ADDRESS}" "depositERC20(address,uint)" "${L1_MATIC_TOKEN_ADDRESS}" "${bridge_amount}"

  log_info "Bridging ERC20 tokens from L1 to L2"
  log_info "Approving the DepositManager contract to spend ERC20 tokens on our behalf"
  cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" --json \
    "${L1_ERC20_TOKEN_ADDRESS}" "approve(address,uint)" "${L1_DEPOSIT_MANAGER_PROXY_ADDRESS}" "${bridge_amount}"

  log_info "Depositing ERC20 tokens"
  cast send --rpc-url "${L1_RPC_URL}" --private-key "${PRIVATE_KEY}" --json \
    "${L1_DEPOSIT_MANAGER_PROXY_ADDRESS}" "depositERC20(address,uint)" "${L1_ERC20_TOKEN_ADDRESS}" "${bridge_amount}"

  sleep 5
done
