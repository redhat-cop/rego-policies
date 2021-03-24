# @title RHCOP-OCP_BESTPRACT-00005: Container does not set Java Xmx option
#
# Red Hat OpenJDK image uses CONTAINER_MAX_MEMORY env via the downward API to set Java memory settings.
# Instead of manually setting -Xmx, let the image automatically set it for you.
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet core/ReplicationController apps/StatefulSet core/Pod batch/CronJob
package ocp.bestpractices.container_java_xmx_set

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00005")
  container := openshift.containers[_]

  konstraint_core.labels["redhat-cop.github.com/technology"] == "java"
  container_opts_contains_xmx(container)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00005")
}

container_opts_contains_xmx(container) {
  value := container.command[_]
  contains(value, "-Xmx")
}

container_opts_contains_xmx(container) {
  value := container.args[_]
  contains(value, "-Xmx")
}

container_opts_contains_xmx(container) {
  value := container.env[_]
  contains(value.value, "-Xmx")
}