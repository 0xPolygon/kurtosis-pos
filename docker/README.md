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

## Heimdall V2

- [Docker Hub](https://hub.docker.com/r/leovct/heimdall-v2)

```bash
git clone git@github.com:0xPolygon/heimdall-v2.git
pushd heimdall-v2
tag="3138e07"
git checkout "${tag}" # 06/01/2025
sed -i 's/RUN make install/RUN make heimdalld \&\& cp build\/heimdalld \/usr\/bin\/heimdalld/' Dockerfile
docker build --tag "leovct/heimdall-v2:${tag}" --file Dockerfile .
docker push "leovct/heimdall-v2:${tag}"
```
