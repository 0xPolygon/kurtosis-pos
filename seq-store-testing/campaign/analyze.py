#!/usr/bin/env python3
"""Summarize oracle.log over a fault window.

usage: analyze.py <fault-id> [--margin SECS]
Reads campaign/records/<id>.json (tartarus record) for started_at/stopped_at,
scans probes/oracle.log from started_at-margin to stopped_at+margin and reports:
  - per node: longest stretch with no height increase (stall), max height reached
  - divergence: samples where nodes disagree on the hash for the same height
  - reorg: a node reporting a hash for height H that differs from a hash it
    (or any node) previously reported for H, or a node's height going backwards
  - milestone / ingress / gateway progress over the window
  - producer publish metric deltas (barrier timeouts, failures, redials)
"""
import json, re, sys, datetime as dt, pathlib

here = pathlib.Path(__file__).resolve().parent
fid = sys.argv[1]
margin = int(sys.argv[sys.argv.index('--margin')+1]) if '--margin' in sys.argv else 90
rec = json.load(open(here/'records'/f'{fid}.json'))['data']
if not rec or not rec.get('started_at'):
    print(f'{fid}: no fault record (command failed before reservation)'); sys.exit(0)
def ts(s): return dt.datetime.fromisoformat(s.replace('Z','+00:00'))
t0, t1 = ts(rec['started_at']), ts(rec['stopped_at'] or rec['started_at'])
lo, hi = t0 - dt.timedelta(seconds=margin), t1 + dt.timedelta(seconds=margin)

rows = []
for line in open(here/'probes'/'oracle.log'):
    m = re.match(r'(\S+) author=(\S*) ms=(\S*) cp=(\S*) ing=(\S*) gw0=(\S*) \|(.*)', line.rstrip())
    if not m: continue
    t = ts(m.group(1))
    if t < lo or t > hi: continue
    rest = m.group(7)
    nodes = dict(re.findall(r'el-(\d)=(\S+)', rest))
    prods = dict(re.findall(r'p(\d): (state=\S* barrier=\S* failed=\S* redial=\S* muted=\S* seal_p50_\w+=\S*)', rest))
    rows.append(dict(t=t, author=m.group(2), ms=m.group(3), cp=m.group(4), ing=m.group(5), gw0=m.group(6), nodes=nodes, prods=prods))

if not rows:
    print('no samples in window'); sys.exit(0)

def phase(t):
    if t < t0: return 'before'
    if t <= t1: return 'during'
    return 'after'

print(f'# {fid}  kind={rec["kind"]}  window {lo:%H:%M:%S}..{hi:%H:%M:%S}Z  fault {t0:%H:%M:%S}..{t1:%H:%M:%S}Z  samples={len(rows)}')
print(f'authors seen: before={sorted({r["author"] for r in rows if phase(r["t"])=="before"})} during={sorted({r["author"] for r in rows if phase(r["t"])=="during"})} after={sorted({r["author"] for r in rows if phase(r["t"])=="after"})}')

# throughput per phase, from the max height across nodes at each sample
print('\n## block rate per phase (max height across nodes)')
for ph in ('before','during','after'):
    pts=[(r['t'], max(int(v.split(':')[0]) for v in r['nodes'].values() if v.split(':')[0].isdigit())) for r in rows if phase(r['t'])==ph and any(v.split(':')[0].isdigit() for v in r['nodes'].values())]
    if len(pts)>=2:
        secs=(pts[-1][0]-pts[0][0]).total_seconds(); blocks=pts[-1][1]-pts[0][1]
        print(f'  {ph:7s}: {blocks} blocks in {secs:.0f}s = {blocks/secs if secs else 0:.2f} blocks/s  ({pts[0][1]}..{pts[-1][1]})')

