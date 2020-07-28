package ocp.bestpractices.pod_replicas_below_one

import data.lib.konstraint
import data.lib.openshift

# @title Pod replica below 1
#
# Never run a single Pod individually.
# See: Fault tolerance -> https://learnk8s.io/production-best-practices#application-development
#
# @kinds apps.openshift.io/DeploymentConfig apps/Deployment
violation[msg] {
  openshift.is_workload_kind

  obj := konstraint.object
  obj.spec.replicas <= 1

  msg := konstraint.format(sprintf("%s/%s: replicas is %d - expected replicas to be greater than 1 for HA guarantees.", [obj.kind, obj.metadata.name, obj.spec.replicas]))
}