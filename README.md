# GitHub Action to Install [Shipwright][shpBuild] (`v1`)

[![Build][useActionBadgeSVG]](https://github.com/imjasonh/setup-ko/actions/workflows/use-action.yaml)

Deploys Shipwright Build Controller, CLI and a Container Registry instance in order to perform continuous integration (CI) tests against those.

# Usage

Example usage:

```yml
jobs:
  install-shipwright:
    name: Install Shipwright Build Controller and CLI
    runs-on: ubuntu-latest
    steps:
      # using KinD to provide the Kubernetes instance and kubectl
      - uses: helm/kind-action@v1.2.0
      # golang is a required to deploy the build controller and CLI
      - uses: actions/setup-go@v3
        with:
          go-version: '1.18'
      # ko is a dependency to deploy the build controller instance
      - uses: imjasonh/setup-ko@v0.4

      # setting up Shipwright Build Controller, CLI and a Container Registry
      - uses: otaviof/setup-shipwright@v1
```

# Inputs

Example usage with inputs carrying default values:

```yml
jobs:
  use-action:
    steps:
      - uses: otaviof/setup-shipwright@v1
        with:
          tekton-version: v0.37.0
          shipwright-ref: v0.10.0
          cli-ref: v0.10.0
          setup-registry: true
```

- `tekton-version`: [Tekton Pipeline][tektonPipeline] release version 
- `shipwright-ref`: [Shipwright Build Controller][shpBuild] repository tag or SHA
- `cli-ref`: [Shipwright CLI][shpCLI] repository tag or SHA
- `setup-registry`: Setup a Container Registry instance, `true` or `false`

The Shipwright components Build Controller and CLI can be deployed using a specific commit SHA or tag, the repository employed are the defaults for those projects.

# Contributing

To run this action locally, you can use [`act`][nektosAct] as the following example:

```bash
act --secret="GITHUB_TOKEN=${GITHUB_TOKEN}"
```

Note the `GITHUB_TOKEN` secret informed, a read-only type of authorization token is needed to clone additional GitHub repositories.

[shpBuild]: https://github.com/shipwright-io/build
[shpCLI]: https://github.com/shipwright-io/cli
[useAction]: https://github.com/otaviof/setup-shipwright/actions/workflows/use-action.yaml
[useActionBadgeSVG]:  https://github.com/otaviof/setup-shipwright/actions/workflows/use-action.yaml/badge.svg
[tektonPipeline]: https://github.com/tektoncd/pipeline
[nektosAct]: https://github.com/nektos/act