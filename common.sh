#
# Common function and variables
#

# path to the current workspace
GITHUB_WORKSPACE="${GITHUB_WORKSPACE:-.}"
# namespace name for the container registry
REGISTRY_NAMESPACE="${REGISTRY_NAMESPACE:-registry}"
# timeout employed during rollout status and deployments in general
DEPLOYMENT_TIMEOUT="${DEPLOYMENT_TIMEOUT:-3m}"

# print error message and exit on error.
function fail () {
	echo "ERROR: ${*}" >&2
	exit 1
}

# uses kubectl to check the deployment status on namespace and name informed.
function rollout_status () {
	local namespace="${1}"
	local deployment="${2}"

	if ! kubectl --namespace="${namespace}" --timeout=${DEPLOYMENT_TIMEOUT} \
			rollout status deployment "${deployment}" ; then
		fail "'${namespace}/${deployment}' is not deployed as expected!"
	fi
}

# inspect the path after the informed executable name.
function probe_bin_on_path() {
	local name="${1}"

	if ! type -a ${name} >/dev/null 2>&1; then
		fail "Can't find '${name}' on \$PATH"
	fi
}
