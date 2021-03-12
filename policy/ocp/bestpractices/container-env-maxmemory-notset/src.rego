# @title RHCOP-OCP_BESTPRACT-00002: Container env has CONTAINER_MAX_MEMORY set
#
# Red Hat OpenJDK image uses CONTAINER_MAX_MEMORY env via the downward API to set Java memory settings.
# Instead of manually setting -Xmx, let the image automatically set it for you.
# See: https://github.com/jboss-openshift/cct_module/blob/master/jboss/container/java/jvm/bash/artifacts/opt/jboss/container/java/jvm/java-default-options
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet core/ReplicationController apps/StatefulSet core/Pod batch/CronJob
package ocp.bestpractices.container_env_maxmemory_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  container := openshift.containers[_]

  konstraint_core.labels["redhat-cop.github.com/technology"] == "java"
  not is_env_max_memory_set(container)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' does not have an env named 'CONTAINER_MAX_MEMORY' which is used by the Red Hat base images to calculate memory. See: https://docs.openshift.com/container-platform/4.6/nodes/clusters/nodes-cluster-resource-configure.html and https://github.com/jboss-openshift/cct_module/blob/master/jboss/container/java/jvm/bash/artifacts/opt/jboss/container/java/jvm/java-default-options", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00002")
}

is_env_max_memory_set(container) {
  env := container.env[_]
  env.name == "CONTAINER_MAX_MEMORY"
  env.valueFrom.resourceFieldRef.resource == "limits.memory"
}