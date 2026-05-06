package probes

import (
	"context"
	"log/slog"
	"sync"
	"time"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/chain"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/discover"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probeapi"
)

// Heimdall monitors block progress on every Heimdall CometBFT RPC. Observe-only.
type Heimdall struct{}

func (Heimdall) Name() string { return "heimdall" }

func (Heimdall) Run(ctx context.Context, dn discover.Devnet, opts probeapi.Options, lg *slog.Logger) probeapi.Result {
	start := time.Now()
	res := probeapi.Result{Probe: "heimdall", MinKey: "min_blocks", MinValue: opts.MinBlocks}

	cls, err := dn.L2CLServices()
	if err != nil {
		lg.Error("List CL services failed", "err", err)
		return res
	}
	if len(cls) == 0 {
		lg.Error("No running l2-cl services found")
		return res
	}

	ctx, cancel := context.WithTimeout(ctx, opts.Timeout)
	defer cancel()

	var (
		wg     sync.WaitGroup
		mu     sync.Mutex
		failed []string
	)
	for _, s := range cls {
		wg.Add(1)
		go func(svc discover.Service) {
			defer wg.Done()
			if !monitorHeimdall(ctx, svc, opts.MinBlocks, lg) {
				mu.Lock()
				failed = append(failed, svc.Name)
				mu.Unlock()
			}
		}(s)
	}
	wg.Wait()

	res.Checked = len(cls)
	res.Failed = len(failed)
	res.OK = res.Checked - res.Failed
	res.FailedNodes = failed
	res.Duration = time.Since(start)
	return res
}

// monitorHeimdall runs the per-CL poll loop. Returns true on success.
//
// Transient read errors don't fail the probe — we log and keep polling. Only
// the timeout (set on ctx by the caller) ends the loop. The failure log
// reports the last good observation rather than a post-cancel zero.
func monitorHeimdall(ctx context.Context, svc discover.Service, minBlocks int, lg *slog.Logger) bool {
	h := chain.DialHeimdall(svc.URL)

	baseline, err := h.Height(ctx)
	if err != nil {
		lg.Error("Read baseline failed", "node", svc.Name, "err", err)
		return false
	}
	required := baseline + uint64(minBlocks)
	lg.Debug("Capture baseline", "node", svc.Name, "latest", baseline)

	var (
		lastLogged uint64 = ^uint64(0)
		lastValid         = baseline
	)
	tick := time.NewTicker(pollInterval)
	defer tick.Stop()

	for {
		latest, err := h.Height(ctx)
		if err != nil {
			if !isCtxErr(err) {
				lg.Warn("Poll read failed", "node", svc.Name, "err", err)
			}
		} else {
			lastValid = latest
			if latest != lastLogged {
				lg.Debug("Poll status", "node", svc.Name, "latest", latest)
				lastLogged = latest
			}
			if latest >= required {
				return true
			}
		}
		select {
		case <-ctx.Done():
			lg.Error("Did not reach required height",
				"node", svc.Name,
				"latest", lastValid,
				"required", required,
			)
			return false
		case <-tick.C:
		}
	}
}
