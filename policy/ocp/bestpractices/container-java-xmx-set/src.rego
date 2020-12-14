package ocp.bestpractices.container_java_xmx_set

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

# @title Container does not set Java Xmx option
#
# Red Hat OpenJDK image uses CONTAINER_MAX_MEMORY env via the downward API to set Java memory settings.
# Instead of manually setting -Xmx, let the image automatically set it for you.
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  container_opts_contains_xmx(container)
  obj := konstraint.object

  msg := konstraint_core.format(sprintf("%s/%s: container '%s' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'", [konstraint_core.kind, konstraint_core.name, container.name]))
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