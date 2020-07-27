package ocp.bestpractices.container_resources_requests_memory_greater_than

import data.lib.konstraint
import data.lib.memory
import data.lib.openshift

# @title Container resource requests memory not greater than
#
# Setting a too high memory request can cause under utilisation on a node.
# It is better to run multiple pods which use smaller requests.
# See: Resources utilisation -> https://learnk8s.io/production-best-practices#application-development
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  #NOTE: upperBound is an arbitrary number and it should be changed to what your company believes is the correct policy
  upperBound := 2 * memory.gb

  container := openshift.containers[_]

  not startswith(container.resources.requests.memory, "$")
  memoryBytes := units.parse_bytes(container.resources.requests.memory)
  memoryBytes > upperBound
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: container '%s' has a memory request of '%s' which is larger than the upper '%dGi' limit.", [obj.kind, obj.metadata.name, container.name, container.resources.requests.memory, (upperBound / memory.gb)]))
}