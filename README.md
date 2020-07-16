![Validate](https://github.com/redhat-cop/rego-policies/workflows/Validate/badge.svg)

# rego-policies
[Rego](https://www.openpolicyagent.org/docs/latest/policy-language/) policies collection.

## Policies
For a full list of policies, see the auto-generated [POLICIES.md](/POLICIES.md)

The naming of the policies follows the Gatekeeper format, as described [here.](https://github.com/plexsystems/konstraint#how-template-and-constraint-naming-works)

## 3rd Party Policies
A list of git repos that contain rego polices which can be combined with this repo:
- [deprek8ion: Rego policies to monitor Kubernetes APIs deprecations](https://github.com/swade1987/deprek8ion)

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