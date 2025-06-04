---
sidebar_position: 6
---

# Contributing

Thank you for your interest in contributing to the Polygon PoS Kurtosis package!

This guide will help you get started quickly. For more details, see the [full documentation](./introduction.md).

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
kurtosis lint .
```

### Testing

Run bridge tests:

```bash
kurtosis service exec pos test-runner "bats --filter-tags pos,bridge,matic,pol --recursive tests/"
```

### Documentation

To build the docs:

```bash
cd docs
npm run build
```

To preview docs locally:

```bash
npm run start
```

Then visit http://localhost:3000.

## Need Help?

- Open an [issue](https://github.com/0xPolygon/kurtosis-polygon-pos/issues).
