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
mkdir -p ./staging/ingress/cmn
mkdir -p ./staging/ingress/prod
mkdir -p ./staging/ingress/stg

CMN_TLS_CRT=$(cat ./cert/${CMN_DOMAIN}.crt | base64)
CMN_TLS_KEY=$(cat ./cert/${CMN_DOMAIN}.key | base64)
PRD_TLS_CRT=$(cat ./cert/${PRD_DOMAIN}.crt | base64)
PRD_TLS_KEY=$(cat ./cert/${PRD_DOMAIN}.key | base64)
STG_TLS_CRT=$(cat ./cert/${STG_DOMAIN}.crt | base64)
STG_TLS_KEY=$(cat ./cert/${STG_DOMAIN}.key | base64)

cat ./hack/manifests/nginx-ingress-controller/tls.yaml | sed -e "
/__TLS_CRT__/  s/__TLS_CRT__/${CMN_TLS_CRT}/g
/__TLS_KEY__/  s/__TLS_KEY__/${CMN_TLS_KEY}/g
" > ./staging/ingress/cmn/tls.yaml

cat ./hack/manifests/nginx-ingress-controller/tls.yaml | sed -e "
/__TLS_CRT__/  s/__TLS_CRT__/${PRD_TLS_CRT}/g
/__TLS_KEY__/  s/__TLS_KEY__/${PRD_TLS_KEY}/g
" > ./staging/ingress/prod/tls.yaml

cat ./hack/manifests/nginx-ingress-controller/tls.yaml | sed -e "
/__TLS_CRT__/  s/__TLS_CRT__/${STG_TLS_CRT}/g
/__TLS_KEY__/  s/__TLS_KEY__/${STG_TLS_KEY}/g
" > ./staging/ingress/stg/tls.yaml
