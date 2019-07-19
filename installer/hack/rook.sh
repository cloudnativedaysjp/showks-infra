#!/bin/bash -e

VERSION=${1:-1.0.4}
REMOTE="https://raw.githubusercontent.com/rook/rook/v${VERSION}/cluster/examples/kubernetes"

mkdir -p ./staging/rook

# Ceph
curl -f -s -L ${REMOTE}/ceph/common.yaml | sed 's/namespace: rook-ceph/namespace: showks-system/' > ./staging/rook/01_common.yaml
curl -f -s -L ${REMOTE}/ceph/operator.yaml | sed -e '
/namespace: rook-ceph/            s/namespace: rook-ceph/namespace: showks-system/g
/# - name: FLEXVOLUME_DIR_PATH/   s/# - name: FLEXVOLUME_DIR_PATH/- name: FLEXVOLUME_DIR_PATH/g
/#  value: "<PathToFlexVolumes>"/ s|#  value: "<PathToFlexVolumes>"|  value: "/home/kubernetes/flexvolume"|
' > ./staging/rook/02_operator.yaml
curl -f -s -L ${REMOTE}/ceph/cluster.yaml | sed 's/namespace: rook-ceph/namespace: showks-system/' > ./staging/rook/03_cluster.yaml
curl -f -s -L ${REMOTE}/ceph/storageclass.yaml | sed 's/namespace: rook-ceph/namespace: showks-system/' > ./staging/rook/04_storageclass.yaml

# Minio
curl -f -s -L ${REMOTE}/minio/operator.yaml | sed 's/namespace: rook-minio-system/namespace: showks-system/' > ./staging/rook/05_operator.yaml
curl -f -s -L ${REMOTE}/minio/object-store.yaml | sed 's/namespace: rook-minio/namespace: showks-system/' > ./staging/rook/06_object-store.yaml

