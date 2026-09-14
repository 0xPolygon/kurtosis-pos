#!/usr/bin/env bash
#
# bootstrap.sh -- prepare a kurtosis-pos devnet for sequence-store testing.
#
# Replaces the step-by-step init.sh flow with one idempotent run:
#
#   1. wait until the L2 RPC answers and blocks are advancing
#   2. Multicall3 at 0xcA11...CA11           (presigned tx, keyless deploy)
#   3. Arachnid CREATE2 deployer at 0x4e59...956c (presigned tx, usually genesis)
#   4. compile evm-stress / address-tester / counter (yul) and CREATE2-deploy
#      them, asserting they land on the well-known hard-coded addresses
#   5. derive NUM_ACCOUNTS test accounts from MNEMONIC, batch-check every
#      balance, and top up only the ones below MIN_BALANCE
#   6. verify everything and write bootstrap.env for other scripts to source
#
# Every step checks chain state first and skips work that is already done,
# so re-running after a partial failure only does what is still missing.
# Exit status is 0 only when all contracts have code at the expected
# addresses and every test account holds at least MIN_BALANCE.
#
# Usage:
#   ./bootstrap.sh            # do the setup, then verify
#   ./bootstrap.sh --check    # verify only, send no transactions
#
# Environment overrides (defaults in parentheses):
#   ENCLAVE       kurtosis enclave name                    (pos)
#   RPC_SERVICE   enclave service whose "rpc" port to use  (first l2-el-*-rpc node)
#                 Do not point this at the nginx / erpc load balancer: a
#                 receipt seen on one bor node does not mean the next request
#                 (routed to another node) sees that state yet, so nonces
#                 and balances race. Load tests can use the balancer; setup
#                 should talk to one node.
#   RPC_URL       skip kurtosis lookup, use this URL       (derived)
#   PRIVATE_KEY   funder / admin key                       (devnet admin)
#   GAS_PRICE     gas price and priority fee for all txs   (30gwei)
#   NUM_ACCOUNTS  number of test accounts                  (10000)
#   FUND_AMOUNT   ether sent to each underfunded account   (100)
#   MIN_BALANCE   ether below which an account is refunded (10)
#   MNEMONIC      test account mnemonic                    (fixed devnet phrase)
#   SOLC_IMAGE    docker image used to compile the yul     (ethereum/solc:0.8.30-alpine)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# ---------------------------------------------------------------- config ----

ENCLAVE="${ENCLAVE:-pos}"
RPC_SERVICE="${RPC_SERVICE:-}"
PRIVATE_KEY="${PRIVATE_KEY:-0xd40311b5a5ca5eaeb48dfba5403bde4993ece8eccf4190e98e19fcd4754260ea}"
GAS_PRICE="${GAS_PRICE:-30gwei}"
NUM_ACCOUNTS="${NUM_ACCOUNTS:-10000}"
FUND_AMOUNT="${FUND_AMOUNT:-100}"
MIN_BALANCE="${MIN_BALANCE:-10}"
MNEMONIC="${MNEMONIC:-depend check hole birth pet basket brain stove switch october disagree whale}"
SOLC_IMAGE="${SOLC_IMAGE:-ethereum/solc:0.8.30-alpine}"

CHECK_ONLY=false
for arg in "$@"; do
  case "$arg" in
    --check) CHECK_ONLY=true ;;
    -h|--help) sed -n '2,40p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown argument: $arg" >&2; exit 2 ;;
  esac
done

ACCOUNTS_JSON="accounts.json"
KEYS_FILE="private-keys.txt"
ENV_FILE="bootstrap.env"
BALANCE_BATCH=500     # eth_getBalance calls per JSON-RPC batch request
TX_TIMEOUT=120        # seconds to wait for a receipt
CODE_TIMEOUT=60       # seconds to wait for code to appear after a deploy

