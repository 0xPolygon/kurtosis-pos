package chain

import (
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strconv"
	"time"
)

// CL talks to a Heimdall node over either CometBFT RPC (for block height)
// or the REST API (for spans / milestones / checkpoints), depending on
// which URL the caller dialled.
type CL struct {
	baseURL string
	hc      *http.Client
}

// DialCL stores the base URL; no connection is opened until first call.
func DialCL(baseURL string) *CL {
	return &CL{baseURL: baseURL, hc: &http.Client{Timeout: 10 * time.Second}}
}

// Height reads the latest block height from CometBFT's /status endpoint.
func (cl *CL) Height(ctx context.Context) (uint64, error) {
	var resp struct {
		Result struct {
			SyncInfo struct {
				LatestBlockHeight string `json:"latest_block_height"`
			} `json:"sync_info"`
		} `json:"result"`
	}
	if err := cl.getJSON(ctx, "/status", &resp); err != nil {
		return 0, err
	}
	return parseUint(resp.Result.SyncInfo.LatestBlockHeight)
}

// LatestSpanID reads the latest bor span id from the Heimdall REST API.
func (cl *CL) LatestSpanID(ctx context.Context) (uint64, error) {
	var resp struct {
		Span struct {
			ID string `json:"id"`
		} `json:"span"`
	}
	if err := cl.getJSON(ctx, "/bor/spans/latest", &resp); err != nil {
		return 0, err
	}
	return parseUint(resp.Span.ID)
}

// MilestoneCount reads the milestone count from the Heimdall REST API.
func (cl *CL) MilestoneCount(ctx context.Context) (uint64, error) {
	var resp struct {
		Count string `json:"count"`
	}
	if err := cl.getJSON(ctx, "/milestones/count", &resp); err != nil {
		return 0, err
	}
	return parseUint(resp.Count)
}

// CheckpointAckCount reads the ack count of checkpoints from the REST API.
// (Equivalent to "how many checkpoints have been committed to L1".)
func (cl *CL) CheckpointAckCount(ctx context.Context) (uint64, error) {
	var resp struct {
		AckCount string `json:"ack_count"`
	}
	if err := cl.getJSON(ctx, "/checkpoints/count", &resp); err != nil {
		return 0, err
	}
	return parseUint(resp.AckCount)
}

func (cl *CL) getJSON(ctx context.Context, path string, out any) error {
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, cl.baseURL+path, nil)
	if err != nil {
		return err
	}
	resp, err := cl.hc.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return err
	}
	if resp.StatusCode >= 400 {
		return fmt.Errorf("%s -> %d: %s", path, resp.StatusCode, string(body))
	}
	return json.Unmarshal(body, out)
}

func parseUint(s string) (uint64, error) {
	if s == "" {
		return 0, nil
	}
	n, err := strconv.ParseUint(s, 10, 64)
	if err != nil {
		return 0, fmt.Errorf("parse %q as uint: %w", s, err)
	}
	return n, nil
}
