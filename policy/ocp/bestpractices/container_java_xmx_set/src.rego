# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00005: Container does not set Java Xmx option'
# description: |-
#   Red Hat OpenJDK image uses CONTAINER_MAX_MEMORY env via the downward API to set Java memory settings.
#   Instead of manually setting -Xmx, let the image automatically set it for you.
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
package ocp.bestpractices.container_java_xmx_set

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00005")
	some container in openshift.containers

	konstraint_core.labels["redhat-cop.github.com/technology"] == "java"
	_container_opts_contains_xmx(container)

	msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00005")
}

_container_opts_contains_xmx(container) {
	some command in container.command
	contains(command, "-Xmx")
}

_container_opts_contains_xmx(container) {
	some arg in container.args
	contains(arg, "-Xmx")
}

_container_opts_contains_xmx(container) {
	some env in container.env
	contains(env.value, "-Xmx")
}
