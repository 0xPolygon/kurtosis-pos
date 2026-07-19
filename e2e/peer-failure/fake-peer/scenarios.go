package main

import (
	"crypto/rand"
	"errors"
	"fmt"
	"math/big"
	"time"

	"github.com/ethereum/go-ethereum/rlp"
)

var errDisconnected = errors.New("peer disconnected us")

type pooledTxHashes68 struct {
	Types  []byte
	Sizes  []uint32
	Hashes [][32]byte
}

type scenario func(p *Peer, d time.Duration) (string, error)

func scenarios() map[string]scenario {
	return map[string]scenario{
		"valid":        scnValid,
		"flood":        scnFlood,
		"baddata":      scnBadData,
		"stall":        scnStall,
		"emptyheaders": scnEmptyHeaders,
		"badheaders":   scnBadHeaders,
		"disconnect":   scnDisconnect,
	}
}

func aheadOf(s *status) {
	s.LatestBlock = s.LatestBlock + 1024
	if s.TD == nil {
		s.TD = new(big.Int)
	}
	s.TD = new(big.Int).Add(s.TD, big.NewInt(1_000_000))
}

func scnValid(p *Peer, d time.Duration) (string, error) {
	if _, err := p.StatusExchange(nil); err != nil {
		return "", err
	}
	deadline := time.Now().Add(d)
	for time.Now().Before(deadline) {
		if _, _, err := p.ReadEth(); err != nil {
			if errors.Is(err, errDisconnected) {
				return "target disconnected a well-behaved peer (unexpected)", nil
			}
		}
	}
	return "stayed connected as a healthy peer for the full window", nil
}

func scnFlood(p *Peer, d time.Duration) (string, error) {
	if _, err := p.StatusExchange(nil); err != nil {
		return "", err
	}
	msg := makePooledHashes(4096)
	payload, err := rlp.EncodeToBytes(msg)
	if err != nil {
		return "", err
	}
	deadline := time.Now().Add(d)
	sent := 0
	for time.Now().Before(deadline) {
		if err := p.writeRaw(ethCode(ethNewPooledTransactionHashes), payload); err != nil {
			return fmt.Sprintf("target stopped accepting our flood after %d messages (%v)", sent, err), nil
		}
		sent++
	}
	return fmt.Sprintf("target absorbed %d flood messages without disconnecting us", sent), nil
}

func scnBadData(p *Peer, d time.Duration) (string, error) {
	if _, err := p.StatusExchange(nil); err != nil {
		return "", err
	}
	if err := p.writeRaw(ethCode(ethGetBlockHeaders), []byte{0xff}); err != nil {
		return fmt.Sprintf("write rejected immediately: %v", err), nil
	}
	if _, _, err := p.ReadEth(); err != nil {
		if errors.Is(err, errDisconnected) {
			return "target disconnected us after malformed message (expected)", nil
		}
		return fmt.Sprintf("target reacted to malformed message: %v", err), nil
	}
	return "target tolerated a malformed message (unexpected)", nil
}

func scnStall(p *Peer, d time.Duration) (string, error) {
	if _, err := p.StatusExchange(aheadOf); err != nil {
		return "", err
	}
	deadline := time.Now().Add(d)
	requests := 0
	for time.Now().Before(deadline) {
		code, _, err := p.ReadEth()
		if err != nil {
			if errors.Is(err, errDisconnected) {
				return fmt.Sprintf("target disconnected us after %d unanswered header requests", requests), nil
			}
			continue
		}
		if code == ethGetBlockHeaders {
			requests++
		}
	}
	return fmt.Sprintf("withheld responses to %d header requests for the full window", requests), nil
}

func scnEmptyHeaders(p *Peer, d time.Duration) (string, error) {
	return answerHeaders(p, d, func(reqID uint64) blockHeaders {
		return blockHeaders{RequestID: reqID, Headers: nil}
	})
}

func scnBadHeaders(p *Peer, d time.Duration) (string, error) {
	return answerHeaders(p, d, func(reqID uint64) blockHeaders {
		garbage := []rlp.RawValue{{0x82, 0xde, 0xad}}
		return blockHeaders{RequestID: reqID, Headers: garbage}
	})
}

func answerHeaders(p *Peer, d time.Duration, reply func(reqID uint64) blockHeaders) (string, error) {
	if _, err := p.StatusExchange(aheadOf); err != nil {
		return "", err
	}
	deadline := time.Now().Add(d)
	answered := 0
	for time.Now().Before(deadline) {
		code, data, err := p.ReadEth()
		if err != nil {
			if errors.Is(err, errDisconnected) {
				return fmt.Sprintf("target disconnected us after %d crafted header responses", answered), nil
			}
			continue
		}
		if code != ethGetBlockHeaders {
			continue
		}
		var req getBlockHeaders
		if err := rlp.DecodeBytes(data, &req); err != nil {
			continue
		}
		if err := p.write(ethCode(ethBlockHeaders), reply(req.RequestID)); err != nil {
			return fmt.Sprintf("target closed after %d crafted responses (%v)", answered, err), nil
		}
		answered++
	}
	return fmt.Sprintf("served %d crafted header responses over the window", answered), nil
}

func scnDisconnect(p *Peer, d time.Duration) (string, error) {
	if _, err := p.StatusExchange(nil); err != nil {
		return "", err
	}
	_ = p.Close()
	return "completed handshake then dropped the connection", nil
}

func makePooledHashes(n int) pooledTxHashes68 {
	m := pooledTxHashes68{
		Types:  make([]byte, n),
		Sizes:  make([]uint32, n),
		Hashes: make([][32]byte, n),
	}
	for i := 0; i < n; i++ {
		m.Sizes[i] = 128
		_, _ = rand.Read(m.Hashes[i][:])
	}
	return m
}
