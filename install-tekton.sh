#!/usr/bin/env bash
#
# Installs Tekton Pipelines using the first argument as target version.
#

set -eu

TEKTON_VERSION="${1:-v0.34.1}"

readonly TEKTON_HOST="github.com"
readonly TEKTON_HOST_PATH="tektoncd/pipeline/releases/download"

function rollout_status () {
	kubectl --namespace="tekton-pipelines" rollout status deployment ${1} --timeout=1m
}

echo "# Deploying Tekton Pipelines '${TEKTON_VERSION}'"

kubectl apply -f "https://${TEKTON_HOST}/${TEKTON_HOST_PATH}/${TEKTON_VERSION}/release.yaml"

echo "# Waiting for Tekton components..."

rollout_status "tekton-pipelines-controller"
rollout_status "tekton-pipelines-webhook"
