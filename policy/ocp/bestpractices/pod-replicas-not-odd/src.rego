# @title RHCOP-OCP_BESTPRACT-00022: Pod replica is not odd
#
# Pods should be run with a replica which is odd, i.e.: 3, 5, 7, etc, for HA guarantees.
# See: Fault tolerance -> https://learnk8s.io/production-best-practices#application-development
#
# @kinds apps.openshift.io/DeploymentConfig apps/Deployment
package ocp.bestpractices.pod_replicas_not_odd

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.pod

  replicas := konstraint_core.resource.spec.replicas
  replicas % 2 == 0

  msg := konstraint_core.format_with_id(sprintf("%s/%s: replicas is %d - expected an odd number for HA guarantees.", [konstraint_core.kind, konstraint_core.name, replicas]), "RHCOP-OCP_BESTPRACT-00022")
}