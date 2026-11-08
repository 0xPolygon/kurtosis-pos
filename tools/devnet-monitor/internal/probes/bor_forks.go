package probes

import (
	"context"
	"log/slog"
	"time"

	"github.com/ethereum/go-ethereum/common"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/chain"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/discover"
)

// forkCheckMargin keeps the compared block one sprint behind the slowest
// node's head, so a short reorg at the tip isn't reported as a fork.
const forkCheckMargin = 16

// forkCheckTimeout bounds how long nodes may disagree before the check fails.
// A real fork never heals, while a tip reorg settles within a few blocks.
var forkCheckTimeout = 30 * time.Second

// borHashReader is the subset of chain.Bor the fork check needs.
type borHashReader interface {
	LatestBlock(ctx context.Context) (uint64, error)
	BlockHash(ctx context.Context, number uint64) (common.Hash, error)
}

type borNode struct {
	name   string
	reader borHashReader
}

// checkBorForks dials every Bor RPC and verifies they agree on the block hash
// at the slowest node's head minus forkCheckMargin. Bor forks are permanent,
// so a single comparison covers every height below it. Returns true when the
// nodes agree or when there are fewer than two of them.
func checkBorForks(ctx context.Context, rpcs []discover.Service, stage string, lg *slog.Logger) bool {
	if len(rpcs) < 2 {
		return true
	}
	nodes := make([]borNode, 0, len(rpcs))
	for _, s := range rpcs {
		bor, err := chain.DialBor(ctx, s.URL)
		if err != nil {
			lg.Error("Dial failed", "node", s.Name, "err", err)
			return false
		}
		defer bor.Close()
		nodes = append(nodes, borNode{name: s.Name, reader: bor})
	}
	return compareBorHashes(ctx, nodes, stage, lg)
}

// compareBorHashes polls until every node reports the same hash at the common
// height, or fails once forkCheckTimeout elapses.
func compareBorHashes(ctx context.Context, nodes []borNode, stage string, lg *slog.Logger) bool {
	ctx, cancel := context.WithTimeout(ctx, forkCheckTimeout)
	defer cancel()

	tick := time.NewTicker(pollInterval)
	defer tick.Stop()

	var (
		lastBlock  uint64
		lastHashes []any
	)
	for {
		block, hashes, agree, err := readBorHashes(ctx, nodes)
		switch {
		case err != nil:
			if !isCtxErr(err) {
				lg.Warn("Fork check read failed", "stage", stage, "err", err)
			}
		case agree:
			lg.Debug("No bor fork", "stage", stage, "block", block, "nodes", len(nodes))
			return true
		default:
			lastBlock, lastHashes = block, hashes
			lg.Warn("Bor nodes disagree, retrying", append([]any{"stage", stage, "block", block}, hashes...)...)
		}

		select {
		case <-ctx.Done():
			if lastHashes == nil {
				lg.Error("Fork check could not read every node", "stage", stage)
				return false
			}
			lg.Error("Bor fork detected", append([]any{"stage", stage, "block", lastBlock}, lastHashes...)...)
			return false
		case <-tick.C:
		}
	}
}

// readBorHashes reads every node's hash at min(head) - forkCheckMargin and
// returns them as alternating name/hash log attributes.
func readBorHashes(ctx context.Context, nodes []borNode) (uint64, []any, bool, error) {
	minHead := ^uint64(0)
	for _, n := range nodes {
		head, err := n.reader.LatestBlock(ctx)
		if err != nil {
			return 0, nil, false, err
		}
		minHead = min(minHead, head)
	}
	var block uint64
	if minHead > forkCheckMargin {
		block = minHead - forkCheckMargin
	}

	var (
		first  common.Hash
		agree  = true
		hashes = make([]any, 0, 2*len(nodes))
	)
	for i, n := range nodes {
		hash, err := n.reader.BlockHash(ctx, block)
		if err != nil {
			return 0, nil, false, err
		}
		if i == 0 {
			first = hash
		} else if hash != first {
			agree = false
		}
		hashes = append(hashes, n.name, hash.Hex())
	}
	return block, hashes, agree, nil
}
