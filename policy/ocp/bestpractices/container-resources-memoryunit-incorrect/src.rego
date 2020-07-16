package ocp.bestpractices.container_resources_memoryunit_incorrect

import data.lib.konstraint
import data.lib.openshift

# violation: Check workload kinds memory limits and requests unit is valid
# @Kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  not startswith(container.resources.requests.memory, "$")
  not startswith(container.resources.limits.memory, "$")
  not is_resource_memory_units_valid(container)
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: container '%s' memory resources for limits or requests (%s / %s) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes", [obj.kind, obj.metadata.name, container.name, container.resources.limits.memory, container.resources.requests.memory]))
}

is_resource_memory_units_valid(container) {
  memoryLimitsUnit := regex.find_n("[A-Za-z]+", container.resources.limits.memory, 1)[0]
  memoryRequestsUnit := regex.find_n("[A-Za-z]+", container.resources.requests.memory, 1)[0]

  units := ["Ei", "Pi", "Ti", "Gi", "Mi", "Ki", "E", "P", "T", "G", "M", "K"]
  memoryLimitsUnit == units[_]
  memoryRequestsUnit == units[_]
}