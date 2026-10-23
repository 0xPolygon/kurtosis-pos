package probes

import (
	"context"
	"errors"
	"sync/atomic"
	"testing"
	"time"

	"github.com/ethereum/go-ethereum/common"
)

// fakeBor serves a fixed head and derives each block hash from its chain id,
// so two nodes with different ids look like two forks.
type fakeBor struct {
	head    uint64
	chainID byte
	// healAfter switches chainID to 0 after that many BlockHash calls,
	// simulating a tip reorg that settles. Zero disables it.
	healAfter int64
	failFirst int64
	calls     atomic.Int64
	asked     atomic.Uint64
}

func (f *fakeBor) LatestBlock(context.Context) (uint64, error) { return f.head, nil }

func (f *fakeBor) BlockHash(_ context.Context, n uint64) (common.Hash, error) {
	call := f.calls.Add(1)
	f.asked.Store(n)
	if call <= f.failFirst {
		return common.Hash{}, errors.New("boom")
	}
	id := f.chainID
	if f.healAfter > 0 && call > f.healAfter {
		id = 0
	}
	return common.BytesToHash([]byte{id, byte(n)}), nil
}

func runForkCheck(t *testing.T, readers ...*fakeBor) bool {
	t.Helper()
	oldPoll, oldTimeout := pollInterval, forkCheckTimeout
	pollInterval, forkCheckTimeout = 10*time.Millisecond, 200*time.Millisecond
	t.Cleanup(func() { pollInterval, forkCheckTimeout = oldPoll, oldTimeout })

	nodes := make([]borNode, len(readers))
	for i, r := range readers {
		nodes[i] = borNode{name: string(rune('a' + i)), reader: r}
	}
	return compareBorHashes(context.Background(), nodes, "test", silentLogger())
}

// TestCompareBorHashes_Agree: same chain, comparison one sprint below the
// slowest head.
func TestCompareBorHashes_Agree(t *testing.T) {
	a, b := &fakeBor{head: 80}, &fakeBor{head: 60}
	if !runForkCheck(t, a, b) {
		t.Fatal("expected agreement")
	}
	if got := b.asked.Load(); got != 60-forkCheckMargin {
		t.Fatalf("compared block %d, want %d", got, 60-forkCheckMargin)
	}
}

// TestCompareBorHashes_Fork: diverged chains never agree → failure.
func TestCompareBorHashes_Fork(t *testing.T) {
	if runForkCheck(t, &fakeBor{head: 127, chainID: 1}, &fakeBor{head: 255, chainID: 2}) {
		t.Fatal("expected fork detection")
	}
}

// TestCompareBorHashes_TransientDisagreement: a reorg that settles is not a fork.
func TestCompareBorHashes_TransientDisagreement(t *testing.T) {
	if !runForkCheck(t, &fakeBor{head: 60}, &fakeBor{head: 60, chainID: 2, healAfter: 3}) {
		t.Fatal("expected agreement once the reorg settles")
	}
}

// TestCompareBorHashes_TransientError: read errors are retried.
func TestCompareBorHashes_TransientError(t *testing.T) {
	if !runForkCheck(t, &fakeBor{head: 60, failFirst: 2}, &fakeBor{head: 60}) {
		t.Fatal("expected agreement after retries")
	}
}

// TestCompareBorHashes_YoungChain: heads below the margin compare genesis.
func TestCompareBorHashes_YoungChain(t *testing.T) {
	b := &fakeBor{head: 10}
	if !runForkCheck(t, &fakeBor{head: 12}, b) {
		t.Fatal("expected agreement on genesis")
	}
	if got := b.asked.Load(); got != 0 {
		t.Fatalf("compared block %d, want 0", got)
	}
}
