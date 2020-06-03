package main

deny[msg] {
  input.apiVersion == "apps.openshift.io/v1"
  input.kind == "DeploymentConfig"
  container := input.spec.template.spec.containers[_]
  not container.readinessProbe

  msg := sprintf("%s/%s: container '%s' has no readinessProbe", [input.kind, input.metadata.name, container.name])
}

deny[msg] {
  input.apiVersion == "apps.openshift.io/v1"
  input.kind == "DeploymentConfig"
  container := input.spec.template.spec.containers[_]
  not container.livenessProbe

  msg := sprintf("%s/%s: container '%s' has no livenessProbe", [input.kind, input.metadata.name, container.name])
}