# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00008: Container liveness prob is not set'
# description: |-
#   A Liveness checks determines if the container in which it is scheduled is still running.
#   If the liveness probe fails due to a condition such as a deadlock, the kubelet kills the container.
#   See: https://docs.openshift.com/container-platform/4.6/applications/application-health.html
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
package ocp.bestpractices.container_livenessprobe_notset

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00008")
	some container in openshift.containers

	konstraint_core.missing_field(container, "livenessProbe")

	msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has no livenessProbe. See: https://docs.openshift.com/container-platform/4.6/applications/application-health.html", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00008")
}
