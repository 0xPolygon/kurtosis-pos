# Tartarus feedback from the seq-store chaos campaign

Context: 30 episodes against a 40-service Kurtosis enclave (`pos`) in one
session, all five kinds except clock-skew, ids `s01..s13` / `p01..p17`,
driven from a bash wrapper (`campaign/lib.sh: episode`) and JSON output.
Version `v0.3-contract`, schema `tartarus.cli/v1`, record format 2.
Everything below is from that run; line numbers refer to `CAMPAIGN.md`.

## What worked and should not change

- **One JSON envelope per command, `error.code` to branch on.** I never
  parsed a message. `INVALID_ARGS` exit 2 with nothing attempted (the
  19-char id) was exactly right.
- **`fault run --for` as the default unit of work.** Apply, hold,
  reverse, return the finished record: the whole campaign was
  `run` calls; I never needed `start`/`stop` by hand.
- **The record is the evidence.** `started_at/applied_at/verified_at/
  stopped_at`, `observed`, `targets_before/after`, `endpoint_changes`
  gave every timestamp the report needed. `inspect` text output is
  readable.
- **Recovery is reliable.** 30 of 30 recovered, `fault list` empty at
  the end, no leftover iptables chains or qdiscs, `cleanup --all` a
  no-op. Restart-with-new-ports was reported every time.
- **Fan-out under one id, explicit `--group a,b --group c` partitions,
  `--dry-run` with `ready/conflicts/plan`, `doctor` telling me netem
  and partition would work before I tried.** The kurtosis reference
  campaign in the skill was the fastest onboarding I have had for a
  fault tool.

## Friction, most costly first

1. **stderr noise per call.** Every `cluster nodes`, `doctor`, `fault
   run` prints 35 lines of `kurtosis: service exists but is not running;
   attaching anyway` for the enclave's exited one-shot containers
   (genesis generators, key generators, deployers). I had to `2>/dev/null`
   everything, which also hid real warnings. Suggest: one summary line
   (`attached 76 services, 36 exited`) at INFO, per-service detail at
   DEBUG, or skip containers with `com.kurtosistech.container-type` of
   a one-shot task.

2. **Fault id max 19 chars, discovered after the campaign was half
   named.** `p15-netem-loss-inturn` (21) was refused; the limit exists so
   `tartarus-<id>` fits an iptables chain name. The human id should not
   inherit a kernel constraint: derive the chain name from a short hash
   of the id and let ids be free-form (or at least 40 chars). If the
   limit stays, `fault kinds`/`--help` should state it up front.

3. **Ports after restart are the operator's problem, again and again.**
   `endpoint_changes` tells me ports moved; then I need
   `cluster nodes | jq '...select(.name==$n)...|select(.container_port==$p and .host_ip=="0.0.0.0")'`
   for every probe, and my own atomic-write cache so a probe never reads a
   half-written node list. A `tartarus cluster port <node> <container_port>`
   (or `cluster nodes --node X --port P`) that prints one host port would
   remove the most repeated jq in the harness.

4. **`cluster nodes` returns everything.** 76 entries, 36 of them exited
   one-shots I can never target. `--running` or `--status running` would
   make the list usable directly in fan-outs.

5. **Targeting many nodes is verbose.** A partition of one producer from
   "everything else plus the whole store" was a 17-name `--group`. Glob
   or regex targeting (`--group 'l2-el-*' --group 'seqstore-*'`), or
   `--group-file`, would make those lines legible and less error-prone.

6. **Record shape varies by kind.** Single node: `targets: null`,
   `params.node` set, `instances[0].target: null`. Fan-out:
   `params.node: ""`, nodes in `targets`, `instances[].target` set.
   Partition: sides in `details.groups`. My summary script needed three
   branches. A normalized `targets[]` (always an array) plus
   `instances[].target` (always set) would make records uniform;
   keep the kind-specific detail under `details`.

7. **Log window is manual.** Every episode I converted `started_at` to
   epoch, subtracted a margin, found the container id from the service
   name, and ran `docker logs --since --until`. Either add `*_unix`
   twins of the timestamps to the record, or a
   `tartarus fault logs <id> --service X [--before 30s --after 75s]`
   that does exactly that and writes to a file. This is the single
   biggest chunk of harness code I wrote.

8. **Mid-hold evidence with `run` needs a second shell.** `verify` after
   `run` returns lands after the hold. A `--verify-every 10s` on `run`
   that appends observations to the record (`observations[]` with
   timestamps) would give mid-hold primitive evidence for free.

9. **No note on the record.** I kept the hypothesis in a separate
   markdown table. `--note "hypothesis: ..."` stored in the record and
   shown by `inspect`/`list --done` would tie intent to evidence.

10. **`endpoint_changes` doubles every port** (one entry for `0.0.0.0`,
    one for `::`). Default to one entry per port with both families
    inside, flag to expand.

## Missing primitives I wanted

- **Resource pressure**: `docker update --cpus/--memory` as a kind
  (`throttle`), with restore on stop. Slow-node behavior (F3, F7 in the
  report) is the interesting regime and netem only approximates it.
- **Graceful stop** as a first-class kind or alias (`stop` = `kill
  --param signal=TERM` with restart). SIGKILL of the single L1 geth
  reset it to block 7 (F11); with `stop` the same test would have been
  meaningful.
- **Flapping / repeated holds**: `run --for 20s --cycles 5 --gap 10s`.
  Reconnect storms and backoff bugs need repetition, not one hold.
- **Condition-bounded holds**: `--until-metric <url> <name> <op> <value>`
  or `--until-cmd`. "Hold until the chain stalls" or "until milestones
  freeze" is how I actually think about several episodes.
- **`netem-latency` naming**: it is the loss kind too. `netem` with
  `delay/jitter/loss_percent` all optional, or a `netem-loss` alias, and
  document whether `delay` is required (I passed `delay=1ms` to be safe).
- **Partition with a per-side allow list**: "isolate el-3 from all bor
  but keep its heimdall" worked by omission, which is fine; "isolate from
  bor peers but allow the store" needed a second, huge group. A
  `--except a,b` on a group would express that directly.

## Docs and skill

- The kurtosis worked campaign is excellent; add the two lessons I paid
  for: the 19-char id limit, and "kill vs stop" for stateful singletons.
- State explicitly that `fault run` on a fan-out returns a single record
  with `instances[]`, and show a jq for the per-instance recovery state.
- The `report-template.md` asks for `held_seconds` from `stop.json`;
  with `run` there is no stop.json. Say "compute `stopped_at - started_at`"
  there, not only in SKILL.md.
- A tiny `observing.md` addition: an atomic-write pattern for cached
  node lists, and the warning that `head` is a shell builtin-looking
  name people will shadow (I did).

## Numbers, for calibration

- Typical `fault run` overhead beyond the hold: 0.5-4 s (fan-out kill of
  3 producers: 3.4 s from `started_at` to `applied_at`).
- `doctor` / `cluster nodes` on a 76-container enclave: ~3-5 s each,
  dominated by attaching to exited containers (see item 1).
- All 30 records: `list --done` and `cleanup --all` instantaneous.
