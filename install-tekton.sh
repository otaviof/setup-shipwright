#!/usr/bin/env bash
#
# Installs Tekton Pipelines using the first argument as target version.
#

set -eu

TEKTON_VERSION="${TEKTON_VERSION:-}"

if [ -z "${TEKTON_VERSION}" ] ; then 
	echo "TEKTON_VERSION must be informed!" >&2
	exit 1
fi

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
