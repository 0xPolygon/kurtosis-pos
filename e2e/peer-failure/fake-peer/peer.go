package main

import (
	"crypto/ecdsa"
	"encoding/hex"
	"fmt"
	"math/big"
	"net"
	"strings"
	"time"

	"github.com/ethereum/go-ethereum/crypto"
	"github.com/ethereum/go-ethereum/p2p/rlpx"
	"github.com/ethereum/go-ethereum/rlp"
)

const (
	baseProtoLen = 16

	helloCode = 0x00
	discCode  = 0x01
	pingCode  = 0x02
	pongCode  = 0x03

	ethStatus                     = 0x00
	ethTransactions               = 0x02
	ethGetBlockHeaders            = 0x03
	ethBlockHeaders               = 0x04
	ethNewPooledTransactionHashes = 0x08
)

func ethCode(msg uint64) uint64 { return baseProtoLen + msg }

type capability struct {
	Name    string
	Version uint
}

type helloMsg struct {
	Version    uint64
	Name       string
	Caps       []capability
	ListenPort uint64
	ID         []byte
	Rest       []rlp.RawValue `rlp:"tail"`
}

type forkID struct {
	Hash [4]byte
	Next uint64
}

type status struct {
	ProtocolVersion uint32
	NetworkID       uint64
	TD              *big.Int
	Genesis         [32]byte
	ForkID          forkID
	EarliestBlock   uint64
	LatestBlock     uint64
	LatestBlockHash [32]byte
}

type getBlockHeaders struct {
	RequestID uint64
	Rest      []rlp.RawValue `rlp:"tail"`
}

type blockHeaders struct {
	RequestID uint64
	Headers   []rlp.RawValue
}

type Peer struct {
	conn     *rlpx.Conn
	key      *ecdsa.PrivateKey
	iot      time.Duration
	ethVer   uint
	remoteHi status
}

func Dial(dialAddr string, remotePub *ecdsa.PublicKey, ioTimeout time.Duration) (*Peer, error) {
	tcp, err := net.DialTimeout("tcp", dialAddr, 10*time.Second)
	if err != nil {
		return nil, fmt.Errorf("tcp dial %s: %w", dialAddr, err)
	}
	key, err := crypto.GenerateKey()
	if err != nil {
		return nil, err
	}
	conn := rlpx.NewConn(tcp, remotePub)
	if _, err := conn.Handshake(key); err != nil {
		conn.Close()
		return nil, fmt.Errorf("rlpx handshake: %w", err)
	}
	return &Peer{conn: conn, key: key, iot: ioTimeout, ethVer: 69}, nil
}

func (p *Peer) Close() error { return p.conn.Close() }

func (p *Peer) write(code uint64, val any) error {
	payload, err := rlp.EncodeToBytes(val)
	if err != nil {
		return err
	}
	return p.writeRaw(code, payload)
}

func (p *Peer) writeRaw(code uint64, payload []byte) error {
	_ = p.conn.SetWriteDeadline(time.Now().Add(p.iot))
	_, err := p.conn.Write(code, payload)
	return err
}

func (p *Peer) read() (uint64, []byte, error) {
	_ = p.conn.SetReadDeadline(time.Now().Add(p.iot))
	code, data, _, err := p.conn.Read()
	return code, data, err
}

func (p *Peer) Handshake() error {
	pub := crypto.FromECDSAPub(&p.key.PublicKey)[1:]
	ours := &helloMsg{
		Version: 5,
		Name:    "kurtosis-pos-fakepeer/1",
		Caps:    []capability{{Name: "eth", Version: p.ethVer}},
		ID:      pub,
	}
	if err := p.write(helloCode, ours); err != nil {
		return fmt.Errorf("write hello: %w", err)
	}
	code, data, err := p.read()
	if err != nil {
		return fmt.Errorf("read hello: %w", err)
	}
	if code != helloCode {
		return fmt.Errorf("expected hello, got code %d", code)
	}
	var theirs helloMsg
	if err := rlp.DecodeBytes(data, &theirs); err != nil {
		return fmt.Errorf("decode hello: %w", err)
	}
	if theirs.Version >= 5 {
		p.conn.SetSnappy(true)
	}
	if !hasEthCap(theirs.Caps, p.ethVer) {
		return fmt.Errorf("peer does not offer eth/%d (caps=%v)", p.ethVer, theirs.Caps)
	}
	return nil
}

func (p *Peer) StatusExchange(mutate func(*status)) (status, error) {
	var theirs status
	for {
		code, data, err := p.read()
		if err != nil {
			return theirs, fmt.Errorf("read status: %w", err)
		}
		switch code {
		case pingCode:
			_ = p.writeRaw(pongCode, []byte{0xc0})
			continue
		case discCode:
			return theirs, fmt.Errorf("peer disconnected during status: %s", hex.EncodeToString(data))
		case ethCode(ethStatus):
			if err := rlp.DecodeBytes(data, &theirs); err != nil {
				return theirs, fmt.Errorf("decode status: %w", err)
			}
		default:
			continue
		}
		break
	}
	p.remoteHi = theirs

	ours := theirs
	if ours.TD == nil {
		ours.TD = new(big.Int)
	}
	if mutate != nil {
		mutate(&ours)
	}
	if err := p.write(ethCode(ethStatus), &ours); err != nil {
		return theirs, fmt.Errorf("write status: %w", err)
	}
	return theirs, nil
}

func (p *Peer) ReadEth() (uint64, []byte, error) {
	for {
		code, data, err := p.read()
		if err != nil {
			return 0, nil, err
		}
		switch {
		case code == pingCode:
			_ = p.writeRaw(pongCode, []byte{0xc0})
			continue
		case code == discCode:
			return 0, nil, fmt.Errorf("disconnected: %w", errDisconnected)
		case code < baseProtoLen:
			continue
		default:
			return code - baseProtoLen, data, nil
		}
	}
}

func hasEthCap(caps []capability, want uint) bool {
	for _, c := range caps {
		if c.Name == "eth" && c.Version == want {
			return true
		}
	}
	return false
}

func pubkeyFromEnode(enode string) (*ecdsa.PublicKey, error) {
	s := enode
	if i := strings.Index(s, "://"); i >= 0 {
		s = s[i+3:]
	}
	if i := strings.IndexByte(s, '@'); i >= 0 {
		s = s[:i]
	}
	if len(s) != 128 {
		return nil, fmt.Errorf("enode pubkey must be 128 hex chars, got %d", len(s))
	}
	raw, err := hex.DecodeString(s)
	if err != nil {
		return nil, fmt.Errorf("decode enode pubkey: %w", err)
	}
	return crypto.UnmarshalPubkey(append([]byte{0x04}, raw...))
}
