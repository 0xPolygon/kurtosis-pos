---
sidebar_position: 5
---

# Instant Devnets

This guide will show you how to spin up PoS devnets under 20 seconds using snapshots. This is useful for quick testing and development iterations, without having to wait for the devnet to start and reach a certain state. However, it does not provide the same level of configurability, especially at the L1 level, but it can be a great way to get started quickly.

## Restore from snapshot

We provide two snapshot types:

- **pos-devnet-small**: the environment contains an L1 chain and an L2 chain with a single heimdall-v2/bor validator. Useful for testing basic functionalities. It is based on the default configuration of the package.
- **pos-devnet-large**: the environment contains an L1 chain and an L2 chain with 5 heimdall-v2/bor validators, 2 rpc nodes (one stateless bor node, one stateful bor node) and one archive bor node. Useful for testing in a more realistic environment. It is based on `.github/configs/large.yml.norun`.

Images are hosted on GHCR. The tags correspond to the kurtosis-pos package versions, and each size ships in two images that differ only in the L1 backend:

- **`pos-devnet-<size>:<tag>`**: geth + lighthouse L1. The most realistic L1, but it only restores within minutes of being built, which is what the snapshot workflow does. The beacon chain keeps the genesis time it was built with, and a lone lighthouse with no peers never counts itself synced once the wall clock is far ahead of its head slot, so it never proposes another L1 block.
- **`pos-devnet-<size>:<tag>-anvil`**: anvil L1. Anvil has no slot clock, so this image restores at any age. Use it whenever the restore is not right after the build, for example when pinning a snapshot in CI.

Environments are snapshotted at block 128 on the L2 chain (Rio hard fork activation), which should be enough for most testing purposes.

Snapshot archives are compressed with zstd, so `extract.sh` needs the `zstd` CLI on the host (`brew install zstd` on macOS, `apt install zstd` on Debian/Ubuntu, `apk add zstd` on Alpine). `restore.sh` runs zstd inside a container and has no host dependency.

Remove any existing snapshot data.

```bash
rm -rf ./tmp
```

Extract the snapshot data.

```bash
./scripts/snapshot/extract.sh ghcr.io/0xpolygon/pos-devnet-large:v1.3.1
```

Snapshot data will be extracted to `./tmp` by default. You can change the output directory by passing it as a second argument.

Feel free to inspect the extracted data and make any changes to the configuration files if needed.

Then, restore the devnet.

```bash
./scripts/snapshot/restore.sh
```

The script also accepts the same output directory argument as `extract.sh`, so if you extracted the snapshot to a different directory, make sure to pass that directory to `restore.sh` as well.

Once the services are healthy, `restore.sh` checks that the L1 head advances within 90 seconds. If it does not, the script prints the head block and its age, then exits with an error and leaves the containers up. This is what restoring an aged geth + lighthouse image looks like: switch to the `-anvil` image of the same tag. To keep the devnet up anyway, for example to inspect L2 state only, set `POS_DEVNET_SKIP_L1_CHECK=1`:

```bash
POS_DEVNET_SKIP_L1_CHECK=1 ./scripts/snapshot/restore.sh
```

Every service gets a static address on `10.86.42.0/24`. If that range overlaps a local network, pick another `/24` with `POS_DEVNET_SUBNET_PREFIX=10.99.7 ./scripts/snapshot/restore.sh`.

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

This removes the data volumes too. `restore.sh` refuses to run while volumes of a previous devnet are still around, since it would unpack the snapshot on top of their content. Snapshots built before this change declare their volumes as `external`, which `down --volumes` leaves in place: remove those with `docker volume rm`.

## Create a snapshot from a kurtosis enclave

You can also create your own snapshot from a kurtosis enclave using the `snapshot` script.

### Prerequisites

Deploy a kurtosis enclave using the configuration of your choice.

:::warning  
Note that bor was not correctly flushing data to disk during shutdown in the past, which caused snapshots to be corrupted. This issue was fixed in [v2.6.0](https://github.com/0xPolygon/bor/releases/tag/v2.6.0). Unfortunately, the snapshots won't work with older bor versions.  
:::

```bash
kurtosis run \
    --enclave pos \
    --args-file .github/configs/large.yml.norun \
    github.com/0xPolygon/kurtosis-pos@v1.3.1
```

### Snapshot the enclave

The script waits for L2 to reach a certain block height (128, Rio HF activation block), stops the enclave, generates a docker compose file and packages everything (data and configuration files) into a docker image.

To make sure the snapshot never captures a half-finished exchange between L1 and heimdall (a checkpoint buffered but not yet submitted, an ack not yet voted, a state sync not yet recorded), the script stops the enclave in two steps:

1. It stops bor first. Without bor, heimdall cannot accept new checkpoints, but the checkpoints already in flight can still be submitted to L1 and acked, since that only needs heimdall and L1.
2. It waits until the cross-chain flows are drained, and stay so for a few heimdall blocks: no buffered checkpoint, the same checkpoint ack count and state sync count on L1 and in heimdall, and no bridge task left in rabbitmq. Only then does it stop L1, heimdall and the remaining services.

```bash
./scripts/snapshot/snapshot.sh pos
```

where `pos` is the name of the enclave you want to snapshot.

Check the generated docker image.

```bash
docker images | grep pos-devnet:latest
```

The image does not contain any shell, so it cannot be run directly. To inspect its contents, create a container and copy the files out.

```bash
tmp_dir=$(mktemp -d)
container=$(docker create pos-devnet:latest tail -f /dev/null)
docker cp "$container:/volumes/." "$tmp_dir/volumes/"
docker cp "$container:/docker-compose.yaml" "$tmp_dir/docker-compose.yaml"
docker rm "$container"
echo "Snapshot data extracted to $tmp_dir"
```
