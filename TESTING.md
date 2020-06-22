# Testing
This repo uses as a combination of [bats](https://github.com/bats-core/bats-core) and [conftest](https://github.com/open-policy-agent/conftest)
to validate the rego policies.

## How do i write a test?
Each test is expected to have a directory under [_test](_test) which contains the test input data; typically a yaml file 
containing a OCP Template or k8s List. Each block of YAML should match exactly 1 policy, due to the order of the failure output
which needs to be predictable for bats.

The tests are executed by [_test/tests.bats](_test/tests.bats). The test should validate each expected bats output and always
end with the expected success line.

## Execute Locally
```bash
rm -rf /tmp/rego-policies; _test/conftest.sh
```

## Tools used for testing
The following tools are required:

- [conftest](https://www.conftest.dev/install)
- [jq](https://stedolan.github.io/jq/download)
- [yq](https://pypi.org/project/yq)