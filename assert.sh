#!/usr/bin/env bash
#
# Assert the changes made by this action.
#

set -eu -o pipefail

REGISTRY_NAMESPACE="${REGISTRY_NAMESPACE:-registry}"

function fail () {
	echo "ERROR: ${*}" >&2
	exit 1
}

function rollout_status () {
	local namespace=${1}
	local deployment=${2}

	if ! kubectl --namespace="${namespace}" rollout status deployment "${deployment}" ; then
		fail "'${namespace}/${deployment}' is not deployed as expected!"
	fi
}

echo "# Asserting the Container Registry rollout status..."
rollout_status "registry" "registry"

echo "# Asserting the Tekton Pipeline Controller"
rollout_status "tekton-pipelines" "tekton-pipelines-controller"

echo "# Asserting the Tekton Pipeline WebHook"
rollout_status "tekton-pipelines" "tekton-pipelines-webhook"

echo "# Asserting the Shipwright Build Controller"
rollout_status "shipwright-build" "shipwright-build-controller"

echo "# Asserting the CLI (shp) is installed"
if ! type -a shp >/dev/null 2>&1; then
	fail "Can't find 'shp' on \$PATH"
fi
