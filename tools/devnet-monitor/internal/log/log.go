// Package log configures the program-wide slog default handler. Probes log
// via plain slog.Info / slog.Debug / slog.Error from the standard library;
// this package only exists to centralise level + format selection and to
// host a small custom text handler.
package log

import (
	"context"
	"fmt"
	"log/slog"
	"os"
	"strings"
	"sync"
)

// Format selects the output shape.
type Format int

const (
	FormatText Format = iota
	FormatJSON
)

// ParseFormat maps a CLI string to a Format. Unknown values fall back to text.
func ParseFormat(s string) Format {
	if strings.EqualFold(s, "json") {
		return FormatJSON
	}
	return FormatText
}

// Init wires up slog.Default with the chosen format and a level taken from
// LOG_LEVEL (DEBUG|INFO|WARN|ERROR; default INFO). Output goes to stderr.
func Init(format Format) {
	level := levelFromEnv()

	var h slog.Handler
	switch format {
	case FormatJSON:
		h = slog.NewJSONHandler(os.Stderr, &slog.HandlerOptions{Level: level})
	default:
		h = newTextHandler(os.Stderr, level)
	}
	slog.SetDefault(slog.New(h))
}

func levelFromEnv() slog.Level {
	switch strings.ToUpper(os.Getenv("LOG_LEVEL")) {
	case "DEBUG":
		return slog.LevelDebug
	case "WARN":
		return slog.LevelWarn
	case "ERROR":
		return slog.LevelError
	default:
		return slog.LevelInfo
	}
}

// textHandler renders `2026-05-05 18:25:24 INFO Capture baseline node=foo latest=146`
// — a compact format inspired by the bash log shape this tool replaced.
// Implements slog.Handler.
type textHandler struct {
	mu    *sync.Mutex
	w     *os.File
	level slog.Level
	attrs []slog.Attr // accumulated via WithAttrs (used by `slog.With(...)`)
}

func newTextHandler(w *os.File, level slog.Level) *textHandler {
	return &textHandler{mu: &sync.Mutex{}, w: w, level: level}
}

func (h *textHandler) Enabled(_ context.Context, lvl slog.Level) bool {
	return lvl >= h.level
}

func (h *textHandler) Handle(_ context.Context, r slog.Record) error {
	var b strings.Builder
	b.WriteString(r.Time.Format("2006-01-02 15:04:05"))
	b.WriteByte(' ')
	b.WriteString(r.Level.String())
	b.WriteByte(' ')
	b.WriteString(r.Message)
	for _, a := range h.attrs {
		writeAttr(&b, a)
	}
	r.Attrs(func(a slog.Attr) bool {
		writeAttr(&b, a)
		return true
	})
	b.WriteByte('\n')

	h.mu.Lock()
	defer h.mu.Unlock()
	_, err := h.w.WriteString(b.String())
	return err
}

func (h *textHandler) WithAttrs(attrs []slog.Attr) slog.Handler {
	cp := *h
	cp.attrs = append(append([]slog.Attr{}, h.attrs...), attrs...)
	return &cp
}

// WithGroup is a no-op for this handler — we don't use slog groups in this
// program, and grouping would complicate the flat key=value rendering.
func (h *textHandler) WithGroup(_ string) slog.Handler { return h }

func writeAttr(b *strings.Builder, a slog.Attr) {
	if a.Key == "" {
		return
	}
	b.WriteByte(' ')
	b.WriteString(a.Key)
	b.WriteByte('=')
	v := a.Value.Resolve().Any()
	switch s := v.(type) {
	case string:
		if strings.ContainsAny(s, " \t\"") {
			fmt.Fprintf(b, "%q", s)
		} else {
			b.WriteString(s)
		}
	default:
		fmt.Fprintf(b, "%v", v)
	}
}
