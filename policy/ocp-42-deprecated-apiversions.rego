package main

deny[msg] {
  input.apiVersion == "v1"
  input.kind == "Template"
  obj := input.objects[_]
  msg := _deny with input as obj
}

deny[msg] {
  input.apiVersion != "v1"
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
  contains(input.apiVersion, "servicecatalog.k8s.io/v1beta1")

  msg := sprintf("%s/%s: servicecatalog.k8s.io/v1beta1 is deprecated.", [input.kind, input.metadata.name])
}

_deny = msg {
  contains(input.apiVersion, "automationbroker.io/v1alpha1")

  msg := sprintf("%s/%s: automationbroker.io/v1alpha1 is deprecated.", [input.kind, input.metadata.name])
}

_deny = msg {
  contains(input.apiVersion, "osb.openshift.io/v1")

  msg := sprintf("%s/%s: osb.openshift.io/v1 is deprecated.", [input.kind, input.metadata.name])
}

_deny = msg {
  contains(input.apiVersion, "operatorsources.operators.coreos.com/v1")

  msg := sprintf("%s/%s: operatorsources.operators.coreos.com/v1 is deprecated.", [input.kind, input.metadata.name])
}

_deny = msg {
  contains(input.apiVersion, "catalogsourceconfigs.operators.coreos.com/v1")

  msg := sprintf("%s/%s: catalogsourceconfigs.operators.coreos.com/v1 is deprecated.", [input.kind, input.metadata.name])
}

_deny = msg {
  contains(input.apiVersion, "catalogsourceconfigs.operators.coreos.com/v2")

  msg := sprintf("%s/%s: catalogsourceconfigs.operators.coreos.com/v2 is deprecated.", [input.kind, input.metadata.name])
}