package ocp.bestpractices.pod_replicas_below_one

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

# @title RHCOP-OCP_BESTPRACT-00021: Pod replica below 1
#
# Never run a single Pod individually.
# See: Fault tolerance -> https://learnk8s.io/production-best-practices#application-development
#
# @kinds apps.openshift.io/DeploymentConfig apps/Deployment
violation[msg] {
  openshift.pod

  replicas := konstraint_core.resource.spec.replicas
  replicas <= 1

  msg := konstraint_core.format_with_id(sprintf("%s/%s: replicas is %d - expected replicas to be greater than 1 for HA guarantees.", [konstraint_core.kind, konstraint_core.name, replicas]), "RHCOP-OCP_BESTPRACT-00021")
}