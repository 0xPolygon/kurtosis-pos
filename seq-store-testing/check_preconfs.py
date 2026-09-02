#!/usr/bin/env python3
"""Summarize and verify preconf results from polycli loadtest output.

Reads a file of newline-delimited JSON objects like:

    {"tx":"0x...","dur":100,"idx":"0x...","bh":null}

(produced by `polycli loadtest ... | jq -c '...' | tee -a preconfs.txt`),
prints duration stats and block-hash coverage, then fetches every
transaction receipt from an RPC and checks that the receipt's
logs[0].topics[0] matches the recorded idx. A mismatch would indicate the
preconfirmed execution result differed from the canonical chain (e.g. a
reorg). Expected accuracy is 100%.

Usage:
    ./check_preconfs.py [preconfs.txt] [--rpc-url URL] [--concurrency N]

If --rpc-url is omitted, the URL is resolved with:
    kurtosis port print pos l2-el-9-bor-heimdall-v2-rpc rpc
"""

import argparse
import json
import subprocess
import sys
import urllib.request
from concurrent.futures import ThreadPoolExecutor

BATCH_SIZE = 100

def percentile(sorted_vals, p):
    if not sorted_vals:
        return None
    k = (len(sorted_vals) - 1) * p / 100
    lo, hi = int(k), min(int(k) + 1, len(sorted_vals) - 1)
    return sorted_vals[lo] + (sorted_vals[hi] - sorted_vals[lo]) * (k - lo)

def default_rpc_url():
    out = subprocess.run(
        ["kurtosis", "port", "print", "pos", "l2-el-9-bor-heimdall-v2-rpc", "rpc"],
        capture_output=True, text=True, check=True,
    )
    return out.stdout.strip()

def fetch_receipts(rpc_url, tx_hashes):
    """Fetch receipts for a batch of tx hashes via one batched JSON-RPC call.

    Returns {tx_hash: receipt_or_None}.
    """
    payload = [
        {"jsonrpc": "2.0", "id": i, "method": "eth_getTransactionReceipt", "params": [h]}
        for i, h in enumerate(tx_hashes)
    ]
    req = urllib.request.Request(
        rpc_url,
        data=json.dumps(payload).encode(),
        headers={"Content-Type": "application/json"},
    )
    with urllib.request.urlopen(req, timeout=60) as resp:
        results = json.load(resp)
    by_id = {r["id"]: r.get("result") for r in results}
    return {h: by_id.get(i) for i, h in enumerate(tx_hashes)}

def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("file", nargs="?", default="preconfs.txt")
    parser.add_argument("--rpc-url", help="RPC endpoint (default: kurtosis port print ...)")
    parser.add_argument("--concurrency", type=int, default=10, help="parallel batch requests")
    parser.add_argument("--skip-verify", action="store_true", help="only print duration stats")
    args = parser.parse_args()

    entries = []
    with open(args.file) as f:
        for lineno, line in enumerate(f, 1):
            line = line.strip()
            if not line:
                continue
            try:
                entries.append(json.loads(line))
            except json.JSONDecodeError:
                print(f"warning: skipping malformed line {lineno}", file=sys.stderr)

    if not entries:
        sys.exit(f"no entries found in {args.file}")

    durations = sorted(e["dur"] for e in entries)
    with_bh = sum(1 for e in entries if e.get("bh"))
    n = len(entries)

    print(f"transactions:    {n}")
    print(f"duration p50:    {percentile(durations, 50):.1f} ms")
    print(f"duration p95:    {percentile(durations, 95):.1f} ms")
    print(f"duration p99:    {percentile(durations, 99):.1f} ms")
    print(f"duration max:    {durations[-1]} ms")
    print(f"with blockhash:  {with_bh}/{n} ({100 * with_bh / n:.1f}%)")

    if args.skip_verify:
        return

    rpc_url = args.rpc_url or default_rpc_url()
    print(f"\nverifying receipts against {rpc_url} ...")

    batches = [entries[i:i + BATCH_SIZE] for i in range(0, n, BATCH_SIZE)]
    matched = mismatched = missing = 0
    mismatches = []

    with ThreadPoolExecutor(max_workers=args.concurrency) as pool:
        receipt_maps = pool.map(
            lambda b: fetch_receipts(rpc_url, [e["tx"] for e in b]), batches
        )
        for batch, receipts in zip(batches, receipt_maps):
            for e in batch:
                receipt = receipts.get(e["tx"])
                if receipt is None:
                    missing += 1
                    mismatches.append((e["tx"], e["idx"], "<no receipt>"))
                    continue
                logs = receipt.get("logs") or []
                actual = logs[0]["topics"][0] if logs and logs[0].get("topics") else "<no topic>"
                if actual == e["idx"]:
                    matched += 1
                else:
                    mismatched += 1
                    mismatches.append((e["tx"], e["idx"], actual))

    print(f"matched:         {matched}/{n}")
    print(f"mismatched:      {mismatched}/{n}")
    print(f"missing receipt: {missing}/{n}")
    print(f"accuracy:        {100 * matched / n:.2f}%")

    if mismatches:
        print("\nfirst mismatches (tx, expected idx, actual):")
        for tx, expected, actual in mismatches[:10]:
            print(f"  {tx}  expected={expected}  actual={actual}")
        sys.exit(1)

if __name__ == "__main__":
    main()
