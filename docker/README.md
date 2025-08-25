# Docker Images

To push images to the Google Cloud registry, you can follow these steps:

1. Authenticate with GCR using your Google account

```bash
gcloud auth login
gcloud config set project prj-polygonlabs-devtools-dev
gcloud auth configure-docker
```

2. Push the image to GCR.

```bash
gcr_registry="europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public"
gcp_image_name="${gcr_registry}/${image_name}"
docker tag "${image_name}" "${gcp_image_name}"
docker push "${gcp_image_name}"
```

## Utility Images

### Polygon PoS Contract Deployer

```bash
pos_contracts_branch="anvil-pos"
pos_contracts_commit_sha="d96d592" # 2025/08/01
image_name="pos-contract-deployer:${pos_contracts_commit_sha}"
docker build \
  --build-arg POS_CONTRACTS_BRANCH="${pos_contracts_branch}" \
  --build-arg POS_CONTRACTS_TAG_OR_COMMIT_SHA="${pos_contracts_commit_sha}" \
  --tag "${image_name}" \
  --file pos-contract-deployer.Dockerfile \
  .
```

### Polygon PoS EL Genesis Builder

```bash
genesis_contracts_branch="master"
genesis_contracts_commit_sha="96a19dd" # 2025/01/08
image_name="pos-el-genesis-builder:${genesis_contracts_commit_sha}"
docker build \
  --build-arg GENESIS_CONTRACTS_BRANCH="${genesis_contracts_branch}" \
  --build-arg GENESIS_CONTRACTS_TAG_OR_COMMIT_SHA="${genesis_contracts_commit_sha}" \
  --tag "${image_name}" \
  --file pos-el-genesis-builder.Dockerfile \
  .
```

Note: We do not use the latest version of the [genesis contracts](https://github.com/0xPolygon/genesis-contracts), `244bc6a`, released on 2025/03/13, because it introduces a breaking change. The `StateReceiver` contract requires solc `0.6.12`, while all other contracts still rely on solc `0.5.17`. As a result, when generating the EL genesis, it attempts to compile all the contracts, including the `StateReceiver`. Since we only install solc `0.5.17` in the `pos-el-genesis-builder` image, the compilation fails. Removing the compilation of the `StateReceiver` contract does not work because the EL genesis alloc section will be incorrect for contract `0000000000000000000000000000000000001001`, as the code will be `0x`. Therefore, we opted to use a previous version, `96a19dd`, released on 2025/01/08.

### Polygon PoS Validator Config Generator

```bash
heimdall_v2_version="0.3.0-beta" # 2025/08/21
image_name="pos-validator-config-generator:${heimdall_v2_version}"
docker build \
  --build-arg HEIMDALL_V2_VERSION="${heimdall_v2_version}" \
  --tag "${image_name}" \
  --file pos-validator-config-generator.Dockerfile \
  .
```
