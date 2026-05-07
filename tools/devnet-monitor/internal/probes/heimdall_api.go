package probes

import (
	"context"
	"errors"
	"log/slog"
	"time"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/chain"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/discover"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probeapi"
)

// pollInterval is the cadence every probe uses to recheck the chain. Shared
// across bor / heimdall / spans / milestones / checkpoints. Declared as a
// var (not const) so tests can shrink it; production code never overrides.
//
// The bor probe also sends a stimulus tx, but on its own slower clock
// (stimulusInterval) — see bor_blocks.go. Polling and writing are decoupled
// so the monitor reacts to chain progress within ~1s without flooding the
// mempool with stimulus txs.
var pollInterval = 1 * time.Second

// pollHeimdallCounter is the shared poll loop for spans / milestones / checkpoints.
// Each one reads a single counter from a Heimdall REST endpoint and waits for
// it to advance by `delta` past its startup value.
//
// Transient read errors don't fail the probe — we log and keep polling. The
// budget is the timeout: if the counter hasn't advanced enough by then, fail
// with the last good observation. If we never got *any* good read, fail with
// the most recent error so the log explains why.
func pollHeimdallCounter(
	ctx context.Context,
	dn discover.Devnet,
	lg *slog.Logger,
	timeout time.Duration,
	probeName, minKey string,
	delta int,
	read func(context.Context, *chain.Heimdall) (uint64, error),
) probeapi.Result {
	start := time.Now()
	res := probeapi.Result{Probe: probeName, MinKey: minKey, MinValue: delta}

	api, err := dn.L2CLAPI()
	if err != nil {
		lg.Error("Resolve REST API failed", "err", err)
		return res
	}
	h := chain.DialHeimdall(api.URL)

	// Budget the whole probe (baseline + poll loop) so transient errors at
	// startup don't immediately fail us — we retry the baseline read until
	// it succeeds or the timeout expires.
	ctx, cancel := context.WithTimeout(ctx, timeout)
	defer cancel()

	baseline, err := readWithRetry(ctx, lg, "baseline", read, h)
	if err != nil {
		lg.Error("Read baseline failed", "err", err)
		res.Failed = 1
		res.Checked = 1
		res.FailedNodes = []string{api.Name}
		res.Duration = time.Since(start)
		return res
	}
	required := baseline + uint64(delta)
	lg.Debug("Capture baseline", "value", baseline)

	var (
		lastLogged uint64 = ^uint64(0)
		lastValid         = baseline // last successful read; seeded from baseline above
	)

	tick := time.NewTicker(pollInterval)
	defer tick.Stop()

	for {
		v, err := read(ctx, h)
		if err != nil {
			// Don't fail on transient errors — keep polling within budget.
			// Skip log spam if the context is already cancelled (we're
			// about to break out anyway).
			if !errors.Is(err, context.Canceled) && !errors.Is(err, context.DeadlineExceeded) {
				lg.Warn("Poll read failed", "err", err)
			}
		} else {
			lastValid = v
			if v != lastLogged {
				lg.Debug("Poll status", "value", v)
				lastLogged = v
			}
			if v >= required {
				res.Checked = 1
				res.OK = 1
				res.Duration = time.Since(start)
				return res
			}
		}

		select {
		case <-ctx.Done():
			// Use the last successful read in the failure log, not a
			// post-cancel zero from the read above. lastValid is always
			// valid here — readWithRetry above guarantees a successful
			// baseline before we enter the loop.
			lg.Error("Did not reach required value", "required", required, "value", lastValid)
			res.Checked = 1
			res.Failed = 1
			res.FailedNodes = []string{api.Name}
			res.Duration = time.Since(start)
			return res
		case <-tick.C:
		}
	}
}

// readWithRetry retries the read on transient errors until it succeeds or ctx
// expires. Uses the same pollInterval cadence as the main loop.
func readWithRetry(
	ctx context.Context,
	lg *slog.Logger,
	what string,
	read func(context.Context, *chain.Heimdall) (uint64, error),
	h *chain.Heimdall,
) (uint64, error) {
	tick := time.NewTicker(pollInterval)
	defer tick.Stop()
	var lastErr error
	for {
		v, err := read(ctx, h)
		if err == nil {
			return v, nil
		}
		lastErr = err
		if errors.Is(err, context.Canceled) || errors.Is(err, context.DeadlineExceeded) {
			return 0, lastErr
		}
		lg.Warn("Read failed, retrying", "what", what, "err", err)
		select {
		case <-ctx.Done():
			return 0, lastErr
		case <-tick.C:
		}
	}
}
