#!/usr/bin/env bash
#
# Installs Shipwright Build Controller and Build-Strategies.
#

set -eu

SHIPWRIGHT_VERSION="${SHIPWRIGHT_VERSION:-}"
DEPLOYMENT_TIMEOUT="${DEPLOYMENT_TIMEOUT:-3m}"

if [ -z "${SHIPWRIGHT_VERSION}" ] ; then 
	echo "SHIPWRIGHT_VERSION must be informed!" >&2
	exit 1
fi

readonly SHIPWRIGHT_HOST="github.com"
readonly SHIPWRIGHT_HOST_PATH="shipwright-io/build/releases/download"

echo "# Deploying Shipwright Controller '${SHIPWRIGHT_VERSION}'"

if [[ ${SHIPWRIGHT_VERSION} == nightly-* ]]; then
	kubectl apply -f "https://${SHIPWRIGHT_HOST}/${SHIPWRIGHT_HOST_PATH}/nightly/${SHIPWRIGHT_VERSION}.yaml"
else
	kubectl apply -f "https://${SHIPWRIGHT_HOST}/${SHIPWRIGHT_HOST_PATH}/${SHIPWRIGHT_VERSION}/release.yaml"
fi

echo "# Waiting for Build Controller rollout..."
kubectl --namespace="shipwright-build" rollout status deployment shipwright-build-controller --timeout="${DEPLOYMENT_TIMEOUT}"

echo "# Installing upstream Build-Strategies..."

kubectl apply -f "https://${SHIPWRIGHT_HOST}/${SHIPWRIGHT_HOST_PATH}/nightly/default_strategies.yaml"
