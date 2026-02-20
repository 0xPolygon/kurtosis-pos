---
sidebar_position: 5
---

# Instant Devnets

This guide will show you how to spin up PoS devnets in a few seconds using `docker-compose` instead of `kurtosis`. This is useful for quick testing and development iterations. It does not provide the same level of configurability, especially at the L1 level, but it can be a great way to get started quickly.

## Restore a devnet from a snapshot

For this example, we will use a snapshot of a PoS devnet, deployed using the kurtosis-pos package and this configuration (TODO: explain or link). It includes 7 validator nodes (heimdall-v2/bor), 3 rpcs nodes (including an heimdall-v2/erigon node) and an archive node.

Remove any existing snapshot data. You may need to use `sudo`.

```bash
rm -rf ./tmp
```

Extract the snapshot data.

```bash
./extract.sh
```

Snapshot data will be extracted to `./tmp` by default. You can change the output directory by passing a different path to the script, for example: `./extract.sh ./dir`.

Feel free to inspect the extracted data and make any changes to the configuration files if needed.

Then, restore the devnet.

```bash
./restore.sh
```

The script also accepts the same output directory argument as `extract.sh`, so if you extracted the snapshot to a different directory, make sure to pass that directory to `restore.sh` as well.

Monitor the logs using `docker-compose`:

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

You can create your own snapshot from a running kurtosis enclave using the `snapshot` script. This is useful if you want to create a snapshot with a specific configuration or state.

Deploy a kurtosis enclave using the kurtosis-pos package and the configuration of your choice. For this example, we will use the rio configuration.

```bash
kurtosis run --enclave pos --args-file .github/configs/large.yml.norun .
```

Snapshot the enclave.

Make sure to replace `pos` with the name of your enclave if it's different.

```bash
./snapshot.sh pos
```

Check the generated docker image.

```bash
$ docker images | grep pos-devnet
```

