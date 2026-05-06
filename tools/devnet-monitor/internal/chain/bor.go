// Package chain wraps go-ethereum's RPC client and Heimdall's REST/CometBFT
// APIs for the calls we need: block heights, gas price, span/milestone/checkpoint
// counters, and a single self-deploy stimulus tx.
package chain

import (
	"context"
	"crypto/ecdsa"
	"fmt"
	"math/big"

	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/crypto"
	"github.com/ethereum/go-ethereum/ethclient"
	"github.com/ethereum/go-ethereum/rpc"
)

// Bor is a Bor (geth-fork) RPC client.
type Bor struct {
	rpc *rpc.Client
	eth *ethclient.Client
}

// DialBor opens an RPC connection to a Bor node.
func DialBor(ctx context.Context, url string) (*Bor, error) {
	c, err := rpc.DialContext(ctx, url)
	if err != nil {
		return nil, fmt.Errorf("dial %s: %w", url, err)
	}
	return &Bor{rpc: c, eth: ethclient.NewClient(c)}, nil
}

func (b *Bor) Close() { b.rpc.Close() }

// LatestBlock returns the head block number.
func (b *Bor) LatestBlock(ctx context.Context) (uint64, error) {
	return b.eth.BlockNumber(ctx)
}

// FinalizedBlock returns the finalized block number. Returns 0 (no error)
// before the chain reaches its first finality threshold.
func (b *Bor) FinalizedBlock(ctx context.Context) (uint64, error) {
	header, err := b.eth.HeaderByNumber(ctx, big.NewInt(int64(rpc.FinalizedBlockNumber)))
	if err != nil {
		// Bor returns "finalized block not found" before the chain reaches
		// finality. Treat as 0 so the caller's poll loop stays alive.
		return 0, nil
	}
	return header.Number.Uint64(), nil
}

// GasPrice returns the suggested gas price.
func (b *Bor) GasPrice(ctx context.Context) (*big.Int, error) {
	return b.eth.SuggestGasPrice(ctx)
}

// SendStimulusTx broadcasts a self-deployed contract that runs an infinite
// loop bounded by gas. The bytecode here is exactly the one used by the
// previous bash scripts, kept identical to preserve the well-known dry-run
// shape on devnets. The signing key is hardcoded — it's a publicly-known
// devnet test key with no value on real networks.
//
// gasPriceFactor scales the suggested gas price; the caller increases it on
// failure to push past temporary congestion.
func (b *Bor) SendStimulusTx(ctx context.Context, gasPriceFactor float64) error {
	priv, err := crypto.HexToECDSA("d40311b5a5ca5eaeb48dfba5403bde4993ece8eccf4190e98e19fcd4754260ea")
	if err != nil {
		return fmt.Errorf("parse devnet key: %w", err)
	}
	from := crypto.PubkeyToAddress(*priv.Public().(*ecdsa.PublicKey))

	chainID, err := b.eth.ChainID(ctx)
	if err != nil {
		return fmt.Errorf("get chain id: %w", err)
	}
	nonce, err := b.eth.PendingNonceAt(ctx, from)
	if err != nil {
		return fmt.Errorf("get nonce: %w", err)
	}
	suggested, err := b.eth.SuggestGasPrice(ctx)
	if err != nil {
		return fmt.Errorf("suggest gas price: %w", err)
	}
	scaled := new(big.Float).Mul(new(big.Float).SetInt(suggested), big.NewFloat(gasPriceFactor))
	gasPrice, _ := scaled.Int(nil)

	// Bytecode: deploys a contract that runs `extcodecopy` in a loop, eating
	// gas until the gas-limit cap is hit. Identical to what the bash scripts
	// used. We use legacy (non-1559) txs for compatibility.
	code := []byte{
		0x60, 0x01, 0x61, 0x70, 0x00, 0x52, 0x61, 0x60, 0x00, 0x61, 0x10, 0x00, 0x5f, 0xf0, 0x5b, 0x61,
		0x09, 0xc4, 0x5a, 0x11, 0x15, 0x60, 0x24, 0x57, 0x61, 0x60, 0x00, 0x61, 0x10, 0x00, 0x80, 0x83,
		0x3c, 0x60, 0x0e, 0x56, 0x5b, 0x50,
	}

	tx := types.NewContractCreation(nonce, big.NewInt(0), 100_000, gasPrice, code)
	signed, err := types.SignTx(tx, types.NewEIP155Signer(chainID), priv)
	if err != nil {
		return fmt.Errorf("sign tx: %w", err)
	}
	if err := b.eth.SendTransaction(ctx, signed); err != nil {
		return fmt.Errorf("send tx: %w", err)
	}
	return nil
}
