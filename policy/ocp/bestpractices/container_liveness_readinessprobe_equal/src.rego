# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00007: Container liveness and readiness probes are equal'
# description: |-
#   When Liveness and Readiness probes are pointing to the same endpoint, the effects of the probes are combined.
#   When the app signals that it's not ready or live, the kubelet detaches the container from the Service
#   and delete it at the same time. You might notice dropping connections because the container
#   does not have enough time to drain the current connections or process the incoming ones.
#   See: Health checks -> https://learnk8s.io/production-best-practices#application-development
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
package ocp.bestpractices.container_liveness_readinessprobe_equal

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00007")
	some container in openshift.containers

	container.livenessProbe == container.readinessProbe

	msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' livenessProbe and readinessProbe are equal, which is an anti-pattern.", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00007")
}
