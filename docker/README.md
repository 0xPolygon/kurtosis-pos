# Docker Images

## Polygon PoS Contract Deployer

- [Docker Hub](https://hub.docker.com/r/leovct/pos-contract-deployer)

```bash
# node-16
docker build --tag leovct/pos-contract-deployer:node-16 --file pos-contract-deployer-node-16.Dockerfile .
docker push leovct/pos-contract-deployer:node-16

# node-20
docker build --tag leovct/pos-contract-deployer:node-20 --file pos-contract-deployer-node-20.Dockerfile .
docker push leovct/pos-contract-deployer:node-20
```

## Polygon PoS EL Genesis Builder

- [Docker Hub](https://hub.docker.com/r/leovct/pos-el-genesis-builder)

```bash
docker build --tag leovct/pos-el-genesis-builder:node-16 --file pos-el-genesis-builder.Dockerfile .
docker push leovct/pos-el-genesis-builder:node-16
```

## Polygon PoS Validator Config Generator

- [Docker Hub](https://hub.docker.com/r/leovct/pos-validator-config-generator)

```bash
heimdall_version="1.2.0"
heimdall_v2_version="22a3f1d"
tag="${heimdall_version}-${heimdall_v2_version}"
docker build \
  --build-arg HEIMDALL_VERSION="${heimdall_version}" \
  --build-arg HEIMDALL_V2_VERSION="${heimdall_v2_version}" \
  --tag "leovct/pos-validator-config-generator:${tag}" \
  --file pos-validator-config-generator.Dockerfile \
  .
docker push "leovct/pos-validator-config-generator:${tag}"
```
