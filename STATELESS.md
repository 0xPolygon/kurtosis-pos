# Stateless Node Testing

## 1. Build Local Docker Images

### Bor

```bash
bor_branch="stateless_sync"
bor_commit_sha="5e4bde2" # 2025/06/24
image_name="local/bor:${bor_commit_sha}"
git clone --branch "${bor_branch}" git@github.com:maticnetwork/bor.git
pushd bor
git checkout "${bor_commit_sha}"
docker build --tag "${image_name}" .
popd
```

### Heimdall v2

```bash
heimdall_v2_branch="stateless_sync"
heimdall_v2_commit_sha="52224d7" # 2025/06/25
image_name="local/heimdall-v2:${heimdall_v2_commit_sha}"
git clone --branch "${heimdall_v2_branch}" git@github.com:0xPolygon/heimdall-v2.git
pushd heimdall_v2
git checkout "${heimdall_v2_commit_sha}"
docker build --tag "${image_name}" .
popd
```

## 2. Deploy a Devnet

```bash
kurtosis run --enclave pos --args-file stateless.yml .
```
