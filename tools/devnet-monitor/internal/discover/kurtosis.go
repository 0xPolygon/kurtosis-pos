package discover

import (
	"context"
	"fmt"
	"regexp"
	"strings"

	"github.com/kurtosis-tech/kurtosis/api/golang/core/lib/enclaves"
	"github.com/kurtosis-tech/kurtosis/api/golang/core/lib/services"
	"github.com/kurtosis-tech/kurtosis/api/golang/engine/lib/kurtosis_context"
)

// kurtosisDevnet talks to the local kurtosis engine via the Go SDK.
type kurtosisDevnet struct {
	enclaveName string
	enclave     *enclaves.EnclaveContext
}

func newKurtosis(enclaveName string) (Devnet, error) {
	kctx, err := kurtosis_context.NewKurtosisContextFromLocalEngine()
	if err != nil {
		return nil, fmt.Errorf("connect to kurtosis engine: %w", err)
	}
	enclave, err := kctx.GetEnclaveContext(context.Background(), enclaveName)
	if err != nil {
		return nil, fmt.Errorf("get enclave %q: %w", enclaveName, err)
	}
	return &kurtosisDevnet{enclaveName: enclaveName, enclave: enclave}, nil
}

func (k *kurtosisDevnet) Target() string { return "enclave:" + k.enclaveName }

// Service-name patterns used to filter the service list. Matches both kurtosis
// names ("l2-el-1-…") and compose names with the enclave prefix ("pos-l2-el-1-…").
var (
	rxL2EL = regexp.MustCompile(`(?:^|-)l2-el-\d+-`)
	rxL2CL = regexp.MustCompile(`(?:^|-)l2-cl-\d+-`)
)

// l2ELPortIDs is the ordered list of port IDs to try when looking up an EL
// RPC. Different bor builds expose slightly different names; "rpc" is the
// canonical one in this package.
var l2ELPortIDs = []string{"rpc"}

// l2CLCometBFTPortIDs is the port ID for heimdall CometBFT RPC.
var l2CLCometBFTPortIDs = []string{"rpc"}

// l2CLAPIPortIDs is the port ID for heimdall REST API.
var l2CLAPIPortIDs = []string{"http"}

func (k *kurtosisDevnet) L2ELServices() ([]Service, error) {
	return k.servicesMatching(rxL2EL, l2ELPortIDs, "")
}

func (k *kurtosisDevnet) L2CLServices() ([]Service, error) {
	// Exclude rabbitmq sidecar (matches "-rabbitmq" in name).
	return k.servicesMatching(rxL2CL, l2CLCometBFTPortIDs, "rabbitmq")
}

func (k *kurtosisDevnet) L2CLAPI() (Service, error) {
	all, err := k.servicesMatching(rxL2CL, l2CLAPIPortIDs, "rabbitmq")
	if err != nil {
		return Service{}, err
	}
	if len(all) == 0 {
		return Service{}, fmt.Errorf("no l2-cl validator service found in enclave")
	}
	// Pick the first validator in sorted order. Match regardless of trailing
	// `-archive` suffix added by `el_bor_archive_mode: true` (the new default).
	for _, s := range all {
		if strings.Contains(s.Name, "-validator") {
			return s, nil
		}
	}
	// Fall back to first node if no validator suffix (config quirk).
	return all[0], nil
}

func (k *kurtosisDevnet) servicesMatching(rx *regexp.Regexp, portIDs []string, exclude string) ([]Service, error) {
	all, err := k.enclave.GetServices()
	if err != nil {
		return nil, fmt.Errorf("list services: %w", err)
	}
	var out []Service
	for name := range all {
		s := string(name)
		if !rx.MatchString(s) {
			continue
		}
		if exclude != "" && strings.Contains(s, exclude) {
			continue
		}
		ctx, err := k.enclave.GetServiceContext(s)
		if err != nil {
			return nil, fmt.Errorf("get service %q: %w", s, err)
		}
		port, ok := pickPort(ctx, portIDs)
		if !ok {
			continue
		}
		out = append(out, Service{
			Name: s,
			URL:  fmt.Sprintf("http://127.0.0.1:%d", port.GetNumber()),
		})
	}
	return sortByName(out), nil
}

// pickPort returns the first matching public port from a service context.
func pickPort(svc *services.ServiceContext, portIDs []string) (*services.PortSpec, bool) {
	pubs := svc.GetPublicPorts()
	for _, id := range portIDs {
		if p, ok := pubs[id]; ok {
			return p, true
		}
	}
	return nil, false
}
