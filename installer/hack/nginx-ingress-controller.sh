#!/bin/bash -e

VERSION=${1:-0.25.0}
REMOTE="https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-${VERSION}/deploy/static/mandatory.yaml"

mkdir -p ./staging/nginx-ingress-controller

curl -s -L ${REMOTE} | sed 's/namespace: ingress-nginx/namespace: showks-system/' > ./staging/nginx-ingress-controller/mandatory.yaml
cp ./hack/manifests/nginx-ingress-controller/* ./staging/nginx-ingress-controller/.
