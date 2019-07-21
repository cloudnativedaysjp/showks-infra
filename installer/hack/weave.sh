#!/bin/bash -e

VERSION=${1:-1.11.3}
REMOTE="https://raw.githubusercontent.com/weaveworks/scope/v${VERSION}/examples/k8s"

mkdir -p ./staging/weave

for f in cluster-role-binding.yaml cluster-role.yaml deploy.yaml ds.yaml probe-deploy.yaml psp.yaml sa.yaml svc.yaml
do
    curl -f -s -L ${REMOTE}/${f} | sed '
/namespace: weave/  s/namespace: weave/namespace: showks-system/g
/weave-scope-app.weave.svc.cluster.local./ s/weave-scope-app.weave.svc.cluster.local./weave-scope-app.showks-system.svc.cluster.local./g
' > ./staging/weave/${f}
done

# Ingress
mkdir -p ./staging/ingress/prod
mkdir -p ./staging/ingress/stg
mkdir -p ./staging/ingress/cmn

sed -e "
    /__DOMAIN__/ s/__DOMAIN__/${CMN_DOMAIN}/g
" ./hack/manifests/weave/ingress.yaml > ./staging/ingress/cmn/weave.yaml

sed -e "
    /__DOMAIN__/ s/__DOMAIN__/${PRD_DOMAIN}/g
" ./hack/manifests/weave/ingress.yaml > ./staging/ingress/prod/weave.yaml

sed -e "
    /__DOMAIN__/ s/__DOMAIN__/${STG_DOMAIN}/g
" ./hack/manifests/weave/ingress.yaml > ./staging/ingress/stg/weave.yaml
