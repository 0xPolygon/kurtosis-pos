# shellcheck shell=bash
# Sourced by the contract deployment scripts.

# Run forge against the L1. Once the L1 is on Amsterdam, forge must simulate with
# Amsterdam gas pricing (EIP-8037) or it under-estimates contract creations and
# the broadcast transactions run out of gas. FOUNDRY_HARDFORK only changes the
# runtime spec, not the compiled bytecode. Bor is not on Amsterdam, so L2-only
# invocations keep calling forge directly.
forge_l1() {
  local block
  block=$(cast block --rpc-url "${L1_RPC_URL}" latest --json)
  if [[ "${block}" == *'"blockAccessListHash"'* ]]; then
    FOUNDRY_HARDFORK=amsterdam forge "$@"
  else
    forge "$@"
  fi
}