# Keyless deploys: presigned legacy txs from throwaway EOAs (Nick's method).
MULTICALL3_ADDR=0xcA11bde05977b3631167028862bE2a173976CA11
MULTICALL3_SENDER=0x05f32b3cc3888453ff71b01135b34ff8e41263f2
MULTICALL3_TX=0xf90f538085174876e800830f42408080b90f00608060405234801561001057600080fd5b50610ee0806100206000396000f3fe6080604052600436106100f35760003560e01c80634d2301cc1161008a578063a8b0574e11610059578063a8b0574e1461025a578063bce38bd714610275578063c3077fa914610288578063ee82ac5e1461029b57600080fd5b80634d2301cc146101ec57806372425d9d1461022157806382ad56cb1461023457806386d516e81461024757600080fd5b80633408e470116100c65780633408e47014610191578063399542e9146101a45780633e64a696146101c657806342cbb15c146101d957600080fd5b80630f28c97d146100f8578063174dea711461011a578063252dba421461013a57806327e86d6e1461015b575b600080fd5b34801561010457600080fd5b50425b6040519081526020015b60405180910390f35b61012d610128366004610a85565b6102ba565b6040516101119190610bbe565b61014d610148366004610a85565b6104ef565b604051610111929190610bd8565b34801561016757600080fd5b50437fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0140610107565b34801561019d57600080fd5b5046610107565b6101b76101b2366004610c60565b610690565b60405161011193929190610cba565b3480156101d257600080fd5b5048610107565b3480156101e557600080fd5b5043610107565b3480156101f857600080fd5b50610107610207366004610ce2565b73ffffffffffffffffffffffffffffffffffffffff163190565b34801561022d57600080fd5b5044610107565b61012d610242366004610a85565b6106ab565b34801561025357600080fd5b5045610107565b34801561026657600080fd5b50604051418152602001610111565b61012d610283366004610c60565b61085a565b6101b7610296366004610a85565b610a1a565b3480156102a757600080fd5b506101076102b6366004610d18565b4090565b60606000828067ffffffffffffffff8111156102d8576102d8610d31565b60405190808252806020026020018201604052801561031e57816020015b6040805180820190915260008152606060208201528152602001906001900390816102f65790505b5092503660005b8281101561047757600085828151811061034157610341610d60565b6020026020010151905087878381811061035d5761035d610d60565b905060200281019061036f9190610d8f565b6040810135958601959093506103886020850185610ce2565b73ffffffffffffffffffffffffffffffffffffffff16816103ac6060870187610dcd565b6040516103ba929190610e32565b60006040518083038185875af1925050503d80600081146103f7576040519150601f19603f3d011682016040523d82523d6000602084013e6103fc565b606091505b50602080850191909152901515808452908501351761046d577f08c379a000000000000000000000000000000000000000000000000000000000600052602060045260176024527f4d756c746963616c6c333a2063616c6c206661696c656400000000000000000060445260846000fd5b5050600101610325565b508234146104e6576040517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152601a60248201527f4d756c746963616c6c333a2076616c7565206d69736d6174636800000000000060448201526064015b60405180910390fd5b50505092915050565b436060828067ffffffffffffffff81111561050c5761050c610d31565b60405190808252806020026020018201604052801561053f57816020015b606081526020019060019003908161052a5790505b5091503660005b8281101561068657600087878381811061056257610562610d60565b90506020028101906105749190610e42565b92506105836020840184610ce2565b73ffffffffffffffffffffffffffffffffffffffff166105a66020850185610dcd565b6040516105b4929190610e32565b6000604051808303816000865af19150503d80600081146105f1576040519150601f19603f3d011682016040523d82523d6000602084013e6105f6565b606091505b5086848151811061060957610609610d60565b602090810291909101015290508061067d576040517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152601760248201527f4d756c746963616c6c333a2063616c6c206661696c656400000000000000000060448201526064016104dd565b50600101610546565b5050509250929050565b43804060606106a086868661085a565b905093509350939050565b6060818067ffffffffffffffff8111156106c7576106c7610d31565b60405190808252806020026020018201604052801561070d57816020015b6040805180820190915260008152606060208201528152602001906001900390816106e55790505b5091503660005b828110156104e657600084828151811061073057610730610d60565b6020026020010151905086868381811061074c5761074c610d60565b905060200281019061075e9190610e76565b925061076d6020840184610ce2565b73ffffffffffffffffffffffffffffffffffffffff166107906040850185610dcd565b60405161079e929190610e32565b6000604051808303816000865af19150503d80600081146107db576040519150601f19603f3d011682016040523d82523d6000602084013e6107e0565b606091505b506020808401919091529015158083529084013517610851577f08c379a000000000000000000000000000000000000000000000000000000000600052602060045260176024527f4d756c746963616c6c333a2063616c6c206661696c656400000000000000000060445260646000fd5b50600101610714565b6060818067ffffffffffffffff81111561087657610876610d31565b6040519080825280602002602001820160405280156108bc57816020015b6040805180820190915260008152606060208201528152602001906001900390816108945790505b5091503660005b82811015610a105760008482815181106108df576108df610d60565b602002602001015190508686838181106108fb576108fb610d60565b905060200281019061090d9190610e42565b925061091c6020840184610ce2565b73ffffffffffffffffffffffffffffffffffffffff1661093f6020850185610dcd565b60405161094d929190610e32565b6000604051808303816000865af19150503d806000811461098a576040519150601f19603f3d011682016040523d82523d6000602084013e61098f565b606091505b506020830152151581528715610a07578051610a07576040517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152601760248201527f4d756c746963616c6c333a2063616c6c206661696c656400000000000000000060448201526064016104dd565b506001016108c3565b5050509392505050565b6000806060610a2b60018686610690565b919790965090945092505050565b60008083601f840112610a4b57600080fd5b50813567ffffffffffffffff811115610a6357600080fd5b6020830191508360208260051b8501011115610a7e57600080fd5b9250929050565b60008060208385031215610a9857600080fd5b823567ffffffffffffffff811115610aaf57600080fd5b610abb85828601610a39565b90969095509350505050565b6000815180845260005b81811015610aed57602081850181015186830182015201610ad1565b81811115610aff576000602083870101525b50601f017fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0169290920160200192915050565b600082825180855260208086019550808260051b84010181860160005b84811015610bb1578583037fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe001895281518051151584528401516040858501819052610b9d81860183610ac7565b9a86019a9450505090830190600101610b4f565b5090979650505050505050565b602081526000610bd16020830184610b32565b9392505050565b600060408201848352602060408185015281855180845260608601915060608160051b870101935082870160005b82811015610c52577fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffa0888703018452610c40868351610ac7565b95509284019290840190600101610c06565b509398975050505050505050565b600080600060408486031215610c7557600080fd5b83358015158114610c8557600080fd5b9250602084013567ffffffffffffffff811115610ca157600080fd5b610cad86828701610a39565b9497909650939450505050565b838152826020820152606060408201526000610cd96060830184610b32565b95945050505050565b600060208284031215610cf457600080fd5b813573ffffffffffffffffffffffffffffffffffffffff81168114610bd157600080fd5b600060208284031215610d2a57600080fd5b5035919050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052604160045260246000fd5b7f4e487b7100000000000000000000000000000000000000000000000000000000600052603260045260246000fd5b600082357fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff81833603018112610dc357600080fd5b9190910192915050565b60008083357fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe1843603018112610e0257600080fd5b83018035915067ffffffffffffffff821115610e1d57600080fd5b602001915036819003821315610a7e57600080fd5b8183823760009101908152919050565b600082357fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc1833603018112610dc357600080fd5b600082357fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffa1833603018112610dc357600080fdfea2646970667358221220bb2b5c71a328032f97c676ae39a1ec2148d3e5d6f73d95e9b17910152d61f16264736f6c634300080c00331ca0edce47092c0f398cebf3ffc267f05c8e7076e3b89445e0fe50f6332273d4569ba01b0b9d000e19b24c5869b0fc3b22b0d6fa47cd63316875cbbd577d76e6fde086

