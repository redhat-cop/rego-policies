# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00015: Container resource requests memory not greater
#   than'
# description: |-
#   Setting a too high memory request can cause under utilisation on a node.
#   It is better to run multiple pods which use smaller requests.
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
package ocp.bestpractices.container_resources_requests_memory_greater_than

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.memory
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00015")

	# NOTE: upper_bound is an arbitrary number and it should be changed to what your company believes is the correct policy
	upper_bound := 2 * memory.gb

	some container in openshift.containers

	not startswith(container.resources.requests.memory, "$")
	memory_bytes := units.parse_bytes(container.resources.requests.memory)
	memory_bytes > upper_bound

	msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has a memory request of '%s' which is larger than the upper '%dGi' limit.", [konstraint_core.kind, konstraint_core.name, container.name, container.resources.requests.memory, upper_bound / memory.gb]), "RHCOP-OCP_BESTPRACT-00015")
}
