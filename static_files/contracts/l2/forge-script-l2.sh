#!/usr/bin/env bash

# A bor node fed by a sequence store answers eth_getTransactionReceipt with a
# preconfirmation receipt (null blockHash) until the block is imported. Forge
# reads that as pending and gives up after three quick retries, with the
# transactions already sent, so resume until the receipts are canonical.
forge_script_l2() {
  forge script "$@" && return 0
  local attempt
  for attempt in 1 2 3 4 5; do
    echo "forge script did not confirm on L2, resuming (attempt ${attempt}/5)..."
    sleep 3
    forge script "$@" --resume && return 0
  done
  return 1
}
