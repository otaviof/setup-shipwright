#!/usr/bin/env bash
#
# Installs Shipwright CLI using the Makefile target.
#

set -eu -o pipefail

source common.sh

CLONE_DIR="${GITHUB_WORKSPACE}/src/build"

cd "${CLONE_DIR}" || fail "Directory '${CLONE_DIR}' does not exit!"

echo "# Deploying Shipwright CLI..."
make install