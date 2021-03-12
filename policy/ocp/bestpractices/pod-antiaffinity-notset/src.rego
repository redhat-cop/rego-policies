# @title RHCOP-OCP_BESTPRACT-00026: Pod anti-affinity not set
#
# Even if you run several copies of your Pods, there are no guarantees that losing a node won't take down your service.
# Anti-Affinity
#
# See: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity
#
# @kinds apps.openshift.io/DeploymentConfig apps/Deployment apps/ReplicaSet core/ReplicationController apps/StatefulSet core/Pod
package ocp.bestpractices.pod_antiaffinity_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.pod

  konstraint_core.missing_field(konstraint_core.resource.spec.affinity, "podAntiAffinity")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: spec.affinity.podAntiAffinity not set. See: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_BESTPRACT-00026")
}