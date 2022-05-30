#!/usr/bin/env bash

function probe_bin_on_path() {
	local name="${1}"

	if ! type -a ${name} >/dev/null 2>&1; then
		echo "Can't find '${name}' on \$PATH" >&2
		exit 1
	fi
}

probe_bin_on_path "kubectl"
