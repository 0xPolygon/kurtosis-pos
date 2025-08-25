# Image names
POS_CONTRACTS_BRANCH := anvil-pos
POS_CONTRACTS_COMMIT_SHA := d96d592 # 2025/08/01
POS_CONTRACTS_IMAGE_NAME := pos-contract-deployer:$(POS_CONTRACTS_COMMIT_SHA)

GENESIS_CONTRACTS_BRANCH := master
GENESIS_CONTRACTS_COMMIT_SHA := 96a19dd # 2025/01/08
GENESIS_IMAGE_NAME := pos-el-genesis-builder:$(GENESIS_CONTRACTS_COMMIT_SHA)

HEIMDALL_V2_COMMIT_SHA := 0.3.0-beta # 2025/08/21
VALIDATOR_CONFIG_IMAGE_NAME := heimdall-v2:$(HEIMDALL_V2_COMMIT_SHA)

# GCR registry
GCR_REGISTRY := europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Build

.PHONY: build-all
build-all: build-pos-contract-deployer build-pos-el-genesis-builder build-pos-validator-config-generator

.PHONY: build-pos-contract-deployer
build-pos-contract-deployer: ## Build PoS contract deployer image
	docker build \
		--build-arg POS_CONTRACTS_BRANCH=$(POS_CONTRACTS_BRANCH) \
		--build-arg POS_CONTRACTS_TAG_OR_COMMIT_SHA=$(POS_CONTRACTS_COMMIT_SHA) \
		--tag $(POS_CONTRACTS_IMAGE_NAME) \
		--file pos-contract-deployer.Dockerfile \
		.

.PHONY: build-pos-el-genesis-builder
build-pos-el-genesis-builder: ## Build PoS EL genesis builder image
	docker build \
		--build-arg GENESIS_CONTRACTS_BRANCH=$(GENESIS_CONTRACTS_BRANCH) \
		--build-arg GENESIS_CONTRACTS_TAG_OR_COMMIT_SHA=$(GENESIS_CONTRACTS_COMMIT_SHA) \
		--tag $(GENESIS_IMAGE_NAME) \
		--file pos-el-genesis-builder.Dockerfile \
		.

.PHONY: build-pos-validator-config-generator
build-pos-validator-config-generator: ## Build PoS validator config generator image
	docker build \
		--build-arg HEIMDALL_V2_VERSION=$(HEIMDALL_V2_VERSION) \
		--tag $(VALIDATOR_CONFIG_IMAGE_NAME) \
		--file pos-validator-config-generator.Dockerfile \
		.

##@ Push

.PHONY: push-all
push-all: auth push-pos-contract-deployer push-pos-el-genesis-builder push-pos-validator-config-generator

auth: ## Authenticate with Google Cloud Registry
	gcloud auth login
	gcloud config set project prj-polygonlabs-devtools-dev
	gcloud auth configure-docker

.PHONY: push-pos-contract-deployer
push-pos-contract-deployer: ## Push PoS contract deployer image to GCR
	docker tag $(POS_CONTRACTS_IMAGE_NAME) $(GCR_REGISTRY)/$(POS_CONTRACTS_IMAGE_NAME)
	docker push $(GCR_REGISTRY)/$(POS_CONTRACTS_IMAGE_NAME)

.PHONY: push-pos-el-genesis-builder
push-pos-el-genesis-builder: ## Push PoS EL genesis builder image to GCR
	docker tag $(GENESIS_IMAGE_NAME) $(GCR_REGISTRY)/$(GENESIS_IMAGE_NAME)
	docker push $(GCR_REGISTRY)/$(GENESIS_IMAGE_NAME)

.PHONY: push-pos-validator-config-generator
push-pos-validator-config-generator: ## Push PoS validator config generator image to GCR
	docker tag $(VALIDATOR_CONFIG_IMAGE_NAME) $(GCR_REGISTRY)/$(VALIDATOR_CONFIG_IMAGE_NAME)
	docker push $(GCR_REGISTRY)/$(VALIDATOR_CONFIG_IMAGE_NAME)
