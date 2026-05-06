package cmd

import (
	"context"
	"log/slog"
	"os"
	"sync"

	"github.com/spf13/cobra"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probeapi"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probes"
)

func allCmd() *cobra.Command {
	c := &cobra.Command{
		Use:   "all",
		Short: "Run every probe in parallel",
		RunE: func(_ *cobra.Command, _ []string) error {
			dn, err := resolve()
			if err != nil {
				return err
			}
			rootLogger := slog.Default()
			opts := probeapi.Options{
				MinBlocks:      flagMinBlocks,
				MinSpans:       flagMinSpans,
				MinMilestones:  flagMinMilestones,
				MinCheckpoints: flagMinCheckpoints,
				Timeout:        flagTimeout,
			}
			rootLogger.Info("Monitor all probes",
				"target", dn.Target(),
				"timeout", opts.Timeout,
			)

			ps := []probeapi.Probe{
				probes.Bor{},
				probes.Heimdall{},
				probes.Spans{},
				probes.Milestones{},
				probes.Checkpoints{},
			}

			var (
				wg      sync.WaitGroup
				mu      sync.Mutex
				results = make(map[string]probeapi.Result)
			)
			for _, p := range ps {
				wg.Add(1)
				go func(p probeapi.Probe) {
					defer wg.Done()
					lg := rootLogger.With("probe", p.Name())
					r := p.Run(context.Background(), dn, opts, lg)
					probeapi.LogResult(lg, r)
					mu.Lock()
					results[p.Name()] = r
					mu.Unlock()
				}(p)
			}
			wg.Wait()

			anyFailed := false
			for _, r := range results {
				if r.Failed > 0 {
					anyFailed = true
					break
				}
			}
			if anyFailed {
				os.Exit(1)
			}
			return nil
		},
	}
	c.Flags().IntVar(&flagMinBlocks, "min-blocks", 50, "for bor & heimdall")
	c.Flags().IntVar(&flagMinSpans, "min-spans", 1, "for spans")
	c.Flags().IntVar(&flagMinMilestones, "min-milestones", 5, "for milestones")
	c.Flags().IntVar(&flagMinCheckpoints, "min-checkpoints", 3, "for checkpoints")
	return c
}
