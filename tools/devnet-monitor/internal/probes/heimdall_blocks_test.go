package probes

import (
	"context"
	"fmt"
	"net/http"
	"net/http/httptest"
	"sync/atomic"
	"testing"
	"time"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/discover"
)

// fakeCometBFT serves /status with a sequence of latest_block_height responses.
// Same scripting model as fakeHeimdall but for the CometBFT JSON-RPC shape.
type fakeCometBFT struct {
	calls  atomic.Int64
	script []cometStep
}
type cometStep struct {
	ok     bool
	height uint64
}

func (f *fakeCometBFT) handler() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		idx := int(f.calls.Add(1) - 1)
		if idx >= len(f.script) {
			idx = len(f.script) - 1
		}
		step := f.script[idx]
		if !step.ok {
			http.Error(w, "boom", http.StatusServiceUnavailable)
			return
		}
		fmt.Fprintf(w, `{"result":{"sync_info":{"latest_block_height":"%d"}}}`, step.height)
	})
}

func runHeimdallBlocksProbe(t *testing.T, script []cometStep, minBlocks int, timeout time.Duration) (bool, *fakeCometBFT) {
	t.Helper()
	fh := &fakeCometBFT{script: script}
	srv := httptest.NewServer(fh.handler())
	t.Cleanup(srv.Close)

	old := pollInterval
	pollInterval = 50 * time.Millisecond
	t.Cleanup(func() { pollInterval = old })

	ctx, cancel := context.WithTimeout(context.Background(), timeout)
	defer cancel()

	ok := monitorHeimdall(ctx, discover.Service{Name: "stub-cl", URL: srv.URL}, minBlocks, silentLogger())
	return ok, fh
}

// TestMonitorHeimdall_Success: height advances past required → success.
func TestMonitorHeimdall_Success(t *testing.T) {
	script := []cometStep{
		{ok: true, height: 100}, // baseline
		{ok: true, height: 100}, // no advance
		{ok: true, height: 160}, // jumped past required (100+50)
	}
	ok, _ := runHeimdallBlocksProbe(t, script, 50, 1*time.Second)
	if !ok {
		t.Fatal("expected success, got failure")
	}
}

// TestMonitorHeimdall_TransientErrors: server flakes but height advances —
// probe should not give up, should return success.
func TestMonitorHeimdall_TransientErrors(t *testing.T) {
	script := []cometStep{
		{ok: true, height: 10}, // baseline
		{ok: false},            // 503
		{ok: true, height: 12}, // small advance
		{ok: false},            // 503
		{ok: true, height: 80}, // huge advance, past 10+50=60
	}
	ok, _ := runHeimdallBlocksProbe(t, script, 50, 2*time.Second)
	if !ok {
		t.Fatal("expected success despite transient errors, got failure")
	}
}

// TestMonitorHeimdall_BaselineRetried: baseline read errors initially but
// recovers within the timeout — probe should succeed.
func TestMonitorHeimdall_BaselineRetried(t *testing.T) {
	script := []cometStep{
		{ok: false},             // baseline attempt 1: 503
		{ok: false},             // baseline attempt 2: 503
		{ok: true, height: 100}, // baseline attempt 3: OK
		{ok: true, height: 160}, // poll: past 100+50
	}
	ok, _ := runHeimdallBlocksProbe(t, script, 50, 2*time.Second)
	if !ok {
		t.Fatal("expected success after baseline retry, got failure")
	}
}

// TestMonitorHeimdall_StallFails: height never advances → fail.
func TestMonitorHeimdall_StallFails(t *testing.T) {
	script := []cometStep{
		{ok: true, height: 5},
		{ok: true, height: 5},
	}
	ok, fh := runHeimdallBlocksProbe(t, script, 10, 500*time.Millisecond)
	if ok {
		t.Fatal("expected failure on stalled chain, got success")
	}
	if fh.calls.Load() < 2 {
		t.Fatalf("expected ≥2 calls, got %d", fh.calls.Load())
	}
}
