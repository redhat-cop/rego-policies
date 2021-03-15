#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

# Process arguments
case $1 in
  deploy)
    _test/deploy-gatekeeper.sh deploy_gatekeeper
    exec _test/deploy-gatekeeper.sh patch_namespaceselector
    ;;
  test)
    _test/deploy-gatekeeper.sh deploy_constraints
    exec bats _test/gatekeeper-integrationtests.sh
    ;;
  *)
    echo "Not an option"
    exit 1
esac