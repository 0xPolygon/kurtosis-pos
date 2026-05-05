// Package discover finds the EL/CL services of a Polygon PoS devnet,
// abstracting over kurtosis enclaves and restored docker-compose devnets.
package discover

import (
	"fmt"
	"sort"
)

// Service is one running node — name plus a host-reachable URL for its RPC.
type Service struct {
	Name string
	URL  string // already-resolved http://localhost:PORT or http://127.0.0.1:PORT
}

// Devnet is the set of services we care about on a running PoS devnet.
type Devnet interface {
	// Target returns a label like "enclave:pos" or "compose:/tmp/foo.yaml".
	Target() string

	// L2ELServices returns every Bor RPC.
	L2ELServices() ([]Service, error)

	// L2CLServices returns every Heimdall CometBFT RPC (port 26657 in container).
	// Excludes the rabbitmq sidecar.
	L2CLServices() ([]Service, error)

	// L2CLAPI returns the REST API URL of the first Heimdall validator
	// (port 1317 in container). Used for spans/milestones/checkpoints.
	L2CLAPI() (Service, error)
}

// Open returns a Devnet from either an enclave name or a compose-file path.
// Exactly one must be non-empty.
func Open(enclaveName, composeFile string) (Devnet, error) {
	switch {
	case enclaveName != "" && composeFile != "":
		return nil, fmt.Errorf("only one of enclave or compose-file may be set")
	case composeFile != "":
		return newCompose(composeFile)
	case enclaveName != "":
		return newKurtosis(enclaveName)
	default:
		return nil, fmt.Errorf("either enclave or compose-file must be set")
	}
}

// sortByName returns a copy of services sorted by Name. Used to make
// stimulus-tx sender selection deterministic.
func sortByName(in []Service) []Service {
	out := make([]Service, len(in))
	copy(out, in)
	sort.Slice(out, func(i, j int) bool { return out[i].Name < out[j].Name })
	return out
}
