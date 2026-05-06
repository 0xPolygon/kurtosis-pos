package probes

import (
	"context"
	"log/slog"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/chain"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/discover"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probe"
)

// Milestones monitors heimdall milestone production.
type Milestones struct{}

func (Milestones) Name() string { return "milestones" }

func (Milestones) Run(ctx context.Context, dn discover.Devnet, opts probe.Options, lg *slog.Logger) probe.Result {
	return pollHeimdallCounter(ctx, dn, lg, opts.Timeout, "milestones", "min_milestones", opts.MinMilestones, func(ctx context.Context, h *chain.Heimdall) (uint64, error) {
		return h.MilestoneCount(ctx)
	})
}
