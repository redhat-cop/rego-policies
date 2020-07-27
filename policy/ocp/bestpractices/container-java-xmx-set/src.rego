package ocp.bestpractices.container_java_xmx_set

import data.lib.konstraint
import data.lib.openshift

# violation: Check workload kinds do not set the Java Xmx option
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  container_opts_contains_xmx(container)
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: container '%s' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'", [obj.kind, obj.metadata.name, container.name]))
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