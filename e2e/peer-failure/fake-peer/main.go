package main

import (
	"flag"
	"fmt"
	"os"
	"sort"
	"strings"
	"time"
)

func main() {
	var (
		enodeURL = flag.String("enode", "", "target enode:// URL (its public key is used for RLPx)")
		dialAddr = flag.String("dial", "", "host:port to dial; defaults to the enode's address")
		scenario = flag.String("scenario", "valid", "misbehaviour: "+strings.Join(scenarioNames(), ", "))
		duration = flag.Duration("duration", 30*time.Second, "how long to drive the scenario")
		ioto     = flag.Duration("timeout", 5*time.Second, "per-message i/o timeout")
	)
	flag.Parse()

	if *enodeURL == "" {
		fatal("missing -enode")
	}
	scn, ok := scenarios()[*scenario]
	if !ok {
		fatal(fmt.Sprintf("unknown -scenario %q (have: %s)", *scenario, strings.Join(scenarioNames(), ", ")))
	}

	pub, err := pubkeyFromEnode(*enodeURL)
	if err != nil {
		fatal("parse enode: " + err.Error())
	}
	addr := *dialAddr
	if addr == "" {
		addr = enodeAddr(*enodeURL)
	}
	if addr == "" {
		fatal("could not determine dial address; pass -dial host:port")
	}

	fmt.Printf("fake-peer: scenario=%s dial=%s duration=%s\n", *scenario, addr, *duration)

	p, err := Dial(addr, pub, *ioto)
	if err != nil {
		fatal("dial: " + err.Error())
	}
	defer p.Close()

	if err := p.Handshake(); err != nil {
		fatal("handshake: " + err.Error())
	}
	fmt.Println("fake-peer: RLPx + hello handshake OK")

	obs, err := scn(p, *duration)
	if err != nil {
		fatal("scenario: " + err.Error())
	}
	fmt.Printf("fake-peer: DONE — %s\n", obs)
}

func enodeAddr(enode string) string {
	s := enode
	if i := strings.Index(s, "@"); i >= 0 {
		s = s[i+1:]
	} else {
		return ""
	}
	if i := strings.Index(s, "?"); i >= 0 {
		s = s[:i]
	}
	return s
}

func scenarioNames() []string {
	names := make([]string, 0, len(scenarios()))
	for k := range scenarios() {
		names = append(names, k)
	}
	sort.Strings(names)
	return names
}

func fatal(msg string) {
	fmt.Fprintln(os.Stderr, "fake-peer: ERROR: "+msg)
	os.Exit(1)
}
