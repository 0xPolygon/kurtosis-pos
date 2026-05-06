package probes

import (
	"context"
	"log/slog"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/chain"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/discover"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probe"
)

// Checkpoints monitors checkpoint commitment to L1.
type Checkpoints struct{}

func (Checkpoints) Name() string { return "checkpoints" }

func (Checkpoints) Run(ctx context.Context, dn discover.Devnet, opts probe.Options, lg *slog.Logger) probe.Result {
	return pollHeimdallCounter(ctx, dn, lg, opts.Timeout, "checkpoints", "min_checkpoints", opts.MinCheckpoints, func(ctx context.Context, h *chain.Heimdall) (uint64, error) {
		return h.CheckpointAckCount(ctx)
	})
}
