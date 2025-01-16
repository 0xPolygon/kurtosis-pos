# Docker Images

## Polygon PoS Contract Deployer

- [Docker Hub](https://hub.docker.com/r/leovct/pos-contract-deployer)

```bash
docker build --tag leovct/pos-contract-deployer:node-16 --file pos-contract-deployer.Dockerfile .
docker push leovct/pos-contract-deployer:node-16
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
docker build --tag leovct/pos-validator-config-generator:1.0.10 --file pos-validator-config-generator.Dockerfile .
docker push leovct/pos-validator-config-generator:1.0.10
```
