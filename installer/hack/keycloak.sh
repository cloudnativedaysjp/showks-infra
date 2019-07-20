#!/bin/bash -e

VERSION=${1:-6.0.1}

mkdir -p ./staging/keycloak

cat ./hack/manifests/keycloak/keycloak.yaml | sed -e "s/__KEYCLOAK_VERSION__/${VERSION}/g" > ./staging/keycloak/keycloak.yaml

# Ingress
mkdir -p ./staging/ingress/cmn

sed -e "
    /__DOMAIN__/ s/__DOMAIN__/cmn.${DOMAIN}/g
" ./hack/manifests/keycloak/ingress.yaml > ./staging/ingress/cmn/keycloak.yaml
