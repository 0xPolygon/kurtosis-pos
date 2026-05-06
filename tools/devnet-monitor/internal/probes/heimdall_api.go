package probes

import (
	"context"
	"log/slog"
	"time"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/chain"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/discover"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probe"
)

// pollHeimdallCounter is the shared poll loop for spans / milestones / checkpoints.
// Each one reads a single counter from a Heimdall REST endpoint and waits for
// it to advance by `delta` past its startup value.
func pollHeimdallCounter(
	ctx context.Context,
	dn discover.Devnet,
	lg *slog.Logger,
	timeout time.Duration,
	probeName, minKey string,
	delta int,
	read func(context.Context, *chain.Heimdall) (uint64, error),
) probe.Result {
	start := time.Now()
	res := probe.Result{Probe: probeName, Target: dn.Target(), MinKey: minKey, MinValue: delta}

	api, err := dn.L2CLAPI()
	if err != nil {
		lg.Error("Resolve REST API failed", "err", err)
		return res
	}
	h := chain.DialHeimdall(api.URL)

	baseline, err := read(ctx, h)
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
		v, _ := read(ctx, h)
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
