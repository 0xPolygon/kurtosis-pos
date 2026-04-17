---
name: kurtosis-pos-interact
description: Interact with a running Polygon PoS devnet. Covers enclave inspection, service logs and shells, port access, cast chain interaction, monitoring health checks, observability stack, and EIP-2935 verification.
allowed-tools: Bash, Read, Glob, Grep
compatibility: Requires a running kurtosis-pos enclave.
---

## Related skills

- **kurtosis-pos-deploy** — deploy an enclave first
- **kurtosis-pos-test** — bridge flows, chaos, and e2e tests

---

## Enclave inspection

```bash
# List all running services, their status, and exposed ports
kurtosis enclave inspect pos

# Print the URL for a specific port
kurtosis port print pos l2-el-0-bor-heimdall-v2-validator rpc

# List all file artifacts in the enclave
kurtosis files ls pos

# Download a specific artifact
kurtosis files download pos <artifact-name> ./output/
```

---

## Service logs and shells

```bash
# Stream live logs from a service
kurtosis service logs pos l2-el-0-bor-heimdall-v2-validator --follow

# Get a shell inside a running container
kurtosis service shell pos l2-el-0-bor-heimdall-v2-validator

# Dump all logs and artifacts to disk
kurtosis enclave dump pos ./enclave-dump
```

---

## Chain interaction with cast

```bash
# Get the RPC URL for the L2 EL
RPC_URL=$(kurtosis port print pos l2-el-0-bor-heimdall-v2-validator rpc)

# Read the current block number
cast block-number --rpc-url $RPC_URL

# Get the latest block
cast block latest --rpc-url $RPC_URL

# Check an account balance
cast balance 0x74Ed6F462Ef4638dc10FFb05af285e8976Fb8DC9 --rpc-url $RPC_URL

# Send a transaction (use env var for private key)
cast send \
  --private-key 0xd40311b5a5ca5eaeb48dfba5403bde4993ece8eccf4190e98e19fcd4754260ea \
  --rpc-url $RPC_URL \
  <to_address> \
  --value 1ether
```

---

## Health monitors

Run these after deploy to confirm the devnet is healthy. Each script polls until the condition is met or times out.

```bash
# Poll all Bor EL RPCs until block 40 (sends txs to stimulate progress)
#   first = only check the first validator; all = check every EL participant
.github/actions/monitor/blocks-bor.sh pos first
.github/actions/monitor/blocks-bor.sh pos all

# Poll Heimdall for CL block progress
.github/actions/monitor/blocks-heimdall.sh pos

# Poll until ≥1 span produced
.github/actions/monitor/spans.sh pos

# Poll until ≥1 milestone produced
.github/actions/monitor/milestones.sh pos

# Poll until ≥1 checkpoint committed to L1
.github/actions/monitor/checkpoints.sh pos
```

---

## Observability stack

Enable via `additional_services: [observability]` in your config.

| Service           | URL (after `kurtosis port print`) | Purpose                    |
| ----------------- | --------------------------------- | -------------------------- |
| `prometheus`      | port `http`                       | Metrics scraping           |
| `grafana`         | port `http`                       | Dashboards                 |
| `panoptichain`    | port `http`                       | Multi-chain block/tx stats |
| `ethstats-server` | port `http`                       | Live node dashboard        |
| `status-checker`  | port `http`                       | Network health monitor     |

```bash
# Get Grafana URL
kurtosis port print pos grafana http

# Get Panoptichain URL
kurtosis port print pos panoptichain http
```

---

## EIP-2935 verification

Verifies that historical block hashes are stored in the `0x0000F9...2935` contract (activated at the Rio hard fork).

```bash
# Verify against the L2 RPC — checks the last n blocks (default: 10)
RPC_URL=$(kurtosis port print pos l2-el-0-bor-heimdall-v2-validator rpc)
./scripts/verify_eip2935.sh $RPC_URL 20
```

---

## Heimdall REST API (CL)

```bash
# Get the CL REST API port
CL_URL=$(kurtosis port print pos l2-cl-0-heimdall-v2-bor-validator rest)

# Latest span
curl -s $CL_URL/bor/latest-span | jq .

# Latest milestone
curl -s $CL_URL/milestone/latest | jq .

# Checkpoint count
curl -s $CL_URL/checkpoints/count | jq .

# Checkpoint list
curl -s $CL_URL/checkpoints/list | jq .
```
