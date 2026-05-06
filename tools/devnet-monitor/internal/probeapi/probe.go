// Package probeapi defines the Probe interface and the Result type that
// every concrete probe (in package probes) implements and returns.
package probeapi

import (
	"context"
	"log/slog"
	"time"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/discover"
)

// Options is the set of tunables passed to every probe. Probes ignore the
// fields they don't care about (e.g. spans probe ignores MinBlocks).
type Options struct {
	MinBlocks      int           // bor, heimdall
	MinSpans       int           // spans
	MinMilestones  int           // milestones
	MinCheckpoints int           // checkpoints
	Timeout        time.Duration // every probe
}

// Result is what every probe returns. Failed > 0 implies the probe failed.
//
// MinKey/MinValue carry the threshold the probe needed to hit, e.g.
// ("min_blocks", 40) for bor and heimdall. Empty key means "no threshold
// applies" (no probe currently uses this case).
type Result struct {
	Probe       string        `json:"probe"`
	Checked     int           `json:"checked"`
	OK          int           `json:"ok"`
	Failed      int           `json:"failed"`
	FailedNodes []string      `json:"failed_nodes,omitempty"`
	Duration    time.Duration `json:"duration"`
	MinKey      string        `json:"-"`
	MinValue    int           `json:"-"`
}

// Probe is one health check.
type Probe interface {
	Name() string
	Run(ctx context.Context, dn discover.Devnet, opts Options, lg *slog.Logger) Result
}

// LogResult emits the canonical result line for a probe.
func LogResult(lg *slog.Logger, r Result) {
	attrs := []any{
		"checked", r.Checked,
		"ok", r.OK,
		"failed", r.Failed,
	}
	if r.MinKey != "" {
		attrs = append(attrs, r.MinKey, r.MinValue)
	}
	attrs = append(attrs, "duration_seconds", int(r.Duration.Seconds()))
	lg.Info("Result", attrs...)
}
