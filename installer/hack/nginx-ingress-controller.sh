#!/bin/bash -e

VERSION=${1:-0.25.0}
REMOTE="https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-${VERSION}/deploy/static/"

mkdir -p ./staging/nginx-ingress-controller

curl -s -L ${REMOTE}/mandatory.yaml | sed 's/namespace: ingress-nginx/namespace: showks-system/' > ./staging/nginx-ingress-controller/mandatory.yaml
curl -s -L ${REMOTE}/provider/cloud-generic.yaml | sed '
    /namespace: ingress-nginx/ s/namespace: ingress-nginx/namespace: showks-system/g
    /externalTrafficPolicy: Local/ s/externalTrafficPolicy: Local/#externalTrafficPolicy: Local/g
' > ./staging/nginx-ingress-controller/cloud-generic.yaml
