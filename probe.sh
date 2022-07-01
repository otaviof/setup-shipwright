#!/usr/bin/env bash
#
# Inspect the instance to make sure the dependencies needed are in place.
#

set -eu -o pipefail

function fail () {
	echo "ERROR: ${*}" >&2
	exit 1
}

function probe_bin_on_path() {
	local name="${1}"

	if ! type -a ${name} >/dev/null 2>&1; then
		fail "Can't find '${name}' on \$PATH"
	fi
}

probe_bin_on_path "kubectl"

if ! kubectl version >/dev/null 2>&1 ; then 
	fail "'kubectl version' fails to report server version"
fi

probe_bin_on_path "go"
probe_bin_on_path "ko"
