#!/bin/bash -e

VERSION=${1:-5.3.0}

mkdir -p ./staging/concourse

cat ./hack/manifests/concourse/concourse.yaml | sed -e "s/__CONCOURSE_VERSION__/${VERSION}/g" > ./staging/concourse/concourse.yaml
