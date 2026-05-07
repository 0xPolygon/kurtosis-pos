// devnet-monitor checks that a Polygon PoS devnet is making progress.
// It supports both kurtosis enclaves and restored docker-compose devnets,
// with one subcommand per probe (bor, heimdall, spans, milestones, checkpoints)
// plus an `all` subcommand that runs every probe in parallel.
package main

import (
	"fmt"
	"os"
	"unicode"
	"unicode/utf8"

	"github.com/0xPolygon/kurtosis-pos/tools/devnet-monitor/cmd"
)

func main() {
	if err := cmd.Root().Execute(); err != nil {
		fmt.Fprintln(os.Stderr, "Error: "+capitalize(err.Error()))
		os.Exit(1)
	}
}

// capitalize uppercases the first rune of s. Internal errors stay lowercase
// per Go convention; we capitalize only at this user-facing boundary.
func capitalize(s string) string {
	if s == "" {
		return s
	}
	r, n := utf8.DecodeRuneInString(s)
	return string(unicode.ToUpper(r)) + s[n:]
}
