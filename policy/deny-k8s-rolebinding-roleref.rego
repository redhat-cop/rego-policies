package main

import data.utils.kubernetes
import data.utils.openshift

# catch all
deny[msg] {
  msg := _deny
}

deny[msg] {
  openshift.isTemplate

  obj := input.objects[_]
  msg := _deny with input as obj
}

deny[msg] {
  openshift.isNotTemplate

  obj := input.objects[_]
  msg := _deny
}

deny[msg] {
  kubernetes.isList

  obj := input.items[_]
  msg := _deny with input as obj
}

deny[msg] {
  kubernetes.isNotList

  msg := _deny
}

_deny = msg {
  input.apiVersion == "rbac.authorization.k8s.io/v1"
  input.kind == "RoleBinding"
  input.roleRef
  not input.roleRef.apiGroup
  msg := sprintf("%s/%s: RoleBinding roleRef.apiGroup key is null, use rbac.authorization.k8s.io instead.", [input.kind, input.metadata.name])
}

_deny = msg {
  input.apiVersion == "rbac.authorization.k8s.io/v1"
  input.kind == "RoleBinding"
  input.roleRef
  input.roleRef.apiGroup
  not input.roleRef.kind
  msg := sprintf("%s/%s: RoleBinding roleRef.kind key is null, use ClusterRole or Role instead.", [input.kind, input.metadata.name])
}