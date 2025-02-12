#!/usr/bin/env bash

set -e

kubectl cluster-info
_test/prow.sh deploy

echo ""
echo "Tests:"
exec _test/prow.sh test_k8s
