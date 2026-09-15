#!/usr/bin/env python3
"""Join shadow-el9 receipts (what a consumer client saw) with canonical receipts from el-8.
usage: shadow-check.py probes/shadow-<label>.jsonl"""
import json, sys, urllib.request, subprocess
rpc=subprocess.run(['kurtosis','port','print','pos','l2-el-8-bor-heimdall-v2-rpc-archive','rpc'],capture_output=True,text=True).stdout.strip()
rows=[json.loads(l) for l in open(sys.argv[1]) if l.strip()]
seen=[r for r in rows if r.get('seen_after_ms') is not None]
print(f"shadow rows={len(rows)} never_seen_on_el9_within_30s={len(rows)-len(seen)} served_as_preconf={sum(1 for r in seen if r.get('pre'))} served_sealed={sum(1 for r in seen if not r.get('pre'))}")
def fetch(hs):
    pl=[{"jsonrpc":"2.0","id":i,"method":"eth_getTransactionReceipt","params":[h]} for i,h in enumerate(hs)]
    req=urllib.request.Request(rpc,data=json.dumps(pl).encode(),headers={'Content-Type':'application/json'})
    res=json.load(urllib.request.urlopen(req,timeout=120)); by={r['id']:r.get('result') for r in res}; return [by.get(i) for i in range(len(hs))]
ok=0; bad=[]
for i in range(0,len(seen),200):
    b=seen[i:i+200]
    for r,rec in zip(b,fetch([r['tx'] for r in b])):
        if rec is None: bad.append((r['t'],r['tx'][:12],'missing',r.get('idx'),None,'pre' if r.get('pre') else 'sealed')); continue
        logs=rec.get('logs') or []; topic=logs[0]['topics'][0] if logs else None
        if topic!=r.get('idx'): bad.append((r['t'],r['tx'][:12],'MISMATCH',r.get('idx'),topic,'pre' if r.get('pre') else 'sealed'))
        elif r.get('bn') and int(r['bn'],16)!=int(rec['blockNumber'],16): bad.append((r['t'],r['tx'][:12],'moved',int(r['bn'],16),int(rec['blockNumber'],16),'pre' if r.get('pre') else 'sealed'))
        else: ok+=1
print(f"el-9 receipts vs canonical: ok={ok} problems={len(bad)} ({sum(1 for b in bad if b[2]=='missing')} missing, {sum(1 for b in bad if b[2]=='MISMATCH')} mismatch, {sum(1 for b in bad if b[2]=='moved')} moved)")
for x in bad[:12]: print("  ",*x)
lat=sorted(r['seen_after_ms'] for r in seen)
if lat: print(f"el-9 first-receipt latency ms p50={lat[len(lat)//2]} p95={lat[int(len(lat)*.95)]} max={lat[-1]}")
