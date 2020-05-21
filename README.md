# rego-policies
[Rego](https://www.openpolicyagent.org/docs/latest/policy-language/) policies collection

## Policies
Current policies in this repo:
- [ocp-42-deprecated-apiversions.rego](policy/ocp-42-deprecated-apiversions.rego)
    - [deny rules for OCP 4.2 apiVersion deprecations](https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features)

- [ocp-43-deprecated-apiversions.rego](policy/ocp-43-deprecated-apiversions.rego)
    - deny rules for OCP 4.3 apiVersion deprecations. Changing OCP specific kinds from v1 to *.openshift.io/v1

- [k8s-validation-rolebinding.rego](policy/k8s-validation-rolebinding.rego)
    - deny rules to check roleRef.apiGroup and roleRef.kind for rbac.authorization.k8s.io/v1:RoleBinding are set, which were not required in OCP 3.x

## 3rd Party Policies
A list of git repos that contain rego polices which can be combined with this repo:
- [deprek8ion: Rego policies to monitor Kubernetes APIs deprecations](https://github.com/swade1987/deprek8ion)

## Conftest
conftest is a CLI to execute rego policies. It can be used to test locally before pushing to OPA.
- https://www.conftest.dev/install/