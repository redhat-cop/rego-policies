# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00010: Container resource limits CPU not set'
# description: |-
#   If you're not sure about what's the best settings for your app, it's better not to set the CPU limits.
#   See: Resources utilisation -> https://learnk8s.io/production-best-practices#application-development
#   See: reddit.com/r/kubernetes/comments/all1vg/on_kubernetes_cpu_limits
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
package ocp.bestpractices.container_resources_limits_cpu_set

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00010")
	some container in openshift.containers

	container.resources.limits.cpu

	msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has cpu limits (%d). It is not recommended to limit cpu. See: https://www.reddit.com/r/kubernetes/comments/all1vg/on_kubernetes_cpu_limits", [konstraint_core.kind, konstraint_core.name, container.name, container.resources.limits.cpu]), "RHCOP-OCP_BESTPRACT-00010")
}
