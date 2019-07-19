#!/bin/bash -e

mkdir -p ./staging/tekton

# copy from hack
cp ./hack/manifests/tekton/* ./staging/tekton/.

#VERSION=${1:-0.4.0}
#REMOTE="https://github.com/tektoncd/pipeline/releases/download/v${VERSION}/release.yaml"
#DASHBOARD="https://github.com/tektoncd/dashboard/releases/download/v0/gcr-tekton-dashboard.yaml"

#curl -s -L ${REMOTE} | sed 's/namespace: tekton-pipelines/namespace: showks-system/' > ./staging/tekton/release.yaml
#curl -s -L ${DASHBOARD} | sed 's/namespace: tekton-pipelines/namespace: showks-system/' > ./staging/tekton/gcr-tekton-dashboard.yaml

