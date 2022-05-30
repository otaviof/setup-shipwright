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
  use-action:
    name: Install Shipwright Build Controller
    runs-on: ubuntu-latest
    steps:
      - uses: helm/kind-action@v1.2.0
      - uses: azure/setup-kubectl@v1

      - uses: otaviof/setup-shipwright@main
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

[shpBuild]: https://github.com/shipwright-io/build
[useAction]: https://github.com/otaviof/setup-shipwright/actions/workflows/use-action.yaml
[useActionBadgeSVG]:  https://github.com/otaviof/setup-shipwright/actions/workflows/use-action.yaml/badge.svg