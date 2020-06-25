package main

import data.utils.openshift

warn[msg] {
  openshift.isDeploymentConfig

  not input.spec.triggers

  msg := sprintf("%s/%s: has no triggers set. Could you use a k8s native Deployment? See: https://kubernetes.io/docs/concepts/workloads/controllers/deployment", [input.kind, input.metadata.name])
}