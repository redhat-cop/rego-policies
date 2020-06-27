![Validate](https://github.com/redhat-cop/rego-policies/workflows/Validate/badge.svg)

# rego-policies
[Rego](https://www.openpolicyagent.org/docs/latest/policy-language/) policies collection

## Policies
Current policies in this repo are below. The naming of the policy files follows the below convention:
- {policy-type}-{platform}-{kind}-{other...}

### Deny Policies
- [deny-ocp42-all-deprecated-apiversions](policy/deny-ocp42-all-deprecated-apiversion.rego)
    - [deny rules for OCP 4.2 apiVersion deprecations](https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features)

- [deny-ocp43-all-deprecated-apiversions.rego](policy/deny-ocp43-all-deprecated-apiversions.rego)
    - deny rules for OCP 4.3 apiVersion deprecations. Changing OCP specific kinds from v1 to *.openshift.io/v1

- [deny-k8s-rolebinding-roleref.rego](policy/deny-k8s-rolebinding-roleref.rego)
    - deny rules to check roleRef.apiGroup and roleRef.kind for rbac.authorization.k8s.io/v1:RoleBinding are set, which were not required in OCP 3.x

### Warn Policies
- [warn-k8s-deployment-conftestcombine-bestpractices.rego](policy/warn-k8s-deployment-conftestcombine-bestpractices.rego)
    - warn rules to check Deployments combined with other objects match; i.e.: Deployment -> Service selectors

- [warn-k8s-namespace-conftestcombine-bestpractices.rego](policy/warn-k8s-namespace-conftestcombine-bestpractices.rego)
    - warn rules to check Namepaces combined with other objects match; i.e.: Namespace -> NetworkPolicy

- [warn-k8s-service-conftestcombine-bestpractices.rego](policy/warn-k8s-service-conftestcombine-bestpractices.rego)
    - warn rules to check Services combined with other objects match; i.e.: Service -> ServiceMonitor

- [warn-k8s_ocp-all-bestpractices.rego](policy/warn-k8s_ocp-all-bestpractices.rego)
    - warn rules to check all k8s objects - has a 'kind' and 'metadata.name'; i.e.: metadata.labels are set

- [warn-k8s_ocp-deployment_deploymentconfig-bestpractices.rego](policy/warn-k8s_ocp-deployment_deploymentconfig-bestpractices.rego)
    - warn rules to check Deployment/DeploymentConfig conform to standard practices; i.e.: health-check probs are set

- [warn-ocp-deploymentconfig-bestpractices.rego](policy/warn-ocp-deploymentconfig-bestpractices.rego)
    - warn rules to check DeploymentConfig conform to standard practices; i.e.: triggers are set

- [warn-podman-history-bestpractices.rego](policy/warn-podman-history-bestpractices.rego)
    - warn rules to check a wrapped JSON output of "podman history"; i.e.: expected base layer is found.

- [warn-podman-images-bestpractices.rego](policy/warn-podman-images-bestpractices.rego)
    - warn rules to check a wrapped JSON output of "podman images"; i.e.: check image size is within bounds.

## 3rd Party Policies
A list of git repos that contain rego polices which can be combined with this repo:
- [deprek8ion: Rego policies to monitor Kubernetes APIs deprecations](https://github.com/swade1987/deprek8ion)

## Conftest
conftest is a CLI to execute rego policies. It can be used to test locally before pushing to [OPA](https://www.openpolicyagent.org/).
- [https://www.conftest.dev/install/]

## OPA Playground
OPA provides a web based playground, which can highlight which lines have been activated. Having issues with your policy? check it out with "Coverage" enabled:
- [https://play.openpolicyagent.org/]
