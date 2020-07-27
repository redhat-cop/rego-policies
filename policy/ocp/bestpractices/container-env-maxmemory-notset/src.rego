package ocp.bestpractices.container_env_maxmemory_notset

import data.lib.konstraint
import data.lib.openshift

# violation: Check workload kinds have the CONTAINER_MAX_MEMORY env set using the downward api
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  not is_env_max_memory_set(container)
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: container '%s' does not have an env named 'CONTAINER_MAX_MEMORY' which is used by the Red Hat base images to calculate memory. See: https://docs.openshift.com/container-platform/4.4/nodes/clusters/nodes-cluster-resource-configure.html and https://github.com/jboss-openshift/cct_module/blob/master/jboss/container/java/jvm/bash/artifacts/opt/jboss/container/java/jvm/java-default-options", [obj.kind, obj.metadata.name, container.name]))
}

is_env_max_memory_set(container) {
  env := container.env[_]
  env.name == "CONTAINER_MAX_MEMORY"
  env.valueFrom.resourceFieldRef.resource == "limits.memory"
}