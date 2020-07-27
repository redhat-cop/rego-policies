package ocp.bestpractices.container_resources_limits_memory_notset

import data.lib.konstraint
import data.lib.openshift

# violation: Check workload kinds has set their limits for memory
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  # TODO: Maybe should use below factored out?
  #konstraint.missing_field(container.resources.limits, "memory")
  not container.resources.limits.memory
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: container '%s' has no memory limits. It is recommended to limit memory, as memory always has a maximum. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers", [obj.kind, obj.metadata.name, container.name]))
}