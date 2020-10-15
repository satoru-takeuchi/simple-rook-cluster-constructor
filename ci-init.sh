#!/bin/bash

export KUBECONFIG=$HOME/admin.conf \
    KUBE_VERSION=v1.18.6

tests/scripts/kubeadm.sh up
tests/scripts/helm.sh up

export PATH="/tmp/rook-tests-scripts-helm/linux-amd64:$PATH" \
    TEST_HELM_PATH=/tmp/rook-tests-scripts-helm/linux-amd64/helm \
    TEST_BASE_DIR="$(pwd)" \
    STORAGE_PROVIDER_TESTS=ceph \
    TEST_IS_OFFICIAL_BUILD=false \
    TEST_SCRATCH_DEVICE=/dev/sdb

go test -v -timeout 1800s github.com/rook/rook/tests/integration
#go test -v -timeout 1800s -run CephSmokeSuite github.com/rook/rook/tests/integration
#go test -v -timeout 1800s -run CephSmokeSuite github.com/rook/rook/tests/integration -testify.m TestRookClusterInstallation_SmokeTest

