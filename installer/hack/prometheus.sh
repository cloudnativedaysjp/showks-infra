#!/bin/bash -e

set -a

mkdir -p ./staging/prometheus

for f in $(ls ./hack/manifests/prometheus/ | grep -v ingress.yaml)
do
    cp ./hack/manifests/prometheus/${f} ./staging/prometheus/.
done

# ingress for grafana
mkdir -p staging/ingress/prod/
mkdir -p staging/ingress/stg/

sed -e "
    /__DOMAIN__/ s/__DOMAIN__/${PRD_DOMAIN}/g
" ./hack/manifests/prometheus/ingress.yaml > ./staging/ingress/prod/prometheus.yaml

sed -e "
    /__DOMAIN__/ s/__DOMAIN__/${STG_DOMAIN}/g
" ./hack/manifests/prometheus/ingress.yaml > ./staging/ingress/stg/prometheus.yaml
