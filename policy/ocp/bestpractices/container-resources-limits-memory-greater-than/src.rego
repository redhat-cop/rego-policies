# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00011: Container resource limits memory not greater than'
# description: |-
#   Setting a too high memory limit can cause under utilisation on a node.
#   It is better to run multiple pods which use smaller limits.
#   See: Resources utilisation -> https://learnk8s.io/production-best-practices#application-development
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - ""
#       kinds:
#       - Pod
#       - ReplicationController
#     - apiGroups:
#       - apps
#       kinds:
#       - DaemonSet
#       - Deployment
#       - Job
#       - ReplicaSet
#       - StatefulSet
#     - apiGroups:
#       - apps.openshift.io
#       kinds:
#       - DeploymentConfig
#     - apiGroups:
#       - batch
#       kinds:
#       - CronJob
package ocp.bestpractices.container_resources_limits_memory_greater_than

import data.lib.konstraint.core as konstraint_core
import data.lib.memory
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00011")
  #NOTE: upperBound is an arbitrary number and it should be changed to what your company believes is the correct policy
  upperBound := 6 * memory.gb

  container := openshift.containers[_]

  not startswith(container.resources.limits.memory, "$")
  memoryBytes := units.parse_bytes(container.resources.limits.memory)
  memoryBytes > upperBound

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has a memory limit of '%s' which is larger than the upper '%dGi' limit.", [konstraint_core.kind, konstraint_core.name, container.name, container.resources.limits.memory, (upperBound / memory.gb)]), "RHCOP-OCP_BESTPRACT-00011")
}