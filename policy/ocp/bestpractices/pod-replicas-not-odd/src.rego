package ocp.bestpractices.pod_replicas_not_odd

import data.lib.konstraint
import data.lib.openshift

# violation: Check workload kinds has replicas not odd
# @Kinds apps.openshift.io/DeploymentConfig apps/Deployment
violation[msg] {
  openshift.is_workload_kind

  obj := konstraint.object
  obj.spec.replicas % 2 == 0

  msg := konstraint.format(sprintf("%s/%s: replicas is %d - expected an odd number for HA guarantees.", [obj.kind, obj.metadata.name, obj.spec.replicas]))
}