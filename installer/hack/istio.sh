#!/bin/bash -e

VERSION=${1:-1.2.2}
REMOTE="https://raw.githubusercontent.com/istio/istio/${VERSION}/install/kubernetes/helm/istio-init/files/"

mkdir -p ./staging/istio

for f in crd-10.yaml crd-11.yaml crd-12.yaml crd-certmanager-10.yaml crd-certmanager-11.yaml
do
	curl -s -L -o ./staging/istio/${f} ${REMOTE}/${f}
done
