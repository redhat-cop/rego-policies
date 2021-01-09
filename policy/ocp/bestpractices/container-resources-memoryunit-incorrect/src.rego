package ocp.bestpractices.container_resources_memoryunit_incorrect

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

# @title Container resources limit memory has incorrect unit
#
# Begininers can easily confuse the allowed memory unit, this policy enforces what is valid.
# k8s also allows for millibyte as a unit for memory, which causes unintended consequences for the scheduler.
# See: https://github.com/kubernetes/kubernetes/issues/28741
# See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet core/ReplicationController apps/StatefulSet core/Pod batch/CronJob
violation[msg] {
  container := openshift.containers[_]

  not startswith(container.resources.requests.memory, "$")
  not startswith(container.resources.limits.memory, "$")
  not is_resource_memory_units_valid(container)

  msg := konstraint_core.format(sprintf("%s/%s: container '%s' memory resources for limits or requests (%s / %s) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes", [konstraint_core.kind, konstraint_core.name, container.name, container.resources.limits.memory, container.resources.requests.memory]))
}

is_resource_memory_units_valid(container) {
  memoryLimitsUnit := regex.find_n("[A-Za-z]+", container.resources.limits.memory, 1)[0]
  memoryRequestsUnit := regex.find_n("[A-Za-z]+", container.resources.requests.memory, 1)[0]

  units := ["Ei", "Pi", "Ti", "Gi", "Mi", "Ki", "E", "P", "T", "G", "M", "K"]
  memoryLimitsUnit == units[_]
  memoryRequestsUnit == units[_]
}