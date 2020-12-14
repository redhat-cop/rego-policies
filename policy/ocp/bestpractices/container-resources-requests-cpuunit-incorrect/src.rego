package ocp.bestpractices.container_resources_requests_cpuunit_incorrect

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

# @title Container resources requests cpu has incorrect unit
#
# Beginners can easily confuse the allowed cpu unit, this policy enforces what is valid.
# See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet core/ReplicationController apps/StatefulSet core/Pod batch/CronJob
violation[msg] {
  container := openshift.containers[_]

  not is_resource_requests_cpu_contains_dollar(container)
  not is_resource_requests_cpu_units_valid(container)

  msg := konstraint_core.format(sprintf("%s/%s container '%s' cpu resources for requests (%s) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes", [konstraint_core.kind, konstraint_core.name, container.name, container.resources.requests.cpu]))
}

is_resource_requests_cpu_contains_dollar(container) {
  not is_resource_requests_cpu_a_core(container)
  startswith(container.resources.requests.cpu, "$")
}

is_resource_requests_cpu_a_core(container)  {
  is_number(input.resources.requests.cpu)
  to_number(input.resources.requests.cpu)
}

is_resource_requests_cpu_units_valid(container)  {
  is_resource_requests_cpu_a_core(container)
}

is_resource_requests_cpu_units_valid(container)  {
  not is_resource_requests_cpu_a_core(container)

  # 'cpu' can be a quoted number, which is why we concat an empty string[] to match whole cpu cores
  cpuRequestsUnit := array.concat(regex.find_n("[A-Za-z]+", container.resources.requests.cpu, 1), [""])[0]

  units := ["m", ""]
  cpuRequestsUnit == units[_]
}