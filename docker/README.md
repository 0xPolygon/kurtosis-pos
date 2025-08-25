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

## Client Images

### Bor Modified for Heimdall v2

```bash
bor_branch="v2.2.9-fix"
bor_commit_sha="fad6a09" # 2025/07/17
image_name="bor:${bor_branch}-fix"
git clone --branch "${bor_branch}" git@github.com:leovct/bor.git

pushd bor
git checkout "${bor_commit_sha}"
docker build --tag "${image_name}" .
docker push "${image_name}"
popd
```

Note that we use a slightly modified version of Bor to address startup deadlocks that occurred with Heimdall v2 devnets in our CI deployments.

#### What Was Happening

- Node 1 was failing to start, getting stuck in an infinite loop of "Error while fetching heimdallv1 span: response code 501".
- Node 2 was starting successfully, properly detecting Heimdall v2 and switching to v2 APIs.
- The "Starting Heimdall migration monitor" log never appeared in Node 1, indicating it never reached that startup phase.

For reference, check [node1.log](./node1.log) and [node2.log](./node2.log).

#### Root Cause Analysis

1. Circular dependency: During Bor node startup, the backend creation (`eth.New()`) immediately initializes the Bor consensus engine.
2. Early span requirement: The consensus engine creates a span store that may need span data during initialization.
3. Wrong API version: The span store defaults to IsHeimdallV2 = false`, so it tries v1 APIs first.
4. Heimdall v2 rejection: Heimdall v2 returns HTTP 501 for v1 API calls (not implemented).
5. Infinite retry: The span fetching retry mechanism kept trying v1 APIs every 5 seconds indefinitely.
6. Blocked startup: This prevented the startup process from progressing to the Heimdall migration monitor that would detect v2.

#### Solution: Self-Healing Span Store

Instead of trying to coordinate startup timing, we made the span store automatically detect the correct Heimdall version:

```go
// Check if error indicates Heimdall v2 (501 response for v1 API)
if strings.HasSuffix(err.Error(), "response code 501") {
    log.Info("Detected Heimdall v2 from 501 response, switching to v2 API")
    hmm.IsHeimdallV2 = true
    // Let the retry logic handle this with v2 API
    return false
}
```

Location: `consensus/bor/span_store.go:147-152`

#### How It Works

1. Node starts up and span store tries v1 API (default behavior).
2. Gets 501 error from Heimdall v2.
3. Automatically detects this means Heimdall v2 and sets the flag.
4. Retries with v2 API and succeeds.
5. Normal startup continues.

#### Why This Is Better

- Eliminates race conditions between migration monitor and span fetching
- Self-healing - works regardless of startup timing
- Minimal code change - no complex startup coordination needed
- Robust - handles the version detection at the point where it's needed

The key insight was that the 501 error itself is a reliable indicator that we're talking to Heimdall v2, so we can use it for automatic detection rather than relying on a separate migration monitor to run first.
