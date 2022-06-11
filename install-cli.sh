#!/usr/bin/env bash
#
# Download and install Shipwright CLI.
#

set -eu -o pipefail

SHIPWRIGHT_VERSION="${SHIPWRIGHT_VERSION:-}"

if [ -z "${SHIPWRIGHT_VERSION}" ] ; then 
	echo "SHIPWRIGHT_VERSION must be informed!" >&2
	exit 1
fi

readonly SHIPWRIGHT_HOST="github.com"
readonly SHIPWRIGHT_HOST_PATH="shipwright-io/cli/releases/download"

echo "# Deploying Shipwright CLI '${SHIPWRIGHT_VERSION}'"

TARBALL="cli_${SHIPWRIGHT_VERSION#"v"}_linux_x86_64.tar.gz"
DOWNLOAD_URL="https://${SHIPWRIGHT_HOST}/${SHIPWRIGHT_HOST_PATH}/${SHIPWRIGHT_VERSION}/${TARBALL}"

echo "# Installing Shipwright CLI from: '${DOWNLOAD_URL}'"

readonly PREFIX="/usr/local/bin"
readonly BIN="shp"

BIN_PATH="${PREFIX}/${BIN}"

curl --fail --silent --location "${DOWNLOAD_URL}" |sudo tar xzpf - -C ${PREFIX} ${BIN}
sudo chown root:root "${BIN_PATH}"

echo "# CLI is installed at: '${BIN_PATH}'"
