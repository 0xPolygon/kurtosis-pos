---
sidebar_position: 4
---

# Restart clients without stopping containers

This guide will explain how to restart any CL/EL client without stopping the container. For example, you would want to stop heimdall, perform some operations in the container and then restart the client.

:::info
This guide assumes you have a running devnet, if that's not the case, you can head to the [Getting Started](../introduction/getting-started.md) section.
:::

## Heimdall

First, get a shell inside the first heimdall container.

```bash
kurtosis service shell pos l2-cl-1-heimdall-v2-bor-validator
```

Second, find the PID of the script called `container-proc-manager.sh`.

```bash
$ ps aux
PID   USER     TIME  COMMAND
    1 root      0:00 /sbin/docker-init -- sh -c cp /opt/data/genesis/genesis.js
    7 root      0:00 {container-proc-} /bin/sh /usr/local/share/container-proc-
   12 root      0:18 heimdalld start --all --bridge --rest-server --home /etc/h
   26 root      0:00 sh
   32 root      0:00 ps aux
```

In this example, the PID of the script process is 7.

Third, stop the heimdall process.

```bash
kill -s TRAP 7
```

Double-check that the process was effectively stopped.

```bash
$ ps aux
PID   USER     TIME  COMMAND
    1 root      0:00 /sbin/docker-init -- sh -c cp /opt/data/genesis/genesis.js
    7 root      0:00 {container-proc-} /bin/sh /usr/local/share/container-proc-
   26 root      0:00 sh
   33 root      0:00 tail -f /dev/null
   34 root      0:00 ps aux
```

Notice that the heimdall process with PID 12 is now gone and the container is still running. Indeed, the container proc manager script gratefully terminates the child process, heimdall, by sending a SIGTERM signal and then starts a dummy process to keep the container running.

We can now perform some operations in the container. For instance, we can clean up the database by removing stored data.

```bash
rm -r /etc/heimdall/data/*.db /etc/heimdall/data/cs.wal /etc/heimdall/data/snapshots
```

Then we can restart the heimdall process.

```bash
heimdalld start --all --bridge --rest-server --home /etc/heimdall
```

## Bor

Same procedure but with the bor client.

Get a shell inside the first bor container.

```bash
kurtosis service shell pos l2-el-1-bor-heimdall-v2-validator
```

Second, find the PID of the script called `container-proc-manager.sh`.

```bash
$ ps aux
PID   USER     TIME  COMMAND
    1 root      0:00 /sbin/docker-init -- sh -c cp /opt/data/genesis/genesis.js
    7 root      0:00 {container-proc-} /bin/sh /usr/local/share/container-proc-
   13 root      0:09 bor server --config /etc/bor/config.toml
   22 root      0:00 sh
   28 root      0:00 ps aux
```

In this example, the PID of the script process is 7.

Third, stop the heimdall process.

```bash
kill -s TRAP 7
```

Perform some operations in the containers. For instance, we can clean up the database by removing stored data.

```bash
rm -rf /var/lib/bor/bor
```

Then we can restart the bor process.

```bash
bor server --config /etc/bor/config.toml
```
