# Testing
This repo uses as a combination of [bats](https://github.com/bats-core/bats-core), [conftest](https://github.com/open-policy-agent/conftest) and
[gatekeeper](https://github.com/open-policy-agent/gatekeeper) to validate the rego policies.

## How do I write a policy?
Each policy lives under its own directory, i.e.: [policy/ocp/bestpractices/common-k8s-labels-notset](policy/ocp/bestpractices/common-k8s-labels-notset).
Every policy must have a test_data directory; within that directory, there should be:
- unit: should contain only the YAML needed to execute the policy, i.e.: a cut down version
- integration: should contain valid YAML which can be deployed to a cluster which only triggers the policy under-test

Each policy must have a BATS test executed by its usecase:
- unit test files will be executed by [_test/conftest-unittests.sh].
- integration test files will be executed by [_test/gatekeeper-integrationtests.sh]. 

## Execute unit tests
```bash
rm -rf /tmp/rhcop; bats _test/conftest-unittests.sh
```

## Execute integration units
```bash
_test/deploy-gatekeeper.sh
rm -rf /tmp/rhrepo; bats _test/gatekeeper-integrationtests.sh
```

## Tools used for testing
The following tools must be installed locally:

- [conftest](https://www.conftest.dev/install)
- [konstraint](https://github.com/plexsystems/konstraint#installation)
- [jq](https://stedolan.github.io/jq/download)
- [yq](https://pypi.org/project/yq)