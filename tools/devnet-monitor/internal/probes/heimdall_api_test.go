package probes

import (
	"bytes"
	"context"
	"fmt"
	"io"
	"log/slog"
	"net/http"
	"net/http/httptest"
	"strings"
	"sync/atomic"
	"testing"
	"time"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/chain"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/discover"
	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/internal/probeapi"
)

// stubDevnet implements discover.Devnet and exposes a Heimdall REST API at a
// caller-provided URL. Only L2CLAPI is used by pollHeimdallCounter.
type stubDevnet struct{ url string }

func (s stubDevnet) Target() string                            { return "stub" }
func (s stubDevnet) L2ELServices() ([]discover.Service, error) { return nil, nil }
func (s stubDevnet) L2CLServices() ([]discover.Service, error) { return nil, nil }
func (s stubDevnet) L2CLAPI() (discover.Service, error) {
	return discover.Service{Name: "stub-cl", URL: s.url}, nil
}

// fakeHeimdall serves /bor/spans/latest with a sequence of responses driven
// by the script: each entry is either ("ok", id) or ("err",) which returns 503.
// Once the script is exhausted, the last entry repeats forever.
type fakeHeimdall struct {
	calls  atomic.Int64
	script []scriptStep
}
type scriptStep struct {
	ok bool
	id uint64
}

func (f *fakeHeimdall) handler() http.Handler {
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
		fmt.Fprintf(w, `{"span":{"id":"%d"}}`, step.id)
	})
}

// silentLogger returns a slog.Logger that drops everything (so test output is
// clean). Pass t.Log-backed handler for debugging.
func silentLogger() *slog.Logger {
	return slog.New(slog.NewTextHandler(io.Discard, &slog.HandlerOptions{Level: slog.LevelError}))
}

func runHeimdallProbe(t *testing.T, script []scriptStep, delta int, timeout time.Duration) (probeapi.Result, *fakeHeimdall) {
	t.Helper()
	fh := &fakeHeimdall{script: script}
	srv := httptest.NewServer(fh.handler())
	t.Cleanup(srv.Close)

	// Compress the poll cadence so tests finish in milliseconds rather than
	// minutes. Production keeps the default 10s.
	old := pollInterval
	pollInterval = 50 * time.Millisecond
	t.Cleanup(func() { pollInterval = old })

	res := pollHeimdallCounter(
		context.Background(),
		stubDevnet{url: srv.URL},
		silentLogger(),
		timeout,
		"spans", "min_spans", delta,
		func(ctx context.Context, h *chain.Heimdall) (uint64, error) {
			return h.LatestSpanID(ctx)
		},
	)
	return res, fh
}

// TestPollHeimdallCounter_Success: the counter advances past required → OK.
func TestPollHeimdallCounter_Success(t *testing.T) {
	script := []scriptStep{
		{ok: true, id: 5}, // baseline
		{ok: true, id: 5}, // first poll, no advance yet
		{ok: true, id: 7}, // second poll, advanced past required (5+1=6)
	}
	res, _ := runHeimdallProbe(t, script, 1, 1*time.Second)
	if res.OK != 1 || res.Failed != 0 {
		t.Fatalf("expected OK=1 Failed=0, got OK=%d Failed=%d", res.OK, res.Failed)
	}
}

// TestPollHeimdallCounter_TransientErrorsThenSuccess: every other read errors
// out, but the counter eventually advances. The probe must not fail on the
// transient errors — it should keep polling and return OK.
func TestPollHeimdallCounter_TransientErrorsThenSuccess(t *testing.T) {
	script := []scriptStep{
		{ok: true, id: 2},  // baseline
		{ok: false},        // first poll: server 503
		{ok: true, id: 2},  // second poll: still at baseline
		{ok: false},        // third poll: 503 again
		{ok: true, id: 99}, // fourth poll: huge jump, success
	}
	res, _ := runHeimdallProbe(t, script, 1, 2*time.Second)
	if res.OK != 1 {
		t.Fatalf("expected OK=1 (transient errors should not fail), got OK=%d Failed=%d", res.OK, res.Failed)
	}
}

// TestPollHeimdallCounter_StallReportsLastValid: counter never advances. The
// probe must fail and the failure log/result must reference the last valid
// reading (= baseline), NOT zero.
func TestPollHeimdallCounter_StallReportsLastValid(t *testing.T) {
	script := []scriptStep{
		{ok: true, id: 42}, // baseline
		{ok: true, id: 42}, // poll: still 42
		// repeats forever via fakeHeimdall's clamping
	}
	// 500ms timeout: enough for several 50ms poll cycles, fast for tests.
	res, fh := runHeimdallProbe(t, script, 1, 500*time.Millisecond)
	if res.Failed != 1 {
		t.Fatalf("expected Failed=1 on stall, got OK=%d Failed=%d", res.OK, res.Failed)
	}
	if fh.calls.Load() < 2 {
		t.Fatalf("expected ≥2 calls, got %d (probe gave up too early)", fh.calls.Load())
	}
}

