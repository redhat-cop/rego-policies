package ocp.bestpractices.container_resources_limits_memory_greater_than

import data.lib.konstraint
import data.lib.memory
import data.lib.openshift

# violation: Check workload kinds limits for memory is not greater than an upper bound
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  #NOTE: upperBound is an arbitrary number and it should be changed to what your company believes is the correct policy
  upperBound := 6 * memory.gb

  container := openshift.containers[_]

  not startswith(container.resources.limits.memory, "$")
  memoryBytes := units.parse_bytes(container.resources.limits.memory)
  memoryBytes > upperBound
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: container '%s' has a memory limit of '%s' which is larger than the upper '%dGi' limit.", [obj.kind, obj.metadata.name, container.name, container.resources.limits.memory, (upperBound / memory.gb)]))
}