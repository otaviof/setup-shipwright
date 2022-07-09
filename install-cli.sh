#!/usr/bin/env bash
#
# Installs Shipwright CLI using the Makefile target.
#

set -eu -o pipefail

source common.sh

readonly REPO_NAME="cli"
CLONE_DIR="."

if ! is_current_repo "${REPO_NAME}" ; then
	CLONE_DIR="${GITHUB_WORKSPACE}/src/${REPO_NAME}"
fi

cd "${CLONE_DIR}" || fail "Directory '${CLONE_DIR}' does not exit!"

echo "# Deploying Shipwright CLI (${CLONE_DIR})..."
make install