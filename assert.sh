#!/usr/bin/env bash
#
# Assert if the changes made by this action are as expected.
#

set -eu -o pipefail

REGISTRY_NAMESPACE="${REGISTRY_NAMESPACE:-registry}"

function fail () {
	echo $* >&2
	exit 1
}

function rollout_status () {
	local namespace=${1}
	local deployment=${2}

	if ! kubectl --namespace="${namespace}" rollout status deployment "${deployment}" ; then
		fail "ERROR: '${namespace}/${deployment}' is not deployed as expected!"
	fi
}

echo "# Asserting the Container Registry rollout status..."
rollout_status "registry" "registry"

echo "# Asserting the Tekton Pipeline Controller"
rollout_status "tekton-pipelines" "tekton-pipelines-controller"

echo "# Asserting the Tekton Pipeline WebHook"
rollout_status "tekton-pipelines" "tekton-pipelines-webhook"
