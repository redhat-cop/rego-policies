package ocp.bestpractices.deploymentconfig_triggers_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

# @title DeploymentConfig triggers not set
#
# If you are using a DeploymentConfig without 'spec.triggers' set, you could probably just use the k8s Deployment.
#
# @kinds apps.openshift.io/DeploymentConfig
violation[msg] {
  openshift.is_deploymentconfig

  obj := konstraint.object
  konstraint.missing_field(obj.spec, "triggers")

  msg := konstraint_core.format(sprintf("%s/%s: has no triggers set. Could you use a k8s native Deployment? See: https://kubernetes.io/docs/concepts/workloads/controllers/deployment", [konstraint_core.kind, konstraint_core.name]))
}