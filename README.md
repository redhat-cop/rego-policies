[![Run conftest-unittests.sh](https://github.com/redhat-cop/rego-policies/actions/workflows/conftest-unittests.yaml/badge.svg)](https://github.com/redhat-cop/rego-policies/actions/workflows/conftest-unittests.yaml)
[![Check POLICIES.md is up-to-date](https://github.com/redhat-cop/rego-policies/actions/workflows/docs.yaml/badge.svg)](https://github.com/redhat-cop/rego-policies/actions/workflows/docs.yaml)
[![Lint policies with Regal](https://github.com/redhat-cop/rego-policies/actions/workflows/regal-lint.yaml/badge.svg)](https://github.com/redhat-cop/rego-policies/actions/workflows/regal-lint.yaml)
[![Run gatekeeper-k8s-integrationtests.sh](https://github.com/redhat-cop/rego-policies/actions/workflows/gatekeeper-k8s-integrationtests.yaml/badge.svg)](https://github.com/redhat-cop/rego-policies/actions/workflows/gatekeeper-k8s-integrationtests.yaml)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/redhat-cop/rego-policies/badge)](https://securityscorecards.dev/viewer/?uri=github.com/redhat-cop/rego-policies)

# rego-policies
[Rego](https://www.openpolicyagent.org/docs/latest/policy-language/) policies collection.

## Policies
For a full list of policies, see the auto-generated [POLICIES.md](POLICIES.md)

The naming of the policies follows the Gatekeeper format, as described [here.](https://github.com/plexsystems/konstraint/blob/main/docs/constraint_creation.md#resource-naming)

Want to run the policies on a k8s/OCP cluster? See [TESTING.md](TESTING.md)

## Tools
### Conftest
conftest is a CLI to execute rego policies. It can be used to test locally before pushing to [OPA](https://www.openpolicyagent.org/).
- [https://www.conftest.dev/install](https://www.conftest.dev/install/)

### OPA Playground
OPA provides a web based playground, which can highlight which lines have been activated. Having issues with your policy? check it out with "Coverage" enabled:
- [https://play.openpolicyagent.org](https://play.openpolicyagent.org)

### Slack for all things
Stuck on a problem?
- [https://slack.openpolicyagent.org/](https://slack.openpolicyagent.org/)
