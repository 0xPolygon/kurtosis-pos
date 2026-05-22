package probes

import (
	"encoding/json"
	"io"
	"log/slog"
	"os"
	"path/filepath"
	"strings"
	"sync"
	"testing"
	"time"
)

func newTestLogger() *slog.Logger {
	return slog.New(slog.NewTextHandler(io.Discard, nil))
}

func TestTargetBlockLatch_BelowTargetDoesNotFire(t *testing.T) {
	l := newTargetBlockLatch(256, "", time.Now(), newTestLogger())
	l.observe("node-a", 100)
	l.observe("node-b", 255)
	if l.fired() {
		t.Fatalf("latch fired below target")
	}
}

func TestTargetBlockLatch_FiresOnceAcrossGoroutines(t *testing.T) {
	dir := t.TempDir()
	emit := filepath.Join(dir, "timing.jsonl")

	start := time.Now().Add(-2 * time.Second)
	l := newTargetBlockLatch(256, emit, start, newTestLogger())

	var wg sync.WaitGroup
	for i := 0; i < 20; i++ {
		wg.Add(1)
		go func(i int) {
			defer wg.Done()
			// Half observe at exactly target, half above.
			latest := uint64(256)
			if i%2 == 0 {
				latest = 300
			}
			l.observe("node-x", latest)
		}(i)
	}
	wg.Wait()

	if !l.fired() {
		t.Fatalf("latch did not fire after observations")
	}

	data, err := os.ReadFile(emit)
	if err != nil {
		t.Fatalf("read emit file: %v", err)
	}
	lines := strings.Split(strings.TrimRight(string(data), "\n"), "\n")
	if len(lines) != 1 {
		t.Fatalf("expected exactly 1 emitted line, got %d:\n%s", len(lines), data)
	}

	var rec struct {
		Phase     string  `json:"phase"`
		StartedAt string  `json:"started_at"`
		EndedAt   string  `json:"ended_at"`
		Duration  float64 `json:"duration_s"`
		Extras    struct {
			TargetBlock   uint64 `json:"target_block"`
			ObservedBlock uint64 `json:"observed_block"`
			Node          string `json:"node"`
		} `json:"extras"`
	}
	if err := json.Unmarshal([]byte(lines[0]), &rec); err != nil {
		t.Fatalf("unmarshal record: %v (line: %s)", err, lines[0])
	}
	if rec.Phase != "time-to-block" {
		t.Errorf("phase = %q, want time-to-block", rec.Phase)
	}
	if rec.Extras.TargetBlock != 256 {
		t.Errorf("target_block = %d, want 256", rec.Extras.TargetBlock)
	}
	if rec.Extras.ObservedBlock < 256 {
		t.Errorf("observed_block = %d, want >= 256", rec.Extras.ObservedBlock)
	}
	if rec.Duration < 1.5 || rec.Duration > 30 {
		// Start was set 2s in the past; expect duration ~2s plus a little
		// scheduling jitter. Wide upper bound to stay non-flaky on slow CI.
		t.Errorf("duration_s = %.3f, want roughly 2s", rec.Duration)
	}
}

func TestTargetBlockLatch_EmitPathDirIsCreated(t *testing.T) {
	dir := t.TempDir()
	emit := filepath.Join(dir, "nested", "subdir", "timing.jsonl")

	l := newTargetBlockLatch(10, emit, time.Now(), newTestLogger())
	l.observe("node", 10)

	if _, err := os.Stat(emit); err != nil {
		t.Fatalf("expected emit file at %s: %v", emit, err)
	}
}

func TestTargetBlockLatch_NoEmitPathStillFires(t *testing.T) {
	l := newTargetBlockLatch(10, "", time.Now(), newTestLogger())
	l.observe("node", 10)
	if !l.fired() {
		t.Fatalf("latch should still fire without emit path")
	}
}