// TestPollHeimdallCounter_BaselineRetried: baseline read errors initially but
// recovers within the timeout — probe must not abort early.
func TestPollHeimdallCounter_BaselineRetried(t *testing.T) {
	script := []scriptStep{
		{ok: false},       // baseline attempt 1: 503
		{ok: false},       // baseline attempt 2: 503
		{ok: true, id: 1}, // baseline attempt 3: OK (becomes baseline=1)
		{ok: true, id: 2}, // first poll: advanced past 1+1=2
	}
	res, _ := runHeimdallProbe(t, script, 1, 2*time.Second)
	if res.OK != 1 {
		t.Fatalf("expected OK=1 (baseline should be retried), got OK=%d Failed=%d", res.OK, res.Failed)
	}
}

// TestPollHeimdallCounter_WrongShapeResponses: heimdall returns a response
// missing the expected field (e.g. endpoint changed). This must surface as
// an error at the chain layer (not a silent zero), and the probe must treat
// it like any other transient error — keep polling, recover when the real
// shape comes back.
func TestPollHeimdallCounter_WrongShapeResponses(t *testing.T) {
	// Custom handler: baseline (1) returns id=10, polls 2 and 3 return wrong
	// shape, poll 4 returns id=20 (≥10+1=11, success).
	var n atomic.Int64
	srv := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch n.Add(1) {
		case 1:
			fmt.Fprint(w, `{"span":{"id":"10"}}`) // baseline
		case 2, 3:
			fmt.Fprint(w, `{"unrelated":"thing"}`) // wrong shape (transient)
		default:
			fmt.Fprint(w, `{"span":{"id":"20"}}`) // good, past required
		}
	}))
	t.Cleanup(srv.Close)

	old := pollInterval
	pollInterval = 50 * time.Millisecond
	t.Cleanup(func() { pollInterval = old })

	res := pollHeimdallCounter(
		context.Background(),
		stubDevnet{url: srv.URL},
		silentLogger(),
		2*time.Second,
		"spans", "min_spans", 1,
		func(ctx context.Context, h *chain.Heimdall) (uint64, error) {
			return h.LatestSpanID(ctx)
		},
	)
	if res.OK != 1 {
		t.Fatalf("expected OK=1 (wrong-shape responses should be transient), got %+v", res)
	}
}

// TestPollHeimdallCounter_FailureLogShowsLastValidValue is a regression test
// for the original bug: a stalled chain's failure log must report the actual
// last-good observation, not a misleading post-cancel zero.
//
// Pre-fix, `v, _ := read(ctx, h)` returned 0 once ctx expired, and the failure
// log showed "value=0 required=N" even when the chain was idling at e.g. 42.
func TestPollHeimdallCounter_FailureLogShowsLastValidValue(t *testing.T) {
	script := []scriptStep{
		{ok: true, id: 42}, // baseline = 42
		{ok: true, id: 42}, // poll: still 42
		// repeats forever (stall)
	}

	// Capture the failure log so we can assert on the value emitted.
	var buf bytes.Buffer
	logger := slog.New(slog.NewTextHandler(&buf, &slog.HandlerOptions{Level: slog.LevelDebug}))

	fh := &fakeHeimdall{script: script}
	srv := httptest.NewServer(fh.handler())
	t.Cleanup(srv.Close)

	old := pollInterval
	pollInterval = 50 * time.Millisecond
	t.Cleanup(func() { pollInterval = old })

	res := pollHeimdallCounter(
		context.Background(),
		stubDevnet{url: srv.URL},
		logger,
		500*time.Millisecond,
		"spans", "min_spans", 1,
		func(ctx context.Context, h *chain.Heimdall) (uint64, error) {
			return h.LatestSpanID(ctx)
		},
	)

	if res.Failed != 1 {
		t.Fatalf("expected Failed=1 on stall, got %+v", res)
	}
	out := buf.String()
	if !strings.Contains(out, "Did not reach required value") {
		t.Fatalf("missing failure log line; got:\n%s", out)
	}
	if !strings.Contains(out, "value=42") {
		t.Fatalf("failure log should report last-valid value=42, got:\n%s", out)
	}
	if strings.Contains(out, "value=0") {
		t.Fatalf("failure log must NOT report value=0 (regression), got:\n%s", out)
	}
}
