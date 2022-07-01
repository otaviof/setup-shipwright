#!/usr/bin/env bash
#
# Assert the changes made by this action.
#

set -eu -o pipefail

source common.sh

echo "# Asserting the Container Registry rollout status..."
rollout_status "${REGISTRY_NAMESPACE}" "registry"

echo "# Asserting the Tekton Pipeline Controller"
rollout_status "tekton-pipelines" "tekton-pipelines-controller"

echo "# Asserting the Tekton Pipeline WebHook"
rollout_status "tekton-pipelines" "tekton-pipelines-webhook"

echo "# Asserting the Shipwright Build Controller"
rollout_status "shipwright-build" "shipwright-build-controller"

echo "# Asserting the CLI (shp) is installed"
probe_bin_on_path "shp"
