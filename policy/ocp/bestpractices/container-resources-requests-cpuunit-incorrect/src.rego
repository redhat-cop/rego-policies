# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00014: Container resources requests cpu has incorrect
#   unit'
# description: |-
#   Beginners can easily confuse the allowed cpu unit, this policy enforces what is valid.
#   See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes
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
package ocp.bestpractices.container_resources_requests_cpuunit_incorrect

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00014")
  container := openshift.containers[_]

  not is_resource_requests_cpu_contains_dollar(container)
  not is_resource_requests_cpu_units_valid(container)

  msg := konstraint_core.format_with_id(sprintf("%s/%s container '%s' cpu resources for requests (%s) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes", [konstraint_core.kind, konstraint_core.name, container.name, container.resources.requests.cpu]), "RHCOP-OCP_BESTPRACT-00014")
}

is_resource_requests_cpu_contains_dollar(container) {
  not is_resource_requests_cpu_a_core(container)
  startswith(container.resources.requests.cpu, "$")
}

# TODO: is input correct?
is_resource_requests_cpu_a_core(container)  {
  is_number(input.resources.requests.cpu)
  # This should never fail given that is_number succeeds
  # regal ignore:unused-return-value
  to_number(input.resources.requests.cpu)
}

is_resource_requests_cpu_units_valid(container)  {
  is_resource_requests_cpu_a_core(container)
}

is_resource_requests_cpu_units_valid(container)  {
  not is_resource_requests_cpu_a_core(container)

  # 'cpu' can be a quoted number, which is why we concat an empty string[] to match whole cpu cores
  cpuRequestsUnit := array.concat(regex.find_n(`[A-Za-z]+`, container.resources.requests.cpu, 1), [""])[0]

  cpuRequestsUnit in {"m", ""}
}