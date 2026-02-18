#!/bin/bash

set -uo pipefail

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  echo "Usage: FLUX_SYNC_REF=refs/heads/<branch> FLUX_SYNC_PATH=clusters/<env>/<cluster> ./INSTALL_FLUX.sh"
  exit 0
fi

: "${FLUX_SYNC_REF:?Set FLUX_SYNC_REF, e.g. refs/heads/my-branch}"
: "${FLUX_SYNC_PATH:?Set FLUX_SYNC_PATH, e.g. clusters/dev/moose}"

helm upgrade --install flux-operator oci://ghcr.io/controlplaneio-fluxcd/charts/flux-operator --namespace flux-system --create-namespace --wait 

envsubst < ./fluxinstance.tmpl.yaml | kubectl apply -f -
