#!/bin/bash
set -e

# docker rm -f chaos-utils-sidecar-$NAME_PATTERN

##############################################################
# Set up container detection
##############################################################
# Variables
NETWORK="kt-pos"
NAME_PATTERN_1="l2-el-1-bor-heimdall-v2-validator--"
# NAME_PATTERN_1="l2-cl-1-heimdall-v2-bor-validator--"

TARGET_NAME_1=$(docker network inspect $NETWORK | jq -r '.[] | .Containers | to_entries[] | select(.value.Name | test("'"$NAME_PATTERN_1"'")) | .value.Name')
if [[ -z "$TARGET_NAME_1" ]]; then
  echo "Error: No container found with name matching $NAME_PATTERN_1 on network $NETWORK"
  exit 1
fi
echo "Target container name: $TARGET_NAME_1"

TARGET_ID=$(docker network inspect $NETWORK | jq -r '.[] | .Containers | to_entries[] | select(.value.Name | test("'"$NAME_PATTERN_1"'")) | .key')
if [[ -z "$TARGET_ID" ]]; then
  echo "Error: Could not get container ID for $TARGET_NAME_1"
  exit 1
fi
echo "Target container ID: $TARGET_ID"

docker rm -f chaos-utils-sidecar-$NAME_PATTERN_1

docker run --rm -d \
  --name chaos-utils-sidecar-$NAME_PATTERN_1 \
  --net=container:$TARGET_ID \
  --cap-add=NET_ADMIN --cap-add=NET_RAW \
  --sysctl net.ipv4.conf.all.rp_filter=0 \
  jhkimqd/chaos-utils:latest \
  tail -f /dev/null

# docker exec chaos-utils-sidecar-$NAME_PATTERN_1 comcast --l7-http-ports=8545,8546 --l7-http-status=418 --l7-abort-percent=90 --l7-delay=10s

# docker rm -f chaos-utils-sidecar-$NAME_PATTERN_1

##############################################################
# Set up container detection
##############################################################
# Variables
NETWORK="kt-pos"
NAME_PATTERN_2="l2-el-2-bor-heimdall-v2-validator--"
# NAME_PATTERN_2="l2-cl-2-heimdall-v2-bor-validator--"

TARGET_NAME_2=$(docker network inspect $NETWORK | jq -r '.[] | .Containers | to_entries[] | select(.value.Name | test("'"$NAME_PATTERN_2"'")) | .value.Name')
if [[ -z "$TARGET_NAME_2" ]]; then
  echo "Error: No container found with name matching $NAME_PATTERN_2 on network $NETWORK"
  exit 1
fi
echo "Target container name: $TARGET_NAME_2"

TARGET_ID=$(docker network inspect $NETWORK | jq -r '.[] | .Containers | to_entries[] | select(.value.Name | test("'"$NAME_PATTERN_2"'")) | .key')
if [[ -z "$TARGET_ID" ]]; then
  echo "Error: Could not get container ID for $TARGET_NAME_2"
  exit 1
fi
echo "Target container ID: $TARGET_ID"

docker rm -f chaos-utils-sidecar-$NAME_PATTERN_2

docker run --rm -d \
  --name chaos-utils-sidecar-$NAME_PATTERN_2 \
  --net=container:$TARGET_ID \
  --cap-add=NET_ADMIN --cap-add=NET_RAW \
  --sysctl net.ipv4.conf.all.rp_filter=0 \
  jhkimqd/chaos-utils:latest \
  tail -f /dev/null

# docker exec chaos-utils-sidecar-$NAME_PATTERN_2 comcast --l7-http-ports=8545,8546 --l7-http-status=418 --l7-abort-percent=90 --l7-delay=10s

# docker rm -f chaos-utils-sidecar-$NAME_PATTERN_2

##############################################################
# Set up container detection
##############################################################
# Variables
NETWORK="kt-pos"
NAME_PATTERN_3="l2-el-3-bor-heimdall-v2-validator--"
# NAME_PATTERN_3="l2-cl-3-heimdall-v2-bor-validator--"

TARGET_NAME_3=$(docker network inspect $NETWORK | jq -r '.[] | .Containers | to_entries[] | select(.value.Name | test("'"$NAME_PATTERN_3"'")) | .value.Name')
if [[ -z "$TARGET_NAME_3" ]]; then
  echo "Error: No container found with name matching $NAME_PATTERN_3 on network $NETWORK"
  exit 1
