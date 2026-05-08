package probes

import (
	"context"
	"log/slog"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/chain"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/discover"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probeapi"
)

// Spans monitors bor span rotation.
type Spans struct{}

func (Spans) Name() string { return "spans" }

func (Spans) Run(ctx context.Context, dn discover.Devnet, opts probeapi.Options, lg *slog.Logger) probeapi.Result {
	return pollHeimdallCounter(ctx, dn, lg, opts.Timeout, "spans", "min_spans", opts.MinSpans, func(ctx context.Context, h *chain.Heimdall) (uint64, error) {
		return h.LatestSpanID(ctx)
	})
}
