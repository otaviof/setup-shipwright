#!/usr/bin/env bash
#
# Installs Shipwright Build Controller and Build-Strategies using the Makefile target.
#

set -eu -o pipefail

source common.sh

readonly REPO_NAME="build"
CLONE_DIR="."

if ! is_current_repo "${REPO_NAME}" ; then
	CLONE_DIR="${GITHUB_WORKSPACE}/src/${REPO_NAME}"
fi

cd "${CLONE_DIR}" || fail "Directory '${CLONE_DIR}' does not exit!"

echo "# Deploying Shipwright Controller (${CLONE_DIR})..."
make install-controller-kind

echo "# Waiting for Build Controller rollout..."
rollout_status "${SHIPWRIGHT_NAMESPACE}" "shipwright-build-controller"

echo "# Installing upstream Build-Strategies..."
make install-strategies
