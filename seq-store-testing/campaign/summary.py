#!/usr/bin/env python3
"""Cross-episode summary table (markdown) from records/*.json + oracle.log.
usage: summary.py            -> prints the table
"""
import json, glob, io, os, re, subprocess, sys, pathlib, contextlib
here = pathlib.Path(__file__).resolve().parent
rows = []
for f in sorted(glob.glob(str(here/'records'/'*.json'))):
    fid = pathlib.Path(f).stem
    if fid.startswith('auditor'): continue
    d = json.load(open(f)).get('data') or {}
    if not d.get('started_at'): continue
    kind = d.get('kind'); params = d.get('params') or {}
    targets = d.get('targets') or ([params.get('node')] if params.get('node') else [])
    if kind == 'partition':
        g = (d.get('details') or {}).get('groups') or params.get('groups') or []
        targets = [f"{len(g[0]) if g else '?'} vs {len(g[1]) if len(g)>1 else '?'} nodes"] if g else ['partition']
    extra = ''
    if kind == 'netem-latency': extra = f" {params.get('delay','')}{' loss '+str(params.get('loss_percent'))+'%' if params.get('loss_percent') else ''}"
    started, stopped = d['started_at'], d.get('stopped_at') or d['started_at']
    from datetime import datetime
    ts = lambda s: datetime.fromisoformat(s.replace('Z','+00:00'))
    hold = int((ts(stopped)-ts(started)).total_seconds())
    out = subprocess.run([sys.executable, str(here/'analyze.py'), fid], capture_output=True, text=True).stdout
    m = re.search(r'during : (\d+) blocks in (\d+)s = ([\d.]+) blocks/s', out)
    rate = m.group(3) if m else '-'
    stalls = [int(x) for x in re.findall(r'stall_max=(\d+)s', out)]
    # exclude the killed/paused/partitioned node's own stall: report the max over other nodes as "network stall"
    net_stall = sorted(stalls)[-2] if len(stalls) >= 2 else (stalls[0] if stalls else 0)
    pr = re.search(r'per_node_reorgs=(\d+)', out); back = re.search(r'height_went_backwards=(\d+)', out)
    ms = re.search(r'milestone longest unchanged: (\d+)s', out)
    rows.append((fid, kind+extra, ','.join(t.replace('-bor-heimdall-v2','').replace('-heimdall-v2-bor','').replace('seqstore-','') for t in targets), hold, rate, net_stall, max(stalls) if stalls else 0, pr.group(1) if pr else '-', back.group(1) if back else '-', ms.group(1) if ms else '-'))
print('| id | fault | targets | hold s | blocks/s during | network stall s | worst node stall s | per-node reorgs | height backwards | milestone frozen s |')
print('| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |')
for r in rows: print('| ' + ' | '.join(str(x) for x in r) + ' |')
