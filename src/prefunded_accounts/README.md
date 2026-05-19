# Pre-funded accounts

The package prefunds some Ethereum and Tendermint accounts to make the validator setup easier and faster.

Two generator scripts are provided. Both emit the same `accounts.star` schema, so the rest of the package consumes them identically.

## `generate-vanity.sh` (canonical)

Mines vanity addresses whose 5-char hex prefix encodes the 1-based account index by cyclic repeat (1 → `0x11111…`, 2 → `0x22222…`, 10 → `0x10101…`, 999 → `0x99999…`). This makes the first handful of validators and prefunded accounts instantly recognisable in logs, dashboards, and explorers.

Run on the host (not inside the polycli container) — the script shells out to `docker` for the [`planxthanee/ethereum-wallet-generator`](https://hub.docker.com/r/planxthanee/ethereum-wallet-generator) miner and uses host `cast` to derive public keys.

```bash
ACCOUNTS_NUMBER=20 bash generate-vanity.sh
```

The accounts currently committed in `accounts.star` were produced this way.

## `generate.sh` (mnemonic, deterministic fallback)

The original BIP-44/mnemonic-derived generator. Kept around for anyone who needs deterministic re-derivation from a known seed.

Run inside the polycli container.

```bash
docker run -it --rm --volume "$(pwd):/tmp" --workdir /tmp ghcr.io/0xpolygon/pos-validator-config-generator:0.6.0 bash
```

```bash
export ACCOUNTS_NUMBER=20
export MNEMONIC="sibling lend brave explain wait orbit mom alcohol disorder message grace sun"
bash generate.sh
```

Either script overwrites `accounts.star` in place; re-run the package afterwards to pick up the new accounts.

Be aware that account generation takes time, and the more accounts requested, the longer it runs — vanity mining adds extra cost on top, growing roughly with the rarity of each target prefix.
