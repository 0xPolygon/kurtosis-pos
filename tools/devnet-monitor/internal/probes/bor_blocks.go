// Package probes contains the five health-check probes.
package probes

import (
	"context"
	"errors"
	"fmt"
	"log/slog"
	"os"
	"path/filepath"
	"strings"
	"sync"
	"time"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/chain"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/discover"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probeapi"
)

// Bor monitors block progress on every Bor RPC. Sends a stimulus tx from the
// first validator every stimulusInterval to keep an idle chain advancing.
// Polling cadence (pollInterval) is decoupled from writing cadence so the
// probe detects chain progress quickly without flooding the mempool.
type Bor struct{}

// stimulusInterval is how often the bor probe injects a stimulus tx from the
// validator. It's intentionally slower than pollInterval so a fast poll loop
// doesn't generate one tx per second.
var stimulusInterval = 10 * time.Second

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

	// Pick the first validator (sorted) as the sole tx sender. Match
	// regardless of trailing `-archive` suffix added by `el_bor_archive_mode:
	// true` (the new default).
	sender := ""
	for _, s := range rpcs {
		if strings.Contains(s.Name, "-validator") {
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

	// targetLatch records the wall-clock at the first cross-RPC observation of
	// latest >= opts.TargetBlock. nil when no target is set.
	var targetLatch *targetBlockLatch
	if opts.TargetBlock > 0 {
		targetLatch = newTargetBlockLatch(opts.TargetBlock, opts.EmitTimingPath, start, lg)
	}

	var (
		wg     sync.WaitGroup
		mu     sync.Mutex
		failed []string
	)
	for _, s := range rpcs {
		wg.Add(1)
		go func(svc discover.Service) {
			defer wg.Done()
			if !monitorBor(ctx, svc, svc.Name == sender, opts.MinBlocks, targetLatch, lg) {
				mu.Lock()
				failed = append(failed, svc.Name)
				mu.Unlock()
			}
		}(s)
	}
	wg.Wait()
	if targetLatch != nil && !targetLatch.fired() {
		lg.Warn("Target block not reached before probe exit",
			"target_block", opts.TargetBlock,
		)
	}

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
//
// targetLatch may be nil; when set, monitorBor reports every successful
// `latest` read to it so the first goroutine to cross the threshold records
// the timing.
func monitorBor(ctx context.Context, svc discover.Service, stimulate bool, minBlocks int, targetLatch *targetBlockLatch, lg *slog.Logger) bool {
	bor, err := chain.DialBor(ctx, svc.URL)
	if err != nil {
		lg.Error("Dial failed", "node", svc.Name, "err", err)
		return false
	}
	defer bor.Close()

	// Retry the baseline pair on transient errors so a node that's still
	// warming up (e.g. erigon mid-restart after a snapshot restore) gets the
	// same grace as the poll loop below. The probe shares a single timeout
	// across baseline + poll loop — if neither read ever succeeds, ctx will
	// fire and we fail.
	var latestBaseline, finalizedBaseline uint64
	if _, err = readWithRetry(ctx, lg, "baseline:"+svc.Name,
		func(c context.Context) (uint64, error) {
			var latestErr, finalizedErr error
			latestBaseline, latestErr = bor.LatestBlock(c)
			finalizedBaseline, finalizedErr = bor.FinalizedBlock(c)
			if latestErr != nil {
				return 0, latestErr
			}
			return 0, finalizedErr
		}); err != nil {
		lg.Error("Read baseline failed", "node", svc.Name, "err", err)
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
		// Send the first stimulus tx immediately, then every stimulusInterval.
		// `time.Time{}` (zero value) is in the distant past, so the first
		// `time.Since(...) >= stimulusInterval` check will pass.
		lastStimulusAt time.Time
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
			if targetLatch != nil {
				targetLatch.observe(svc.Name, latest)
			}
			if latest >= latestRequired && finalized >= finalizedRequired {
				return true
			}
		}

		if stimulate && time.Since(lastStimulusAt) >= stimulusInterval {
			lastStimulusAt = time.Now()
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

// targetBlockLatch records, once across all RPC goroutines, the wall-clock
// at which `latest >= target` is first observed. The first goroutine to
// observe wins; subsequent observations are no-ops.
//
// When emitPath is non-empty, the latch writes a single-line JSON record on
// fire. Errors at write time are logged but do not fail the probe — the
// timing is a metric, not a correctness signal.
type targetBlockLatch struct {
	target   uint64
	emitPath string
	start    time.Time
	lg       *slog.Logger

	once      sync.Once
	firedFlag bool
	mu        sync.Mutex
}

func newTargetBlockLatch(target uint64, emitPath string, start time.Time, lg *slog.Logger) *targetBlockLatch {
	return &targetBlockLatch{target: target, emitPath: emitPath, start: start, lg: lg}
}

func (l *targetBlockLatch) observe(node string, latest uint64) {
	if latest < l.target {
		return
	}
	l.once.Do(func() {
		ts := time.Now()
		elapsed := ts.Sub(l.start)
		l.lg.Info("Target block reached",
			"node", node,
			"target_block", l.target,
			"observed_block", latest,
			"elapsed_seconds", elapsed.Seconds(),
		)
		l.mu.Lock()
		l.firedFlag = true
		l.mu.Unlock()
		if l.emitPath == "" {
			return
		}
		if err := writeTargetTiming(l.emitPath, node, l.target, latest, l.start, ts); err != nil {
			l.lg.Warn("Emit target-block timing failed",
				"path", l.emitPath,
				"err", err,
			)
		}
	})
}

func (l *targetBlockLatch) fired() bool {
	l.mu.Lock()
	defer l.mu.Unlock()
	return l.firedFlag
}

// writeTargetTiming serialises the timing record to emitPath. Format matches
// scripts/perf/measure.sh's JSONL schema so aggregate.sh can ingest it
// without special-casing.
func writeTargetTiming(emitPath, node string, target, observed uint64, start, ts time.Time) error {
	if dir := filepath.Dir(emitPath); dir != "" && dir != "." {
		if err := os.MkdirAll(dir, 0o755); err != nil {
			return fmt.Errorf("mkdir %s: %w", dir, err)
		}
	}
	f, err := os.OpenFile(emitPath, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0o644)
	if err != nil {
		return fmt.Errorf("open %s: %w", emitPath, err)
	}
	defer f.Close()
	// Duration in seconds with millisecond precision. RFC3339 timestamps.
	durationS := float64(ts.Sub(start).Milliseconds()) / 1000.0
	line := fmt.Sprintf(
		`{"phase":"time-to-block","started_at":"%s","ended_at":"%s","duration_s":%.3f,"extras":{"target_block":%d,"observed_block":%d,"node":%q}}`+"\n",
		start.UTC().Format(time.RFC3339), ts.UTC().Format(time.RFC3339), durationS, target, observed, node,
	)
	if _, err := f.WriteString(line); err != nil {
		return fmt.Errorf("write: %w", err)
	}
	return nil
}
