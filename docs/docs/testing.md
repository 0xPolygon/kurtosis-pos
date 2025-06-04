---
sidebar_position: 4
---

# Testing

Most of our tests live in the [agglayer/e2e](https://github.com/agglayer/e2e) repository.

To make sure our devnets are working, we run some bridge tests from L1 to L2.

```bash
git clone https://github.com/agglayer/e2e.git
cd e2e
bats --filter-tags pos,bridge,matic,pol --recursive tests/
```