CREATE2_ADDR=0x4e59b44847b379578588920ca78fbf26c0b4956c
CREATE2_SENDER=0x3fab184622dc19b6109349b94811493bf2a45362
CREATE2_TX=0xf8a58085174876e800830186a08080b853604580600e600039806000f350fe7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe03601600081602082378035828234f58015156039578182fd5b8082525050506014600cf31ba02222222222222222222222222222222222222222222222222222222222222222a02222222222222222222222222222222222222222222222222222222222222222

# Contracts deployed through the CREATE2 deployer with a zero salt. The
# addresses are hard-coded in seq-store-testing.org and the load tests, so
# a compile that moves them is treated as an error, not silently accepted.
CONTRACTS=(evm-stress address-tester counter)
declare -A EXPECTED_ADDR=(
  [evm-stress]=0x863134579e4812F9d78081e9f519fAE9D01F2a10
  [address-tester]=0x9Dfd20c9B4C90cd77B4b17A1B475B2A8a581FE9B
  [counter]=0xa0046D0D5b3091394CfCb2D3257F026Ac93FFED0
)
declare -A ENV_NAME=(
  [evm-stress]=evm_stress_address
  [address-tester]=address_tester_address
  [counter]=counter_address
)

# ------------------------------------------------------------- logging ----

