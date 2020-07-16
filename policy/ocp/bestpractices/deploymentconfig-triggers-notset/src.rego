package ocp.bestpractices.deploymentconfig_triggers_notset

import data.lib.konstraint
import data.lib.openshift

# violation: Check if a DeploymentConfig has 'spec.triggers' set
# @Kinds apps.openshift.io/DeploymentConfig
violation[msg] {
  openshift.is_deploymentconfig

  obj := konstraint.object
  konstraint.missing_field(obj.spec, "triggers")

  msg := konstraint.format(sprintf("%s/%s: has no triggers set. Could you use a k8s native Deployment? See: https://kubernetes.io/docs/concepts/workloads/controllers/deployment", [obj.kind, obj.metadata.name]))
}