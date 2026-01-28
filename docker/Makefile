# Image names
POS_CONTRACTS_BRANCH := anvil-pos
POS_CONTRACTS_COMMIT_SHA := d96d592 # 2025/08/01
POS_CONTRACT_DEPLOYER_IMAGE_NAME := pos-contract-deployer:$(POS_CONTRACTS_COMMIT_SHA)

GENESIS_CONTRACTS_BRANCH := master
GENESIS_CONTRACTS_COMMIT_SHA := 96a19dd # 2025/01/08

HEIMDALL_V2_VERSION := 0.6.0 # 2026/01/23
POS_VALIDATOR_CONFIG_IMAGE_NAME := pos-validator-config-generator:$(HEIMDALL_V2_VERSION)

# GCR registry
GCR_REGISTRY := europe-west2-docker.pkg.dev/prj-polygonlabs-devtools-dev/public

.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Build

.PHONY: build-pos-contract-deployer
build-pos-contract-deployer: ## Build PoS contract deployer image
	docker build \
		--build-arg POS_CONTRACTS_BRANCH=$(POS_CONTRACTS_BRANCH) \
		--build-arg POS_CONTRACTS_TAG_OR_COMMIT_SHA=$(POS_CONTRACTS_COMMIT_SHA) \
		--tag $(POS_CONTRACT_DEPLOYER_IMAGE_NAME) \
		--file pos-contract-deployer.Dockerfile \
		.

.PHONY: build-pos-validator-config-generator
build-pos-validator-config-generator: ## Build PoS validator config generator image
	docker build \
		--build-arg HEIMDALL_V2_VERSION=$(HEIMDALL_V2_VERSION) \
		--tag $(POS_VALIDATOR_CONFIG_IMAGE_NAME) \
		--file pos-validator-config-generator.Dockerfile \
		.

##@ Push

auth: ## Authenticate with Google Cloud Registry
	gcloud auth login
	gcloud config set project prj-polygonlabs-devtools-dev
	gcloud auth configure-docker europe-west2-docker.pkg.dev

.PHONY: push-pos-contract-deployer
push-pos-contract-deployer: ## Push PoS contract deployer image to GCR
	docker tag $(POS_CONTRACT_DEPLOYER_IMAGE_NAME) $(GCR_REGISTRY)/$(POS_CONTRACT_DEPLOYER_IMAGE_NAME)
	docker push $(GCR_REGISTRY)/$(POS_CONTRACT_DEPLOYER_IMAGE_NAME)

.PHONY: push-pos-validator-config-generator
push-pos-validator-config-generator: ## Push PoS validator config generator image to GCR
	docker tag $(POS_VALIDATOR_CONFIG_IMAGE_NAME) $(GCR_REGISTRY)/$(POS_VALIDATOR_CONFIG_IMAGE_NAME)
	docker push $(GCR_REGISTRY)/$(POS_VALIDATOR_CONFIG_IMAGE_NAME)
