package discover

import (
	"fmt"
	"os"
	"regexp"
	"strings"

	"gopkg.in/yaml.v3"
)

// composeDevnet reads a docker-compose.yaml produced by the snapshot pipeline.
// Service names look like "<enclave>-l2-el-1-bor-heimdall-v2-validator".
type composeDevnet struct {
	path     string
	services map[string]composeService
}

type composeService struct {
	Ports []string `yaml:"ports"` // e.g. "32789:8545"
}

type composeFile struct {
	Services map[string]composeService `yaml:"services"`
}

func newCompose(path string) (Devnet, error) {
	b, err := os.ReadFile(path)
	if err != nil {
		return nil, fmt.Errorf("read compose file: %w", err)
	}
	var cf composeFile
	if err := yaml.Unmarshal(b, &cf); err != nil {
		return nil, fmt.Errorf("parse compose file: %w", err)
	}
	return &composeDevnet{path: path, services: cf.Services}, nil
}

func (c *composeDevnet) Target() string { return "compose:" + c.path }

// L2ELServices: pick the host port mapped to container port 8545 for each
// service whose name matches "-l2-el-N-".
func (c *composeDevnet) L2ELServices() ([]Service, error) {
	return c.servicesByContainerPort(rxL2EL, 8545, "")
}

// L2CLServices: pick the host port mapped to container port 26657 (CometBFT RPC).
func (c *composeDevnet) L2CLServices() ([]Service, error) {
	return c.servicesByContainerPort(rxL2CL, 26657, "rabbitmq")
}

// L2CLAPI: first validator's REST API (container port 1317).
func (c *composeDevnet) L2CLAPI() (Service, error) {
	all, err := c.servicesByContainerPort(rxL2CL, 1317, "rabbitmq")
	if err != nil {
		return Service{}, err
	}
	for _, s := range all {
		if strings.HasSuffix(s.Name, "-validator") {
			return s, nil
		}
	}
	if len(all) > 0 {
		return all[0], nil
	}
	return Service{}, fmt.Errorf("no l2-cl REST API service found in compose file")
}

// servicesByContainerPort iterates services matching rx (and not containing
// exclude), and for each finds the host port mapped to containerPort.
// Mappings look like "12345:8545"; we want the "12345" side when the right
// hand is containerPort.
func (c *composeDevnet) servicesByContainerPort(rx *regexp.Regexp, containerPort int, exclude string) ([]Service, error) {
	suffix := fmt.Sprintf(":%d", containerPort)
	var out []Service
	for name, svc := range c.services {
		if !rx.MatchString(name) {
			continue
		}
		if exclude != "" && strings.Contains(name, exclude) {
			continue
		}
		for _, p := range svc.Ports {
			if !strings.HasSuffix(p, suffix) {
				continue
			}
			hostPort := strings.SplitN(p, ":", 2)[0]
			out = append(out, Service{
				Name: name,
				URL:  fmt.Sprintf("http://localhost:%s", hostPort),
			})
			break
		}
	}
	return sortByName(out), nil
}
