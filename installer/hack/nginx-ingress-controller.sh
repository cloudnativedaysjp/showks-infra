#!/bin/bash -e

VERSION=${1:-0.25.0}
REMOTE="https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-${VERSION}/deploy/static/"

mkdir -p ./staging/nginx-ingress-controller

curl -s -L ${REMOTE}/mandatory.yaml | sed 's/namespace: ingress-nginx/namespace: showks-system/' > ./staging/nginx-ingress-controller/mandatory.yaml
curl -s -L ${REMOTE}/provider/cloud-generic.yaml | sed '
    /namespace: ingress-nginx/ s/namespace: ingress-nginx/namespace: showks-system/g
    /externalTrafficPolicy: Local/ s/externalTrafficPolicy: Local/#externalTrafficPolicy: Local/g
' > ./staging/nginx-ingress-controller/cloud-generic.yaml

# ssl
TLS_CRT=$(cat ./cert/tls.crt | base64)
TLS_KEY=$(cat ./cert/tls.key | base64)

cat ./hack/manifests/nginx-ingress-controller/tls.yaml | sed -e "
/__TLS_CRT__/  s/__TLS_CRT__/${TLS_CRT}/g
/__TLS_KEY__/  s/__TLS_KEY__/${TLS_KEY}/g
" > ./staging/nginx-ingress-controller/tls.yaml
