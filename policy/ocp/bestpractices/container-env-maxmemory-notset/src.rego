# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00002: Container env has CONTAINER_MAX_MEMORY set'
# description: |-
#   Red Hat OpenJDK image uses CONTAINER_MAX_MEMORY env via the downward API to set Java memory settings.
#   Instead of manually setting -Xmx, let the image automatically set it for you.
#   See: https://github.com/jboss-openshift/cct_module/blob/master/jboss/container/java/jvm/bash/artifacts/opt/jboss/container/java/jvm/java-default-options
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
package ocp.bestpractices.container_env_maxmemory_notset

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00002")
	some container in openshift.containers

	konstraint_core.labels["redhat-cop.github.com/technology"] == "java"
	not _is_env_max_memory_set(container)

	msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' does not have an env named 'CONTAINER_MAX_MEMORY' which is used by the Red Hat base images to calculate memory. See: https://docs.openshift.com/container-platform/4.6/nodes/clusters/nodes-cluster-resource-configure.html and https://github.com/jboss-openshift/cct_module/blob/master/jboss/container/java/jvm/bash/artifacts/opt/jboss/container/java/jvm/java-default-options", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00002")
}

_is_env_max_memory_set(container) {
	some env in container.env
	env.name == "CONTAINER_MAX_MEMORY"
	env.valueFrom.resourceFieldRef.resource == "limits.memory"
}
