#
# Common function and variables
#

# path to the current workspace
GITHUB_WORKSPACE="${GITHUB_WORKSPACE:-.}"
# name of the organization and repository, joined by slash
GITHUB_REPOSITORY="${GITHUB_REPOSITORY:-}"

# namespace name for the container registry
REGISTRY_NAMESPACE="${REGISTRY_NAMESPACE:-registry}"
# namespace name for Tekton Pipeline controller
readonly TEKTON_NAMESPACE="tekton-pipelines"
# namespace name for Shipwright Build controller
readonly SHIPWRIGHT_NAMESPACE="shipwright-build"
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

# compares the context information shared via the environment to determine if the current repository
# is the name informed.
function is_current_repo () {
	local name="${1}"

	# when the current repository name matches the informed name
	if [ "${GITHUB_REPOSITORY#*/}" == "${name}" ] ; then
		return 0
	fi

	return 1
}
