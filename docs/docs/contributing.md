---
sidebar_position: 6
---

# Contributing

Thank you for your interest in contributing to the package!

This guide will help you get started quickly. For more details, see the [full documentation](./introduction/overview.md).

## How to Contribute

- Fork and clone the repository.
- Create a feature or fix branch.
- Make your changes and add tests if needed.
- Run linter, tests, and build docs if changed.
- Open a pull request with a clear description.
- Ensure CI passes before requesting review.

### Linting

Run Kurtosis linter:

```bash
kurtosis lint --format .
```

### Testing

E2e tests live in [`0xPolygon/pos-e2e`](https://github.com/0xPolygon/pos-e2e). Clone it and run bats against your devnet:

```bash
git clone https://github.com/0xPolygon/pos-e2e.git
cd pos-e2e
bats --filter-tags pos,bridge --recursive tests/
```

See [Run Bridge Tests](./guides/run-bridge-tests.md) for the full bridge + withdraw flow.

### Documentation

To build the docs:

```bash
cd docs
npm run build
```

To preview docs locally:

```bash
npm run serve
```

Then visit http://localhost:3000.

## Need Help?

- Check the [full documentation](./introduction/overview.md).
- Open an [issue](https://github.com/0xPolygon/kurtosis-pos/issues/new).
