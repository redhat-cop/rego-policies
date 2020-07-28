package ocp.bestpractices.pod_replicas_not_odd

import data.lib.konstraint
import data.lib.openshift

# @title Pod replica is not odd
#
# Pods should be run with a replica which is odd, i.e.: 3, 5, 7, etc, for HA guarantees.
# See: Fault tolerance -> https://learnk8s.io/production-best-practices#application-development
#
# @kinds apps.openshift.io/DeploymentConfig apps/Deployment
violation[msg] {
  openshift.is_workload_kind

  obj := konstraint.object
  obj.spec.replicas % 2 == 0

  msg := konstraint.format(sprintf("%s/%s: replicas is %d - expected an odd number for HA guarantees.", [obj.kind, obj.metadata.name, obj.spec.replicas]))
}