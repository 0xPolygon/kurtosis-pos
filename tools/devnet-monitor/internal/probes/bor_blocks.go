// Package probes contains the five health-check probes.
package probes

import (
	"context"
	"errors"
	"log/slog"
	"strings"
	"sync"
	"time"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/chain"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/discover"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probeapi"
)

// Bor monitors block progress on every Bor RPC. Sends a stimulus tx every
// poll cycle from the first validator to keep an idle chain advancing.
type Bor struct{}

func (Bor) Name() string { return "bor" }

func (Bor) Run(ctx context.Context, dn discover.Devnet, opts probeapi.Options, lg *slog.Logger) probeapi.Result {
	start := time.Now()
	res := probeapi.Result{Probe: "bor", MinKey: "min_blocks", MinValue: opts.MinBlocks}

	rpcs, err := dn.L2ELServices()
	if err != nil {
		lg.Error("List EL services failed", "err", err)
		return res
	}
	if len(rpcs) == 0 {
		lg.Error("No running l2-el services found")
		return res
	}

	// Pick the first validator (sorted) as the sole tx sender.
	sender := ""
	for _, s := range rpcs {
		if strings.HasSuffix(s.Name, "-validator") {
			sender = s.Name
			break
		}
	}
	if sender == "" {
		lg.Error("No validator EL service found")
		return res
	}
	lg.Debug("Send transactions to stimulate activity", "node", sender)

	ctx, cancel := context.WithTimeout(ctx, opts.Timeout)
	defer cancel()

	var (
		wg     sync.WaitGroup
		mu     sync.Mutex
		failed []string
	)
	for _, s := range rpcs {
		wg.Add(1)
		go func(svc discover.Service) {
			defer wg.Done()
			if !monitorBor(ctx, svc, svc.Name == sender, opts.MinBlocks, lg) {
				mu.Lock()
				failed = append(failed, svc.Name)
				mu.Unlock()
			}
		}(s)
	}
	wg.Wait()

	res.Checked = len(rpcs)
	res.Failed = len(failed)
	res.OK = res.Checked - res.Failed
	res.FailedNodes = failed
	res.Duration = time.Since(start)
	return res
}

// monitorBor runs the per-RPC poll loop. Returns true on success.
//
// Transient read errors don't fail the probe — we log and keep polling. Only
// the timeout (set on ctx by the caller) ends the loop. The failure log
// reports the last good observation rather than a post-cancel zero.
func monitorBor(ctx context.Context, svc discover.Service, stimulate bool, minBlocks int, lg *slog.Logger) bool {
	bor, err := chain.DialBor(ctx, svc.URL)
	if err != nil {
		lg.Error("Dial failed", "node", svc.Name, "err", err)
		return false
	}
	defer bor.Close()

	latestBaseline, latestErr := bor.LatestBlock(ctx)
	finalizedBaseline, finalizedErr := bor.FinalizedBlock(ctx)
	if latestErr != nil || finalizedErr != nil {
		lg.Error("Read baseline failed",
			"node", svc.Name,
			"latest_err", latestErr,
			"finalized_err", finalizedErr,
		)
		return false
	}
	latestRequired := latestBaseline + uint64(minBlocks)
	finalizedRequired := finalizedBaseline + uint64(minBlocks)
	lg.Debug("Capture baseline",
		"node", svc.Name,
		"latest", latestBaseline,
		"finalized", finalizedBaseline,
	)

	gasPriceFactor := 1.0
	var (
		lastLoggedLatest, lastLoggedFinalized uint64 = ^uint64(0), ^uint64(0)
		lastLatest                                   = latestBaseline
		lastFinalized                                = finalizedBaseline
	)

	tick := time.NewTicker(pollInterval)
	defer tick.Stop()

	// Drive the first iteration immediately rather than waiting for the
	// first tick.
	for {
		latest, latestErr := bor.LatestBlock(ctx)
		finalized, finalizedErr := bor.FinalizedBlock(ctx)
		if latestErr != nil || finalizedErr != nil {
			if !isCtxErr(latestErr) && !isCtxErr(finalizedErr) {
				lg.Warn("Poll read failed",
					"node", svc.Name,
					"latest_err", latestErr,
					"finalized_err", finalizedErr,
				)
			}
		} else {
			lastLatest, lastFinalized = latest, finalized
			if latest != lastLoggedLatest || finalized != lastLoggedFinalized {
				lg.Debug("Poll status",
					"node", svc.Name,
					"latest", latest,
					"finalized", finalized,
				)
				lastLoggedLatest, lastLoggedFinalized = latest, finalized
			}
			if latest >= latestRequired && finalized >= finalizedRequired {
				return true
			}
		}

		if stimulate {
			if err := bor.SendStimulusTx(ctx, gasPriceFactor); err != nil && !isCtxErr(err) {
				lg.Warn("Stimulus tx failed", "node", svc.Name, "err", err, "gas_factor", gasPriceFactor)
				gasPriceFactor *= 1.5
			} else if err == nil {
				gasPriceFactor = 1.0
			}
		}

		select {
		case <-ctx.Done():
			// Use the last successful read in the failure log so it reflects
			// the chain's actual state, not a post-cancel zero.
			lg.Error("Did not reach required heights",
				"node", svc.Name,
				"latest", lastLatest,
				"latest_required", latestRequired,
				"finalized", lastFinalized,
				"finalized_required", finalizedRequired,
			)
			return false
		case <-tick.C:
		}
	}
}

// isCtxErr reports whether err is the canonical context cancellation /
// deadline error. Used to suppress noisy log spam from reads that race the
// shutdown of the surrounding context.
func isCtxErr(err error) bool {
	return errors.Is(err, context.Canceled) || errors.Is(err, context.DeadlineExceeded)
}
