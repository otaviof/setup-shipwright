# GitHub Action to Install [Shipwright][shpBuild]

[![Build][useActionBadgeSVG]](https://github.com/imjasonh/setup-ko/actions/workflows/use-action.yaml)

# Usage

Example usage:

```yml
name: use-action

on:
  push:
    tags-ignore:
      - "**"
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  install-shipwright:
    name: Install Shipwright Build Controller
    runs-on: ubuntu-latest
    steps:
      # the only requirement is a Kubernetes instance available through `kubectl` command line,
      # using KinD (Kubernetes in Docker) is a practical to achieve that goal
      - uses: helm/kind-action@v1.2.0

      # setting up Shipwright and a Container Registry
      - uses: otaviof/setup-shipwright@main
        with:
          setup-registry: true
```

# Inputs

Example usage with inputs:

```yml
jobs:
  use-action:
    steps:
      - uses: otaviof/setup-shipwright@main
        with:
          tekton-version: v0.34.1
          shipwright-version: v0.9.0
```

- `tekton-version`: Tekton Pipelines controller version
- `shipwright-version`: Shipwright Build controller version
- `setup-registry`: Setup a Container Registry instance

[shpBuild]: https://github.com/shipwright-io/build
[useAction]: https://github.com/otaviof/setup-shipwright/actions/workflows/use-action.yaml
[useActionBadgeSVG]:  https://github.com/otaviof/setup-shipwright/actions/workflows/use-action.yaml/badge.svg