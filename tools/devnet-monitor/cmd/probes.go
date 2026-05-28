package cmd

import (
	"time"

	"github.com/spf13/cobra"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probeapi"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probes"
)

func borCmd() *cobra.Command {
	c := &cobra.Command{
		Use:   "bor",
		Short: "Monitor Bor (EL) block progress; sends a stimulus tx every poll",
		RunE: func(_ *cobra.Command, _ []string) error {
			return runOne(probes.Bor{}, probeapi.Options{MinBlocks: flagMinBlocks, Timeout: flagTimeout})
		},
	}
	c.Flags().IntVar(&flagMinBlocks, "min-blocks", 50, "blocks the chain must advance past baseline")
	return c
}

func heimdallCmd() *cobra.Command {
	c := &cobra.Command{
		Use:   "heimdall",
		Short: "Monitor Heimdall (CL) block progress (observe-only)",
		RunE: func(_ *cobra.Command, _ []string) error {
			return runOne(probes.Heimdall{}, probeapi.Options{MinBlocks: flagMinBlocks, Timeout: flagTimeout})
		},
	}
	c.Flags().IntVar(&flagMinBlocks, "min-blocks", 50, "blocks the chain must advance past baseline")
	return c
}

func spansCmd() *cobra.Command {
	c := &cobra.Command{
		Use:   "spans",
		Short: "Monitor bor span rotation",
		RunE: func(cmd *cobra.Command, _ []string) error {
			// One span lasts EL_SPRINT_DURATION * 8 bor blocks (~4 min at 2s
			// block time), so the shared 5-min default leaves no margin for
			// startup delay. Use a per-probe default unless --timeout was set.
			timeout := flagTimeout
			if !cmd.Flags().Changed("timeout") {
				timeout = 8 * time.Minute
			}
			return runOne(probes.Spans{}, probeapi.Options{MinSpans: flagMinSpans, Timeout: timeout})
		},
	}
	c.Flags().IntVar(&flagMinSpans, "min-spans", 1, "spans the chain must advance past baseline")
	return c
}

func milestonesCmd() *cobra.Command {
	c := &cobra.Command{
		Use:   "milestones",
		Short: "Monitor heimdall milestone production",
		RunE: func(_ *cobra.Command, _ []string) error {
			return runOne(probes.Milestones{}, probeapi.Options{MinMilestones: flagMinMilestones, Timeout: flagTimeout})
		},
	}
	c.Flags().IntVar(&flagMinMilestones, "min-milestones", 5, "milestones the chain must advance past baseline")
	return c
}

func checkpointsCmd() *cobra.Command {
	c := &cobra.Command{
		Use:   "checkpoints",
		Short: "Monitor checkpoint commitment to L1",
		RunE: func(_ *cobra.Command, _ []string) error {
			return runOne(probes.Checkpoints{}, probeapi.Options{MinCheckpoints: flagMinCheckpoints, Timeout: flagTimeout})
		},
	}
	c.Flags().IntVar(&flagMinCheckpoints, "min-checkpoints", 3, "checkpoints the chain must advance past baseline")
	return c
}
