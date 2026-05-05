package probes

import (
	"context"
	"log/slog"
	"time"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/chain"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/discover"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probe"
)

// Spans, Milestones, Checkpoints all hit a single Heimdall REST endpoint and
// wait for a counter to advance past `baseline + delta`. We share the loop.

// Spans monitors bor span rotation.
type Spans struct{}

func (Spans) Name() string { return "spans" }
func (Spans) Run(ctx context.Context, dn discover.Devnet, opts probe.Options, lg *slog.Logger) probe.Result {
	return runRESTCounter(ctx, dn, lg, opts.Timeout, "spans", "min_spans", opts.MinSpans, func(ctx context.Context, cl *chain.CL) (uint64, error) {
		return cl.LatestSpanID(ctx)
	})
}

// Milestones monitors heimdall milestone production.
type Milestones struct{}

func (Milestones) Name() string { return "milestones" }
func (Milestones) Run(ctx context.Context, dn discover.Devnet, opts probe.Options, lg *slog.Logger) probe.Result {
	return runRESTCounter(ctx, dn, lg, opts.Timeout, "milestones", "min_milestones", opts.MinMilestones, func(ctx context.Context, cl *chain.CL) (uint64, error) {
		return cl.MilestoneCount(ctx)
	})
}

// Checkpoints monitors checkpoint commitment to L1.
type Checkpoints struct{}

func (Checkpoints) Name() string { return "checkpoints" }
func (Checkpoints) Run(ctx context.Context, dn discover.Devnet, opts probe.Options, lg *slog.Logger) probe.Result {
	return runRESTCounter(ctx, dn, lg, opts.Timeout, "checkpoints", "min_checkpoints", opts.MinCheckpoints, func(ctx context.Context, cl *chain.CL) (uint64, error) {
		return cl.CheckpointAckCount(ctx)
	})
}

// runRESTCounter is the shared poll loop for spans / milestones / checkpoints.
// Each one reads a single counter from the heimdall REST API and waits for it
// to advance by `delta` past its startup value.
func runRESTCounter(
	ctx context.Context,
	dn discover.Devnet,
	lg *slog.Logger,
	timeout time.Duration,
	probeName, minKey string,
	delta int,
	read func(context.Context, *chain.CL) (uint64, error),
) probe.Result {
	start := time.Now()
	res := probe.Result{Probe: probeName, Target: dn.Target(), MinKey: minKey, MinValue: delta}

	api, err := dn.L2CLAPI()
	if err != nil {
		lg.Error("Resolve REST API failed", "err", err)
		return res
	}
	cl := chain.DialCL(api.URL)

	baseline, err := read(ctx, cl)
	if err != nil {
		lg.Error("Read baseline failed", "err", err)
		res.Failed = 1
		res.Checked = 1
		res.Duration = time.Since(start)
		return res
	}
	required := baseline + uint64(delta)
	lg.Debug("Capture baseline", "value", baseline)

	ctx, cancel := context.WithTimeout(ctx, timeout)
	defer cancel()

	var last uint64 = ^uint64(0)
	tick := time.NewTicker(pollInterval)
	defer tick.Stop()

	for {
		v, _ := read(ctx, cl)
		if v != last {
			lg.Debug("Poll status", "value", v)
			last = v
		}
		if v >= required {
			res.Checked = 1
			res.OK = 1
			res.Duration = time.Since(start)
			return res
		}
		select {
		case <-ctx.Done():
			lg.Error("Did not reach required value",
				"value", v,
				"required", required,
			)
			res.Checked = 1
			res.Failed = 1
			res.FailedNodes = []string{api.Name}
			res.Duration = time.Since(start)
			return res
		case <-tick.C:
		}
	}
}
