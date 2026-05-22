// Package cmd wires the cobra subcommands. One file per probe subcommand,
// one for `all`, plus the root command here.
package cmd

import (
	"context"
	"fmt"
	"log/slog"
	"os"
	"time"

	"github.com/spf13/cobra"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/discover"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/log"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probeapi"
)

// Persistent flags shared across all subcommands.
var (
	flagEnclave     string
	flagComposeFile string
	flagTimeout     time.Duration
	flagFormat      string

	// Per-probe min flags (only some commands attach the relevant one).
	flagMinBlocks      int
	flagMinSpans       int
	flagMinMilestones  int
	flagMinCheckpoints int
)

// Root returns the root cobra command, wired with subcommands.
func Root() *cobra.Command {
	root := &cobra.Command{
		Use:           "devnet-monitor",
		Short:         "Health checks for Polygon PoS devnets",
		Long:          "Probes a Polygon PoS devnet (kurtosis enclave or restored docker-compose) and reports whether it is making progress.",
		SilenceUsage:  true,
		SilenceErrors: true,
		PersistentPreRun: func(_ *cobra.Command, _ []string) {
			log.Init(log.ParseFormat(flagFormat))
		},
	}

	root.PersistentFlags().StringVar(&flagEnclave, "enclave", "", "kurtosis enclave name (mutually exclusive with --compose-file)")
	root.PersistentFlags().StringVar(&flagComposeFile, "compose-file", "", "path to a docker-compose.yaml from a restored devnet")
	root.PersistentFlags().DurationVar(&flagTimeout, "timeout", 5*time.Minute, "per-probe time budget")
	root.PersistentFlags().StringVar(&flagFormat, "format", "text", "output format: text|json")

	root.AddCommand(borCmd(), heimdallCmd(), spansCmd(), milestonesCmd(), checkpointsCmd(), allCmd())
	return root
}

// resolve builds the Devnet from the persistent flags.
func resolve() (discover.Devnet, error) {
	return discover.Open(flagEnclave, flagComposeFile)
}

// runOne is the shared "run a single probe and exit appropriately" path used
// by every probe-specific subcommand.
func runOne(p probeapi.Probe, opts probeapi.Options) error {
	dn, err := resolve()
	if err != nil {
		return err
	}
	lg := slog.Default()
	lg.Info(fmt.Sprintf("Monitor %s", p.Name()),
		"target", dn.Target(),
		"timeout", opts.Timeout,
	)
	res := p.Run(context.Background(), dn, opts, lg)
	probeapi.LogResult(lg, res)
	if res.Failed > 0 {
		os.Exit(1)
	}
	return nil
}
