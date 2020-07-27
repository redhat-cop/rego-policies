package ocp.bestpractices.container_resources_requests_cpuunit_incorrect

import data.lib.konstraint
import data.lib.openshift

# violation: Check workload kinds cpu requests unit is valid
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  not is_resource_requests_cpu_contains_dollar(container)
  not is_resource_requests_cpu_units_valid(container)
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s container '%s' cpu resources for requests (%s) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes", [obj.kind, obj.metadata.name, container.name, container.resources.requests.cpu]))
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