fi
echo "Target container name: $TARGET_NAME_3"

TARGET_ID=$(docker network inspect $NETWORK | jq -r '.[] | .Containers | to_entries[] | select(.value.Name | test("'"$NAME_PATTERN_3"'")) | .key')
if [[ -z "$TARGET_ID" ]]; then
  echo "Error: Could not get container ID for $TARGET_NAME_3"
  exit 1
fi
echo "Target container ID: $TARGET_ID"

docker rm -f chaos-utils-sidecar-$NAME_PATTERN_3

docker run --rm -d \
  --name chaos-utils-sidecar-$NAME_PATTERN_3 \
  --net=container:$TARGET_ID \
  --cap-add=NET_ADMIN --cap-add=NET_RAW \
  --sysctl net.ipv4.conf.all.rp_filter=0 \
  jhkimqd/chaos-utils:latest \
  tail -f /dev/null

# docker exec chaos-utils-sidecar-$NAME_PATTERN_3 comcast --l7-http-ports=8545,8546 --l7-http-status=418 --l7-abort-percent=90 --l7-delay=10s

##############################################################
# Helper commands
##############################################################

# docker restart $TARGET_NAME_1
# docker restart $TARGET_NAME_2
# docker restart $TARGET_NAME_3

# docker exec chaos-utils-sidecar-$NAME_PATTERN_1 comcast --l7-http-ports=1317,1318,1319 --l7-http-status=418 --l7-abort-percent=90 --l7-grpc-status=15 --l7-grpc-ports=3132 --l7-delay=10s
# docker exec chaos-utils-sidecar-$NAME_PATTERN_2 comcast --l7-http-ports=1317,1318,1319 --l7-http-status=418 --l7-abort-percent=90 --l7-grpc-status=15 --l7-grpc-ports=3132 --l7-delay=10s
# docker exec chaos-utils-sidecar-$NAME_PATTERN_3 comcast --l7-http-ports=1317,1318,1319 --l7-http-status=418 --l7-abort-percent=90 --l7-grpc-status=15 --l7-grpc-ports=3132 --l7-delay=10s

# docker exec chaos-utils-sidecar-$NAME_PATTERN_1 comcast --l7-http-ports=8545,8546,8547 --l7-http-status=408 --l7-abort-percent=100 --l7-delay=6s
# docker exec chaos-utils-sidecar-$NAME_PATTERN_2 comcast --l7-http-ports=8545,8546,8547 --l7-http-status=408 --l7-abort-percent=100 --l7-delay=6s
# docker exec chaos-utils-sidecar-$NAME_PATTERN_3 comcast --l7-http-ports=8545,8546,8547 --l7-http-status=408 --l7-abort-percent=100 --l7-delay=6s

docker exec chaos-utils-sidecar-$NAME_PATTERN_1 comcast --device=eth0 --latency=6000 --target-bw=10000 --default-bw=1000000 --packet-loss=20% --target-proto=tcp,udp,icmp --target-port=8545,8547
docker exec chaos-utils-sidecar-$NAME_PATTERN_2 comcast --device=eth0 --latency=2000 --target-bw=10000 --default-bw=1000000 --packet-loss=60% --target-proto=tcp,udp,icmp --target-port=8545,8547
docker exec chaos-utils-sidecar-$NAME_PATTERN_3 comcast --device=eth0 --latency=6000 --target-bw=10000 --default-bw=1000000 --packet-loss=20% --target-proto=tcp,udp,icmp --target-port=8545,8547

# time docker run --rm --network $NETWORK curlimages/curl:latest -v --max-time 15 http://172.16.0.31:8545/ 2>&1 | grep -E "(HTTP|503|Connection|delay|timeout)"
# time docker run --rm --network $NETWORK curlimages/curl:latest -v --max-time 15 http://172.16.0.35:8545/ 2>&1 | grep -E "(HTTP|503|Connection|delay|timeout)"
# time docker run --rm --network $NETWORK curlimages/curl:latest -v --max-time 15 http://172.16.0.39:8545/ 2>&1 | grep -E "(HTTP|503|Connection|delay|timeout)"

docker exec chaos-utils-sidecar-$NAME_PATTERN_1 comcast --stop
docker exec chaos-utils-sidecar-$NAME_PATTERN_2 comcast --stop
docker exec chaos-utils-sidecar-$NAME_PATTERN_3 comcast --stop
