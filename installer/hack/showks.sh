#!/bin/bash -e

set -a

mkdir -p ./staging/showks

if [ ! -f "showks.env" ]; then
    echo "showks.env not found"
    exit 1
else
    . showks.env
fi

CONCOURSECI_PASSWORD=$(/bin/echo -n ${CONCOURSECI_PASSWORD} | base64)
CONCOURSECI_TEAM=$(/bin/echo -n ${CONCOURSECI_TEAM} | base64)
CONCOURSECI_URL=$(/bin/echo -n ${CONCOURSECI_URL} | base64)
CONCOURSECI_USERNAME=$(/bin/echo -n ${CONCOURSECI_USERNAME} | base64)
CONCOURSECI_TARGET=$(/bin/echo -n ${CONCOURSECI_TARGET} | base64)
GITHUB_TOKEN=$(/bin/echo -n ${GITHUB_TOKEN} | base64)
KEYCLOAK_BASE_PATH=$(/bin/echo -n ${KEYCLOAK_BASE_PATH} | base64)
KEYCLOAK_PASSWORD=$(/bin/echo -n ${KEYCLOAK_PASSWORD} | base64)
KEYCLOAK_USERNAME=$(/bin/echo -n ${KEYCLOAK_USERNAME} | base64)
KEYCLOAK_REALM=$(/bin/echo -n ${KEYCLOAK_REALM} | base64)
DOMAIN=$(/bin/echo -n ${DOMAIN} | base64)

for f in $(ls ./hack/manifests/showks/)
do
    sed -e "
        /__CONCOURSECI_PASSWORD__/ s/__CONCOURSECI_PASSWORD__/${CONCOURSECI_PASSWORD}/g
        /__CONCOURSECI_TEAM__/     s/__CONCOURSECI_TEAM__/${CONCOURSECI_TEAM}/g
        /__CONCOURSECI_URL__/      s/__CONCOURSECI_URL__/${CONCOURSECI_URL}/g
        /__CONCOURSECI_USERNAME__/ s/__CONCOURSECI_USERNAME__/${CONCOURSECI_USERNAME}/g
        /__CONCOURSECI_TARGET/     s/__CONCOURSECI_TARGET__/${CONCOURSECI_TARGET}/g
        /__GITHUB_TOKEN__/         s/__GITHUB_TOKEN__/${GITHUB_TOKEN}/g
        /__KEYCLOAK_BASE_PATH__/   s/__KEYCLOAK_BASE_PATH__/${KEYCLOAK_BASE_PATH}/g
        /__KEYCLOAK_PASSWORD__/    s/__KEYCLOAK_PASSWORD__/${KEYCLOAK_PASSWORD}/g
        /__KEYCLOAK_USERNAME__/    s/__KEYCLOAK_USERNAME__/${KEYCLOAK_USERNAME}/g
        /__KEYCLOAK_REALM__/       s/__KEYCLOAK_REALM__/${KEYCLOAK_REALM}/g
        /__DOMAIN__/               s/__DOMAIN__/${DOMAIN}/g
    " ./hack/manifests/showks/${f} > ./staging/showks/${f}
done

