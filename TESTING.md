# Testing
This repo uses as a combination of [bats](https://github.com/bats-core/bats-core) and [conftest](https://github.com/open-policy-agent/conftest)
to validate the rego policies.

## How do i write a test?
Each test is expected to have a directory under [_test](_test) which contains the test input data; typically a yaml file 
containing a OCP Template or k8s List.

The tests are executed by [_test/tests.bats](_test/tests.bats). The test should validate each expected bats output and always
end with the expected success line.