# stalls and heights
print('\n## per-node height progress (stall = longest gap with no increase)')
for n in '123456789':
    last=None; last_t=None; worst=0; worst_at=None; downs=0; hmax=0; hmin=None
    for r in rows:
        v = r['nodes'].get(n, 'down')
        if not v.split(':')[0].isdigit():
            downs += 1; continue
        h = int(v.split(':')[0]); hmax=max(hmax,h); hmin = h if hmin is None else min(hmin,h)
        if last is None or h > last:
            last, last_t = h, r['t']
        else:
            gap = (r['t']-last_t).total_seconds()
            if gap > worst: worst, worst_at = gap, last_t
    print(f'  el-{n}: {hmin}..{hmax}  stall_max={worst:.0f}s' + (f' (from {worst_at:%H:%M:%S}Z, {phase(worst_at)})' if worst_at else '') + (f'  down_samples={downs}' if downs else ''))

# divergence + reorg
print('\n## hash consistency')
seen = {}   # height -> {hash: first time}
reorgs = []; diverg = []; backwards = []
prev = {}
for r in rows:
    byh = {}
    for n, v in r['nodes'].items():
        if not v.split(':')[0].isdigit() or ':' not in v: continue
        h, hs = v.split(':'); h=int(h)
        byh.setdefault(h, {}).setdefault(hs, []).append(n)
        if n in prev and h < prev[n]:
            backwards.append((r['t'], n, prev[n], h))
        prev[n] = h
    for h, hashes in byh.items():
        if len(hashes) > 1: diverg.append((r['t'], h, hashes))
        for hs in hashes:
            if h in seen and hs not in seen[h]:
                reorgs.append((r['t'], h, list(seen[h])[0], hs, hashes[hs]))
            seen.setdefault(h, {}).setdefault(hs, r['t'])
# per-node reorgs: the same node reports a different hash for a height it already reported
pernode = {}
node_reorgs = []
for r in rows:
    for n, v in r['nodes'].items():
        if not v.split(':')[0].isdigit() or ':' not in v: continue
        h, hs = v.split(':'); h=int(h)
        prevh = pernode.setdefault(n, {}).get(h)
        if prevh and prevh != hs: node_reorgs.append((r['t'], n, h, prevh, hs))
        pernode[n][h] = hs
print(f'  heights sampled={len(seen)}  divergent_samples={len(diverg)}  cross_node_hash_changes={len(reorgs)}  per_node_reorgs={len(node_reorgs)}  height_went_backwards={len(backwards)}')
for nr in node_reorgs[:12]: print(f'   NODE-REORG {nr[0]:%H:%M:%S}Z el-{nr[1]} h={nr[2]} {nr[3]} -> {nr[4]}  [{phase(nr[0])}]')
for d in diverg[:8]: print(f'   divergence {d[0]:%H:%M:%S}Z h={d[1]} ' + ' vs '.join(f"{k}<-el{','.join(v)}" for k,v in d[2].items()))
for rg in reorgs[:8]: print(f'   cross-node {rg[0]:%H:%M:%S}Z h={rg[1]} first_seen={rg[2]} later={rg[3]} on el-{",".join(rg[4])}  [{phase(rg[0])}]')
for b in backwards[:8]: print(f'   BACKWARDS {b[0]:%H:%M:%S}Z el-{b[1]} {b[2]} -> {b[3]}  [{phase(b[0])}]')

# finality / store progress
def first_last(key):
    vals=[(r['t'], r[key]) for r in rows if r[key] not in ('?','')]
    return (vals[0], vals[-1]) if vals else (None,None)
print('\n## finality and store progress (first -> last in window)')
for k in ('ms','cp','ing','gw0'):
    f,l = first_last(k)
    if f: print(f'  {k}: {f[1]} -> {l[1]}')
# milestone stall
last=None; last_t=None; worst=0
for r in rows:
    if r['ms'] in ('?',''): continue
    if last is None or r['ms']!=last: last, last_t = r['ms'], r['t']
    else: worst=max(worst,(r['t']-last_t).total_seconds())
print(f'  milestone longest unchanged: {worst:.0f}s')

print('\n## producer publish metrics (first -> last)')
for n in '123':
    vals=[r['prods'][n] for r in rows if n in r['prods']]
    if vals: print(f'  p{n}: {vals[0]}\n      -> {vals[-1]}')
