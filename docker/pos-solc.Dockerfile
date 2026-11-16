FROM debian:bookworm-slim AS solidity-builder
LABEL description="Old solc releases built for linux/amd64 and linux/arm64"
LABEL author="devtools@polygon.technology"

# The solc versions generate-genesis.js compiles with. These old releases ship no
# linux/arm64 binary, so they are built from source on every platform. This image
# only holds the binaries (/opt/solc/solc-<version>) so that other images can copy them
# instead of rebuilding them.
# gcc 12 breaks these sources: they build with -Werror, which fails on its new
# warnings, and some headers miss the <limits> include its libstdc++ no longer pulls in.
# The version string ends up in the bytecode metadata hash. An empty prerelease.txt
# drops the build date, and commit_hash.txt skips the dirty tree check that would add
# ".mod" after the -Werror edit, so the bytecode matches the official binaries.
ENV SOLIDITY_VERSIONS="0.5.17 0.6.12"

WORKDIR /opt/solidity
RUN apt-get update \
  && apt-get install --yes cmake g++ git libboost-all-dev make \
  && for version in ${SOLIDITY_VERSIONS}; do \
    git clone --branch "v${version}" --depth 1 https://github.com/ethereum/solidity.git "${version}" \
    && cd "${version}" \
    && touch prerelease.txt \
    && git rev-parse --short=8 HEAD > commit_hash.txt \
    && grep -rl -- '-Werror' cmake CMakeLists.txt | xargs sed -i 's/-Werror//g' \
    && cmake -S . -B build -DUSE_Z3=OFF -DUSE_CVC4=OFF -DTESTS=OFF -DCMAKE_CXX_FLAGS="-include limits" \
    && cmake --build build --target solc --parallel "$(nproc)" \
    && install -D build/solc/solc "/opt/solc/solc-${version}" \
    && cd .. \
    || exit 1; \
  done


FROM scratch
LABEL description="Solidity compilers used to generate the PoS genesis"
LABEL author="devtools@polygon.technology"
COPY --from=solidity-builder /opt/solc/ /opt/solc/
