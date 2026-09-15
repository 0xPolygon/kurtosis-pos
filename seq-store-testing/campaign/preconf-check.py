#!/usr/bin/env python3
"""Verify preconfirmation receipts against the canonical chain.

usage: preconf-check.py probes/preconfs-<label>.jsonl [--rpc-url URL] [--since ISO] [--until ISO]

For every recorded tx: fetch the canonical receipt from an archive node and
classify:
  ok        canonical receipt exists, same log topic (counter value) as the preconf
  moved     same topic but a different block number than the preconf receipt claimed
  mismatch  different topic: the preconfirmed execution differed from the chain
  missing   no canonical receipt at all (tx dropped)
Also reports how many recorded receipts were preconfs (blockHash null) vs
already-sealed, latency percentiles, and mismatches by minute so they can be
joined to fault windows.
"""
import json, sys, argparse, subprocess, urllib.request, datetime as dt
from collections import Counter

ap = argparse.ArgumentParser()
ap.add_argument('file'); ap.add_argument('--rpc-url'); ap.add_argument('--since'); ap.add_argument('--until')
a = ap.parse_args()
def ts(s):
    s = s.replace('Z','+00:00')
    return dt.datetime.fromisoformat(s)
rpc = a.rpc_url or subprocess.run(['kurtosis','port','print','pos','l2-el-8-bor-heimdall-v2-rpc-archive','rpc'],capture_output=True,text=True,check=True).stdout.strip()
rows=[]
for line in open(a.file):
    line=line.strip()
    if not line: continue
    try: r=json.loads(line)
    except json.JSONDecodeError: continue
    if a.since and ts(r['t']) < ts(a.since): continue
    if a.until and ts(r['t']) > ts(a.until): continue
    rows.append(r)
if not rows: sys.exit('no rows')
def fetch(hashes):
    payload=[{"jsonrpc":"2.0","id":i,"method":"eth_getTransactionReceipt","params":[h]} for i,h in enumerate(hashes)]
    req=urllib.request.Request(rpc,data=json.dumps(payload).encode(),headers={'Content-Type':'application/json'})
    with urllib.request.urlopen(req,timeout=120) as resp: res=json.load(resp)
    by={r['id']:r.get('result') for r in res}
    return [by.get(i) for i in range(len(hashes))]
cls=Counter(); bad=[]; per_min=Counter(); pre=sum(1 for r in rows if r.get('bh') in (None,'') or r.get('pre'))
durs=sorted(r['dur'] for r in rows if isinstance(r.get('dur'),(int,float)))
for i in range(0,len(rows),200):
    batch=rows[i:i+200]; recs=fetch([r['tx'] for r in batch])
    for r,rec in zip(batch,recs):
        minute=r['t'][:16]
        if rec is None: cls['missing']+=1; bad.append((r['t'],r['tx'],'missing',r.get('idx'),None)); per_min[(minute,'missing')]+=1; continue
        logs=rec.get('logs') or []
        topic=logs[0]['topics'][0] if logs and logs[0].get('topics') else None
        if topic!=r.get('idx'):
            kind='mismatch-nologs' if r.get('idx') is None else 'mismatch'
            cls[kind]+=1; bad.append((r['t'],r['tx'],kind,r.get('idx'),topic,'pre' if r.get('pre') else 'sealed',r.get('st'))); per_min[(minute,kind)]+=1; continue
        if r.get('bn') and rec.get('blockNumber') and int(r['bn'],16)!=int(rec['blockNumber'],16):
            cls['moved']+=1; bad.append((r['t'],r['tx'],'moved',int(r['bn'],16),int(rec['blockNumber'],16))); per_min[(minute,'moved')]+=1; continue
        cls['ok']+=1
n=len(rows); pct=lambda p: durs[min(len(durs)-1,int(len(durs)*p))] if durs else 0
print(f"rows={n} window={rows[0]['t']}..{rows[-1]['t']} preconf_receipts={pre} ({100*pre/n:.1f}%) sealed_receipts={n-pre}")
print(f"latency ms p50={pct(.5)} p95={pct(.95)} p99={pct(.99)} max={durs[-1] if durs else 0}")
print("classification: "+" ".join(f"{k}={cls[k]}" for k in ('ok','moved','mismatch','mismatch-nologs','missing')))
if per_min:
    print("problems by minute:")
    for (m,k),c in sorted(per_min.items()): print(f"  {m} {k}={c}")
for b in bad[:15]: print("  ", *b)
sys.exit(1 if cls['mismatch'] or cls['mismatch-nologs'] or cls['missing'] else 0)