if [[ -t 1 ]]; then
  C_RED=$'\e[31m'; C_GRN=$'\e[32m'; C_YEL=$'\e[33m'; C_BLU=$'\e[34m'; C_DIM=$'\e[2m'; C_OFF=$'\e[0m'
else
  C_RED=""; C_GRN=""; C_YEL=""; C_BLU=""; C_DIM=""; C_OFF=""
fi

FAILURES=()
step() { printf '\n%s==> %s%s\n' "$C_BLU" "$*" "$C_OFF"; }
info() { printf '    %s\n' "$*"; }
ok()   { printf '    %s[ok]%s   %s\n' "$C_GRN" "$C_OFF" "$*"; }
skip() { printf '    %s[skip]%s %s\n' "$C_DIM" "$C_OFF" "$*"; }
warn() { printf '    %s[warn]%s %s\n' "$C_YEL" "$C_OFF" "$*"; }
fail() { printf '    %s[FAIL]%s %s\n' "$C_RED" "$C_OFF" "$*"; FAILURES+=("$*"); }
die()  { printf '%s[FATAL]%s %s\n' "$C_RED" "$C_OFF" "$*" >&2; exit 1; }

# ------------------------------------------------------------- helpers ----

need() {
  local missing=()
  for bin in "$@"; do command -v "$bin" >/dev/null 2>&1 || missing+=("$bin"); done
  (( ${#missing[@]} == 0 )) || die "missing required tools: ${missing[*]}"
}

rpc() { cast rpc --rpc-url "$RPC_URL" "$@"; }

# code_len ADDR -> number of bytes of code at ADDR
code_len() {
  local code
  code="$(cast code --rpc-url "$RPC_URL" "$1")"
  echo $(( (${#code} - 2) / 2 ))
}

balance_wei() { cast balance --rpc-url "$RPC_URL" "$1"; }

# wait_for_balance ADDR MIN_WEI -> succeeds once ADDR holds >= MIN_WEI
wait_for_balance() {
  local addr="$1" min_wei="$2" deadline=$(( SECONDS + CODE_TIMEOUT ))
  while (( SECONDS < deadline )); do
    (( $(balance_wei "$addr") >= min_wei )) && return 0
    sleep 1
  done
  return 1
}

# wait_for_code ADDR -> succeeds once ADDR has code, fails after CODE_TIMEOUT
wait_for_code() {
  local addr="$1" deadline=$(( SECONDS + CODE_TIMEOUT ))
  while (( SECONDS < deadline )); do
    (( $(code_len "$addr") > 0 )) && return 0
    sleep 1
  done
  return 1
}

# send_admin ARGS... -> cast send from the admin key, retried on transient
# errors (a nonce read from a lagging node behind the load balancer, etc).
send_admin() {
  local attempt out
  for attempt in 1 2 3; do
    if out="$(cast send --rpc-url "$RPC_URL" --private-key "$PRIVATE_KEY" \
        --gas-price "$GAS_PRICE" --priority-gas-price "$GAS_PRICE" \
        --timeout "$TX_TIMEOUT" --json "$@" 2>&1)"; then
      local status hash
      status="$(jq -r '.status' <<<"$out")"
      hash="$(jq -r '.transactionHash' <<<"$out")"
      [[ "$status" == "0x1" ]] && { info "tx $hash mined"; return 0; }
      info "tx $hash reverted (status $status)"
      return 1
    fi
    warn "cast send failed (attempt $attempt/3): $(tail -n 1 <<<"$out")"
    sleep 2
  done
  return 1
}

# ensure_eoa_balance ADDR MIN_ETHER TOPUP_ETHER
ensure_eoa_balance() {
  local addr="$1" min_wei topup="$3"
  min_wei="$(cast to-wei "$2" ether)"
  if (( $(balance_wei "$addr") >= min_wei )); then
    skip "$addr already holds >= $2 ether"
  else
    info "funding $addr with $topup ether"
    send_admin --value "${topup}ether" "$addr"
  fi
}

# ensure_presigned NAME ADDR SENDER RAW_TX
ensure_presigned() {
  local name="$1" addr="$2" sender="$3" raw="$4"
  if (( $(code_len "$addr") > 0 )); then
    skip "$name already deployed at $addr"
    return 0
  fi
  if $CHECK_ONLY; then
    fail "$name missing at $addr"
    return 0
  fi
  if (( $(cast nonce --rpc-url "$RPC_URL" "$sender") > 0 )); then
    fail "$name: presigned sender $sender already used its nonce but $addr has no code; cannot redeploy"
    return 0
  fi
  ensure_eoa_balance "$sender" 0.5 1
  wait_for_balance "$sender" "$(cast to-wei 0.5 ether)" \
    || { fail "$name: funding of $sender not visible on $RPC_URL"; return 0; }
  info "publishing presigned $name deploy tx"
  cast publish --rpc-url "$RPC_URL" --rpc-timeout "$TX_TIMEOUT" "$raw" >/dev/null
  if wait_for_code "$addr"; then
    ok "$name deployed at $addr"
  else
    fail "$name: no code at $addr after publish"
  fi
}

# compile NAME -> writes NAME.bin and NAME.deploy.bin, asserts CREATE2 address
compile() {
  local name="$1" bin
  if command -v docker >/dev/null 2>&1; then
    bin="$(docker run --rm -v "$SCRIPT_DIR":/code:ro "$SOLC_IMAGE" \
      --bin --strict-assembly "/code/$name.yul" | tail -n 1)"
    [[ "$bin" =~ ^[0-9a-fA-F]+$ ]] || die "solc produced no bytecode for $name.yul: $bin"
    echo "$bin" > "$name.bin"
    polycli wrap-contract "$bin" > "$name.deploy.bin"
  elif [[ -s "$name.deploy.bin" ]]; then
    warn "docker not available; using committed $name.deploy.bin"
  else
    die "docker not available and $name.deploy.bin missing; cannot build $name"
  fi
  local got
  got="$(cast create2 --init-code "$(cat "$name.deploy.bin")" --salt "$(cast hz)" | tail -n 1)"
  if [[ "${got,,}" != "${EXPECTED_ADDR[$name],,}" ]]; then
    die "$name compiles to CREATE2 address $got, expected ${EXPECTED_ADDR[$name]}; update EXPECTED_ADDR and the hard-coded addresses in seq-store-testing.org, or restore the previous $name.yul"
  fi
}

# ensure_create2 NAME
ensure_create2() {
  local name="$1"
  local addr="${EXPECTED_ADDR[$name]}"
  if (( $(code_len "$addr") > 0 )); then
    skip "$name already deployed at $addr"
    return 0
  fi
  if $CHECK_ONLY; then
    fail "$name missing at $addr"
    return 0
  fi
  info "deploying $name via CREATE2 deployer"
  send_admin "$CREATE2_ADDR" "$(cast concat-hex "$(cast hz)" "$(cat "$name.deploy.bin")")" || true
  if wait_for_code "$addr"; then
    ok "$name deployed at $addr"
  else
    fail "$name: no code at $addr after deploy"
  fi
}

# ensure_accounts -> accounts.json / private-keys.txt exist with NUM_ACCOUNTS entries
ensure_accounts() {
  local have=0
  [[ -s "$ACCOUNTS_JSON" ]] && have="$(jq '.Addresses | length' "$ACCOUNTS_JSON")"
  if [[ "$have" == "$NUM_ACCOUNTS" ]] \
     && [[ "$(jq -r '.Mnemonic' "$ACCOUNTS_JSON")" == "$MNEMONIC" ]]; then
    skip "$ACCOUNTS_JSON already holds $NUM_ACCOUNTS accounts for this mnemonic"
  else
    info "deriving $NUM_ACCOUNTS accounts into $ACCOUNTS_JSON"
    polycli wallet inspect --mnemonic "$MNEMONIC" --addresses "$NUM_ACCOUNTS" > "$ACCOUNTS_JSON"
  fi
  jq -r '.Addresses[] | "0x" + .HexPrivateKey' "$ACCOUNTS_JSON" > "$KEYS_FILE"
}

# underfunded_indices -> prints the index of every account below MIN_BALANCE
# Uses batched eth_getBalance so 10k accounts take a few seconds, not minutes.
underfunded_indices() {
  local addrs total start min_wei responses
  addrs="$(mktemp)"; responses="$(mktemp)"
  jq -c '[.Addresses[].ETHAddress]' "$ACCOUNTS_JSON" > "$addrs"
  total="$(jq 'length' "$addrs")"
  min_wei="$(cast to-wei "$MIN_BALANCE" ether)"
  for (( start = 0; start < total; start += BALANCE_BATCH )); do
    jq -c --argjson s "$start" --argjson n "$BALANCE_BATCH" \
      '[range($s; ([$s + $n, length] | min)) as $i
        | {jsonrpc: "2.0", id: $i, method: "eth_getBalance", params: [.[$i], "latest"]}]' "$addrs" \
      | curl -sS -X POST -H 'content-type: application/json' --data @- "$RPC_URL" >> "$responses"
    echo >> "$responses"
  done
  local errors
  errors="$(jq -r '.[] | select(.error != null) | .error.message' "$responses" | sort -u)"
  [[ -z "$errors" ]] || die "eth_getBalance batch errors: $errors"
  local got
  got="$(jq -r '.[] | .id' "$responses" | wc -l)"
  (( got == total )) || die "balance check returned $got of $total results"
  # jq numbers are doubles; a wei threshold compare only needs magnitude.
  jq -r --argjson min "$min_wei" '
    def hex2num: ascii_downcase | ltrimstr("0x") | explode
      | map(if . >= 97 then . - 87 else . - 48 end)
      | reduce .[] as $d (0; . * 16 + $d);
    .[] | select((.result | hex2num) < $min) | .id' "$responses" | sort -n
  rm -f "$addrs" "$responses"
}

# ensure_funded -> tops up every account below MIN_BALANCE with FUND_AMOUNT
ensure_funded() {
  local under count
  under="$(underfunded_indices)"
  count="$(grep -c . <<<"$under" || true)"
  if (( count == 0 )); then
    skip "all $NUM_ACCOUNTS accounts hold >= $MIN_BALANCE ether"
    return 0
  fi
  if $CHECK_ONLY; then
    fail "$count of $NUM_ACCOUNTS accounts below $MIN_BALANCE ether"
    return 0
  fi
  local keyfile fund_wei
  keyfile="$(mktemp)"
  jq -r --argjson idx "$(jq -cs . <<<"$under")" \
    '.Addresses as $a | $idx[] | "0x" + $a[.].HexPrivateKey' "$ACCOUNTS_JSON" > "$keyfile"
  fund_wei="$(cast to-wei "$FUND_AMOUNT" ether)"
  info "funding $count accounts with $FUND_AMOUNT ether each via Multicall3"
  polycli fund --rpc-url "$RPC_URL" --private-key "$PRIVATE_KEY" \
    --gas-price "$GAS_PRICE" --priority-gas-price "$GAS_PRICE" \
    --multicall3-address "$MULTICALL3_ADDR" \
    --key-file "$keyfile" --eth-amount "$fund_wei" --file /dev/null
  rm -f "$keyfile"
  under="$(underfunded_indices)"
  count="$(grep -c . <<<"$under" || true)"
  if (( count == 0 )); then
    ok "all $NUM_ACCOUNTS accounts hold >= $MIN_BALANCE ether"
  else
    fail "$count accounts still below $MIN_BALANCE ether after funding (first: $(head -n 3 <<<"$under" | paste -sd,))"
  fi
}

# ---------------------------------------------------------------- main ----

need cast polycli jq curl
$CHECK_ONLY && step "Verify-only mode: no transactions will be sent"

step "Resolving RPC endpoint"
if [[ -z "${RPC_URL:-}" ]]; then
  need kurtosis
  if [[ -z "$RPC_SERVICE" ]]; then
    services="$(kurtosis enclave inspect "$ENCLAVE" | awk '$1 ~ /^[0-9a-f]{12}$/ {print $2}')" \
      || die "cannot inspect enclave $ENCLAVE"
    RPC_SERVICE="$(grep -E '^l2-el-[0-9]+-.*-rpc(-archive)?$' <<<"$services" | sort | head -n 1)"
    [[ -n "$RPC_SERVICE" ]] || RPC_SERVICE="$(grep -E '^l2-el-[0-9]+-' <<<"$services" | sort | head -n 1)"
    [[ -n "$RPC_SERVICE" ]] || die "no l2-el-* service found in enclave $ENCLAVE"
  fi
  RPC_URL="$(kurtosis port print "$ENCLAVE" "$RPC_SERVICE" rpc)" \
    || die "cannot resolve rpc port of $RPC_SERVICE in enclave $ENCLAVE"
  info "service $RPC_SERVICE"
fi
info "RPC_URL=$RPC_URL"

step "Waiting for chain to produce blocks"
deadline=$(( SECONDS + 60 )); first=""
while (( SECONDS < deadline )); do
  if now="$(cast block-number --rpc-url "$RPC_URL" 2>/dev/null)"; then
    [[ -z "$first" ]] && first="$now"
    (( now > first )) && break
  fi
  sleep 2
done
[[ -n "${now:-}" ]] || die "RPC at $RPC_URL not answering"
(( now > first )) || die "block number stuck at $now for 60s"
ok "head at block $now, chain id $(cast chain-id --rpc-url "$RPC_URL")"
admin_addr="$(cast wallet address --private-key "$PRIVATE_KEY")"
info "admin $admin_addr balance $(cast balance --rpc-url "$RPC_URL" -e "$admin_addr") ether"

step "Multicall3"
ensure_presigned Multicall3 "$MULTICALL3_ADDR" "$MULTICALL3_SENDER" "$MULTICALL3_TX"

step "CREATE2 deployer"
ensure_presigned "CREATE2 deployer" "$CREATE2_ADDR" "$CREATE2_SENDER" "$CREATE2_TX"

step "Compiling test contracts"
for name in "${CONTRACTS[@]}"; do
  compile "$name"
  ok "$name -> ${EXPECTED_ADDR[$name]}"
done

step "Deploying test contracts"
if (( $(code_len "$CREATE2_ADDR") == 0 )); then
  for name in "${CONTRACTS[@]}"; do fail "$name: cannot deploy, CREATE2 deployer missing"; done
else
  for name in "${CONTRACTS[@]}"; do ensure_create2 "$name"; done
fi

step "Test accounts"
ensure_accounts
ensure_funded

step "Summary"
printf '    %-18s %-44s %s\n' CONTRACT ADDRESS CODE_BYTES
for pair in "Multicall3:$MULTICALL3_ADDR" "CREATE2 deployer:$CREATE2_ADDR"; do
  printf '    %-18s %-44s %s\n' "${pair%%:*}" "${pair#*:}" "$(code_len "${pair#*:}")"
done
for name in "${CONTRACTS[@]}"; do
  printf '    %-18s %-44s %s\n' "$name" "${EXPECTED_ADDR[$name]}" "$(code_len "${EXPECTED_ADDR[$name]}")"
done

{
  echo "# generated by bootstrap.sh $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "export RPC_URL=\"$RPC_URL\""
  echo "export PRIVATE_KEY=\"$PRIVATE_KEY\""
  echo "export MNEMONIC=\"$MNEMONIC\""
  echo "export KEYS_FILE=\"$SCRIPT_DIR/$KEYS_FILE\""
  echo "export multicall3_address=$MULTICALL3_ADDR"
  echo "export create2_deployer_address=$CREATE2_ADDR"
  for name in "${CONTRACTS[@]}"; do
    echo "export ${ENV_NAME[$name]}=${EXPECTED_ADDR[$name]}"
  done
} > "$ENV_FILE"
info "wrote $ENV_FILE (source it to get the addresses in your shell)"

if (( ${#FAILURES[@]} > 0 )); then
  printf '\n%sBOOTSTRAP FAILED%s (%d problem(s)):\n' "$C_RED" "$C_OFF" "${#FAILURES[@]}"
  for f in "${FAILURES[@]}"; do printf '  - %s\n' "$f"; done
  exit 1
fi
printf '\n%sBOOTSTRAP OK%s: contracts deployed at expected addresses, %s accounts funded.\n' "$C_GRN" "$C_OFF" "$NUM_ACCOUNTS"
