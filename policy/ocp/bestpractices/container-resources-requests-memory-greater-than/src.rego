# @title RHCOP-OCP_BESTPRACT-00015: Container resource requests memory not greater than
#
# Setting a too high memory request can cause under utilisation on a node.
# It is better to run multiple pods which use smaller requests.
# See: Resources utilisation -> https://learnk8s.io/production-best-practices#application-development
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet core/ReplicationController apps/StatefulSet core/Pod batch/CronJob
package ocp.bestpractices.container_resources_requests_memory_greater_than

import data.lib.konstraint.core as konstraint_core
import data.lib.memory
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00015")
  #NOTE: upperBound is an arbitrary number and it should be changed to what your company believes is the correct policy
  upperBound := 2 * memory.gb

  container := openshift.containers[_]

  not startswith(container.resources.requests.memory, "$")
  memoryBytes := units.parse_bytes(container.resources.requests.memory)
  memoryBytes > upperBound

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has a memory request of '%s' which is larger than the upper '%dGi' limit.", [konstraint_core.kind, konstraint_core.name, container.name, container.resources.requests.memory, (upperBound / memory.gb)]), "RHCOP-OCP_BESTPRACT-00015")
}