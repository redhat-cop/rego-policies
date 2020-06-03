package main

# catch all
deny[msg] {
  msg := _deny
}

deny[msg] {
  input.apiVersion == "template.openshift.io/v1"
  input.kind == "Template"
  obj := input.objects[_]
  msg := _deny with input as obj
}

deny[msg] {
  input.apiVersion != "template.openshift.io/v1"
  input.kind != "Template"
  obj := input.objects[_]
  msg := _deny
}

deny[msg] {
  input.apiVersion == "v1"
  input.kind == "List"
  obj := input.items[_]
  msg := _deny with input as obj
}

deny[msg] {
  input.apiVersion != "v1"
  input.kind != "List"
  msg := _deny
}

_deny = msg {
  input.apiVersion == "apps.openshift.io/v1"
  input.kind == "DeploymentConfig"
  container := input.spec.template.spec.containers[_]
  not container.readinessProbe

  msg := sprintf("%s/%s: container '%s' has no readinessProbe", [input.kind, input.metadata.name, container.name])
}

_deny = msg {
  input.apiVersion == "apps.openshift.io/v1"
  input.kind == "DeploymentConfig"
  container := input.spec.template.spec.containers[_]
  not container.livenessProbe

  msg := sprintf("%s/%s: container '%s' has no livenessProbe", [input.kind, input.metadata.name, container.name])
}