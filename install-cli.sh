#!/usr/bin/env bash
#
# Installs Shipwright CLI using the Makefile target.
#

set -eu -o pipefail

GITHUB_WORKSPACE="${GITHUB_WORKSPACE:-.}"
CLONE_DIR="${GITHUB_WORKSPACE}/src/build"

function fail () {
	echo "ERROR: ${*}" >&2
	exit 1
}

cd "${CLONE_DIR}" || fail "Directory '${CLONE_DIR}' does not exit!"

echo "# Deploying Shipwright CLI..."
make install