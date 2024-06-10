# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00013: Container resources limit memory has incorrect
#   unit'
# description: |-
#   Begininers can easily confuse the allowed memory unit, this policy enforces what is valid.
#   k8s also allows for millibyte as a unit for memory, which causes unintended consequences for the scheduler.
#   See: https://github.com/kubernetes/kubernetes/issues/28741
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
package ocp.bestpractices.container_resources_memoryunit_incorrect

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00013")
	some container in openshift.containers

	not startswith(container.resources.requests.memory, "$")
	not startswith(container.resources.limits.memory, "$")
	not _is_resource_memory_units_valid(container)

	msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' memory resources for limits or requests (%s / %s) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes", [konstraint_core.kind, konstraint_core.name, container.name, container.resources.limits.memory, container.resources.requests.memory]), "RHCOP-OCP_BESTPRACT-00013")
}

_is_resource_memory_units_valid(container) {
	limits_unit := regex.find_n(`[A-Za-z]+`, container.resources.limits.memory, 1)[0]
	requests_unit := regex.find_n(`[A-Za-z]+`, container.resources.requests.memory, 1)[0]

	units := ["Ei", "Pi", "Ti", "Gi", "Mi", "Ki", "E", "P", "T", "G", "M", "K"]
	limits_unit in units
	requests_unit in units
}
