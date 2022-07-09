# Setup [Shipwright Build][shpBuild] and [CLI][shpCLI] (`v2`)

[![Build][useActionBadgeSVG]][useAction]

Deploys [Shipwright Build Controller][shpBuild], [CLI][shpCLI] and optionally a Container Registry instance, to perform continuous integration (CI) tests on the [`shipwright-io` projects][shpGitHubOrg].

# Usage

This action needs `go` and `ko` and a Kubernetes instance (available through `kubectl`), make sure those items are set beforehand. The following snippet shows the complete usage, please consider:

```yml
jobs:
  setup-shipwright:
    name: Shipwright
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
      - uses: otaviof/setup-shipwright@v2
```

## Inputs

Example usage using defaults:

```yml
jobs:
  use-action:
    steps:
      - uses: otaviof/setup-shipwright@v2
        with:
          tekton-version: v0.37.0
          shipwright-ref: v0.10.0
          cli-ref: v0.10.0
          setup-registry: true
```

The inputs are described below:

| Input             | Default   | Description                                                   |
|-------------------|-----------|---------------------------------------------------------------|
| `tekton-version`  | `v0.37.0` | [Tekton Pipeline][tektonPipeline] release version             |
| `shipwright-ref`  | `v0.10.0` | [Shipwright Build Controller][shpBuild] repository tag or SHA |
| `cli-ref`         | `v0.10.0` | [Shipwright CLI][shpCLI] repository tag or SHA                |
| `setup-registry`  | `true`    | Setup a Container Registry instance (`true` or `false`)       |

The Shipwright components [Build Controller][shpBuild] and [CLI][shpCLI] can be deployed using a specific commit SHA or tag.

## Inside Shipwright Organization

This action inspects the current context before checking out the [Build Controller][shpBuild] and the [CLI][shpCLI] repositories, so when it's being executed against forks or the actual repositories, the action uses the local data.

In other words, this action only performs the remote repository checkout, and therefore can be employed on the [`shipwright-io` organization][shpGitHubOrg] and as well repository forks you're working on.

# Contributing

To run this action locally, you can use [`act`][nektosAct] as the following example:

```bash
act --secret="GITHUB_TOKEN=${GITHUB_TOKEN}"
```

The `GITHUB_TOKEN` is necessary for checking out the upstream repositories in the action workspace, and for this purpose the token only needs read-only permissions on the [`shipwright-io` organization][shpGitHubOrg]. The token is provided by default during GitHub Action execution inside GitHub.

## Troubleshooting

This action uses [KinD][kind] to instantiate a temporary Kubernetes and test itself against it, thus if you're using the same setup make sure there are no clusters left behind before running the action again.

```bash
kind delete cluster
```

When tests fail, you can use the context provided by KinD to connect on cluster, and then you're free to inspect all the components, logs, events, etc. For instance:

```bash
kind export kubeconfig
```

Once you set up the context you are able to inspect, for example, the Build controller logs.

```
kubectl --namespace=shipwright-build get pods
kubectl --namespace=shipwright-build logs --follow shipwright-build-controller-xxxxxxx
```

[kind]: https://kind.sigs.k8s.io/
[nektosAct]: https://github.com/nektos/act
[shpBuild]: https://github.com/shipwright-io/build
[shpCLI]: https://github.com/shipwright-io/cli
[shpGitHubOrg]: https://github.com/shipwright-io/build
[tektonPipeline]: https://github.com/tektoncd/pipeline
[useAction]: https://github.com/otaviof/setup-shipwright/actions/workflows/use-action.yaml
[useActionBadgeSVG]:  https://github.com/otaviof/setup-shipwright/actions/workflows/use-action.yaml/badge.svg