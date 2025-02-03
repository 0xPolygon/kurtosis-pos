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
heimdall_version="1.2.0"
heimdall_v2_version="8daff4c"
tag="${heimdall_version}-${heimdall_v2_version}"
docker build \
  --build-arg HEIMDALL_VERSION="${heimdall_version}" \
  --build-arg HEIMDALL_V2_VERSION="${heimdall_v2_version}" \
  --tag "leovct/pos-validator-config-generator:${tag}" \
  --file pos-validator-config-generator.Dockerfile \
  .
docker push "leovct/pos-validator-config-generator:${tag}"
```

## Heimdall V2

Docker Hub:

- [heimdall-v2](https://hub.docker.com/r/leovct/heimdall-v2)
- [bor-modified-for-heimdall-v2](https://hub.docker.com/r/leovct/bor-modified-for-heimdall-v2)

```bash
# heimdall-v2
git clone git@github.com:0xPolygon/heimdall-v2.git
pushd heimdall-v2
tag="8daff4c" # 03/02/2025
git checkout "${tag}"
sed -i 's/RUN make install/RUN make heimdalld \&\& cp build\/heimdalld \/usr\/bin\/heimdalld/' Dockerfile
docker build --tag "leovct/heimdall-v2:${tag}" --file Dockerfile .
docker push "leovct/heimdall-v2:${tag}"

# bor-modified-for-heimdall-v2
git clone --branch raneet10/heimdallv2-changes git@github.com:maticnetwork/bor.git
pushd bor
tag="e5bf9cc" # 24/01/2025
git checkout "${tag}"
patch -p1 < ../bor-modified-for-heimdall-v2.patch

eval $(ssh-agent -s)
ssh-add $HOME/.ssh/id_ed25519
docker build \
  --tag "leovct/bor-modified-for-heimdall-v2:${tag}" \
  --file Dockerfile \
  --ssh default=$SSH_AUTH_SOCK \
  .
docker push "leovct/bor-modified-for-heimdall-v2:${tag}"
```
