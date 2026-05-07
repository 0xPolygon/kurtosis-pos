package chain

import (
	"context"
	"errors"
	"fmt"
	"net"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
	"time"
)

// newServer wires up an httptest.Server with the given handler and returns
// both the URL and a Heimdall client pointed at it.
func newServer(t *testing.T, h http.Handler) (string, *Heimdall) {
	t.Helper()
	srv := httptest.NewServer(h)
	t.Cleanup(srv.Close)
	return srv.URL, DialHeimdall(srv.URL)
}

// staticHandler writes status + body verbatim.
func staticHandler(status int, body string) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(status)
		_, _ = fmt.Fprint(w, body)
	})
}

// ============================================================================
// LatestSpanID — exercises every failure shape the heimdall REST endpoint
// could plausibly produce. Each test asserts (a) we get the expected uint64
// and (b) the error condition we expected.
// ============================================================================

func TestLatestSpanID_Happy(t *testing.T) {
	_, h := newServer(t, staticHandler(200, `{"span":{"id":"42"}}`))
	v, err := h.LatestSpanID(context.Background())
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}
	if v != 42 {
		t.Fatalf("expected 42, got %d", v)
	}
}

// Pre-fix, an empty span object made the caller see span id=0 with no error,
// which gave the misleading "value=0" failure logs in CI.
func TestLatestSpanID_MissingField(t *testing.T) {
	_, h := newServer(t, staticHandler(200, `{"span":{}}`))
	_, err := h.LatestSpanID(context.Background())
	if err == nil {
		t.Fatal("expected error on missing span.id, got nil (silent zero is the bug we just fixed)")
	}
}

// Missing top-level field is the same shape as a wrong-endpoint response —
// must error, not silently return 0.
func TestLatestSpanID_WrongShape(t *testing.T) {
	_, h := newServer(t, staticHandler(200, `{"unrelated":"thing"}`))
	_, err := h.LatestSpanID(context.Background())
	if err == nil {
		t.Fatal("expected error on wrong response shape, got nil")
	}
}

func TestLatestSpanID_NonNumericID(t *testing.T) {
	_, h := newServer(t, staticHandler(200, `{"span":{"id":"abc"}}`))
	_, err := h.LatestSpanID(context.Background())
	if err == nil {
		t.Fatal("expected error on non-numeric id, got nil")
	}
}

func TestLatestSpanID_EmptyBody(t *testing.T) {
	_, h := newServer(t, staticHandler(200, ``))
	_, err := h.LatestSpanID(context.Background())
	if err == nil {
		t.Fatal("expected error on empty body, got nil")
	}
}

func TestLatestSpanID_MalformedJSON(t *testing.T) {
	_, h := newServer(t, staticHandler(200, `not actually json`))
	_, err := h.LatestSpanID(context.Background())
	if err == nil {
		t.Fatal("expected error on malformed JSON, got nil")
	}
	// Body should be embedded in the error so logs show what came back.
	if !strings.Contains(err.Error(), "not actually json") {
		t.Fatalf("error should include body preview, got: %v", err)
	}
}

func TestLatestSpanID_HTMLErrorPage(t *testing.T) {
	// Some reverse proxies serve HTML 503 pages. We must not silently
	// "succeed" by parsing them as empty JSON.
	html := `<!DOCTYPE html><html><body>503 Service Unavailable</body></html>`
	_, h := newServer(t, staticHandler(200, html)) // 200 is the worst case (proxy lies)
	_, err := h.LatestSpanID(context.Background())
	if err == nil {
		t.Fatal("expected error on HTML body, got nil")
	}
}

func TestLatestSpanID_HTTPError(t *testing.T) {
	_, h := newServer(t, staticHandler(503, "service unavailable"))
	_, err := h.LatestSpanID(context.Background())
	if err == nil {
		t.Fatal("expected error on 503, got nil")
	}
	if !strings.Contains(err.Error(), "503") {
		t.Fatalf("error should mention 503, got: %v", err)
	}
}

func TestLatestSpanID_NotFound(t *testing.T) {
	_, h := newServer(t, staticHandler(404, "not found"))
	_, err := h.LatestSpanID(context.Background())
	if err == nil {
		t.Fatal("expected error on 404 (e.g. endpoint renamed upstream), got nil")
	}
}

func TestLatestSpanID_ConnectionRefused(t *testing.T) {
	// Pick an unused port and dial it — should fail fast at the TCP layer.
	l, err := net.Listen("tcp", "127.0.0.1:0")
	if err != nil {
		t.Fatalf("listen: %v", err)
	}
	addr := l.Addr().String()
	_ = l.Close() // free the port immediately

	h := DialHeimdall("http://" + addr)
	ctx, cancel := context.WithTimeout(context.Background(), 2*time.Second)
	defer cancel()
	_, err = h.LatestSpanID(ctx)
	if err == nil {
		t.Fatal("expected connection error, got nil")
	}
}

func TestLatestSpanID_HangingServer(t *testing.T) {
	// Server accepts the request but never writes — caller's context must
	// cancel the in-flight request via http.NewRequestWithContext.
	hold := make(chan struct{})
	t.Cleanup(func() { close(hold) })
	srv := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		<-r.Context().Done()
	}))
	t.Cleanup(srv.Close)

	h := DialHeimdall(srv.URL)
	ctx, cancel := context.WithTimeout(context.Background(), 200*time.Millisecond)
	defer cancel()
	_, err := h.LatestSpanID(ctx)
	if err == nil {
		t.Fatal("expected context-deadline error, got nil")
	}
	if !errors.Is(err, context.DeadlineExceeded) && !strings.Contains(err.Error(), "deadline exceeded") {
		t.Fatalf("expected deadline error, got: %v", err)
	}
}

// ============================================================================
// The other endpoints share the same parser/getJSON, so a single happy + a
// single missing-field test each is enough to confirm the contract holds.
// ============================================================================

func TestHeight_Happy(t *testing.T) {
	_, h := newServer(t, staticHandler(200, `{"result":{"sync_info":{"latest_block_height":"123"}}}`))
	v, err := h.Height(context.Background())
	if err != nil || v != 123 {
		t.Fatalf("expected 123/nil, got %d/%v", v, err)
	}
}

func TestHeight_MissingField(t *testing.T) {
	_, h := newServer(t, staticHandler(200, `{"result":{"sync_info":{}}}`))
	_, err := h.Height(context.Background())
	if err == nil {
		t.Fatal("expected error on missing latest_block_height, got nil")
	}
}

func TestMilestoneCount_Happy(t *testing.T) {
	_, h := newServer(t, staticHandler(200, `{"count":"7"}`))
	v, err := h.MilestoneCount(context.Background())
	if err != nil || v != 7 {
		t.Fatalf("expected 7/nil, got %d/%v", v, err)
	}
}

func TestMilestoneCount_MissingField(t *testing.T) {
	_, h := newServer(t, staticHandler(200, `{}`))
	_, err := h.MilestoneCount(context.Background())
	if err == nil {
		t.Fatal("expected error on missing count, got nil")
	}
}

func TestCheckpointAckCount_Happy(t *testing.T) {
	_, h := newServer(t, staticHandler(200, `{"ack_count":"4"}`))
	v, err := h.CheckpointAckCount(context.Background())
	if err != nil || v != 4 {
		t.Fatalf("expected 4/nil, got %d/%v", v, err)
	}
}

func TestCheckpointAckCount_MissingField(t *testing.T) {
	_, h := newServer(t, staticHandler(200, `{}`))
	_, err := h.CheckpointAckCount(context.Background())
	if err == nil {
		t.Fatal("expected error on missing ack_count, got nil")
	}
}
