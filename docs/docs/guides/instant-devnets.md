---
sidebar_position: 5
---

# Instant Devnets

This guide will show you how to spin up PoS devnets under 20 seconds using snapshots. This is useful for quick testing and development iterations, without having to wait for the devnet to start and reach a certain state. However, it does not provide the same level of configurability, especially at the L1 level, but it can be a great way to get started quickly.

## Restore from snapshot

We provide two snapshot types:
- **small**: the environment contains an L1 chain and an L2 chain with a single heimdall-v2/bor validator. Useful for testing basic functionalities.
- **large**: the environment contains an L1 chain and an L2 chain with 7 heimdall-v2/bor validators, 3 rpc nodes (one stateless bor node, one stateful bor node, one stateful erigon node) and one archive bor node. Useful for testing in a more realistic environment.

Environments are snapshotted around block 100 on the L2 chain, which should be enough for most testing purposes.

Remove any existing snapshot data.

```bash
rm -rf ./tmp
```

Extract the snapshot data.

```bash
./scripts/snapshot/extract.sh pos-devnet-large:v1.2.12
```

Snapshot data will be extracted to `./tmp` by default. You can change the output directory by passing it as a second argument, for example: `./scripts/snapshot/extract.sh pos-devnet-large:v1.2.12 ./dir`.

Feel free to inspect the extracted data and make any changes to the configuration files if needed.

Then, restore the devnet.

```bash
./scripts/snapshot/restore.sh
```

The script also accepts the same output directory argument as `extract.sh`, so if you extracted the snapshot to a different directory, make sure to pass that directory to `restore.sh` as well.

Monitor the logs using `docker compose`:

```bash
docker compose --file ./tmp/docker-compose.yaml logs --follow
```

Check block, checkpoint and milestone production:

```bash
echo -n "Block number: "
cast bn --rpc-url localhost:9545

echo -n "Checkpoint count: "
curl --silent localhost:1317/checkpoints/count | jq --raw-output '.ack_count'

echo -n "Milestone count: "
curl --silent localhost:1317/milestones/count | jq --raw-output '.count'
```

Tear down the devnet when you're done:

```bash
docker compose --file ./tmp/docker-compose.yaml down --volumes
```

## Create a snapshot from a kurtosis enclave

You can also create your own snapshot from a kurtosis enclave using the `snapshot` script.

### Prerequisites

Deploy a kurtosis enclave using the configuration of your choice.

```bash
kurtosis run --enclave pos --args-file .github/configs/large.yml.norun .
```

### Snapshot the enclave

The script waits for L2 to reach a certain block height, stops the enclave, generates a docker compose file and packages everything (data and configuration files) into a docker image.

```bash
./scripts/snapshot/snapshot.sh pos
```

where `pos` is the name of the enclave you want to snapshot.

Check the generated docker image.

```bash
docker images | grep pos-devnet
```

The image does not contain any shell, so it cannot be run directly. To inspect its contents, create a container and copy the files out.

```bash
tmp_dir=$(mktemp -d)
container=$(docker create pos-devnet tail -f /dev/null)
docker cp "$container:/" "$tmp_dir"
docker rm "$container"
echo "Snapshot data extracted to $tmp_dir"
```
