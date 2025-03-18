# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00009: Container readiness prob is not set'
# description: |-
#   A Readiness check determines if the container in which it is scheduled is ready to service requests.
#   If the readiness probe fails a container, the endpoints controller ensures the container has its IP address
#   removed from the endpoints of all services.
#   See: https://docs.redhat.com/en/documentation/openshift_container_platform/4.18/html/building_applications/application-health
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
package ocp.bestpractices.container_readinessprobe_notset

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00009")
	some container in openshift.containers

	konstraint_core.missing_field(container, "readinessProbe")

	msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has no readinessProbe. See: https://docs.redhat.com/en/documentation/openshift_container_platform/4.18/html/building_applications/application-health", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00009")
}
