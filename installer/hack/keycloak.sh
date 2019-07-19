#!/bin/bash -e

VERSION=${1:-6.0.1}

mkdir -p ./staging/keycloak

cat ./hack/manifests/keycloak/keycloak.yaml | sed -e "s/__KEYCLOAK_VERSION__/${VERSION}/g" > ./staging/keycloak/keycloak.yaml
