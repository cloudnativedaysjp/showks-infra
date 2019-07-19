#!/bin/bash -e

set -a

mkdir -p ./staging/prometheus

cp ./hack/manifests/prometheus/* ./staging/prometheus/.

