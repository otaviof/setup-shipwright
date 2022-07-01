#!/usr/bin/env bash
#
# Installs Shipwright Build Controller and Build-Strategies using the Makefile target.
#

set -eu -o pipefail

source common.sh

CLONE_DIR="${GITHUB_WORKSPACE}/src/build"

cd "${CLONE_DIR}" || fail "Directory '${CLONE_DIR}' does not exit!"

echo "# Deploying Shipwright Controller..."
make install-controller-kind

echo "# Waiting for Build Controller rollout..."
kubectl --namespace="shipwright-build" --timeout="${DEPLOYMENT_TIMEOUT}" \
	rollout status deployment shipwright-build-controller

echo "# Installing upstream Build-Strategies..."
make install-strategies
