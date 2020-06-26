package ocp.bestpractices.container_resources_limits_cpu_set

import data.lib.konstraint
import data.lib.openshift

# violation: Check workload kinds do not set limits for CPU
# @Kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  container.resources.limits.cpu
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: container '%s' has cpu limits (%d). It is not recommended to limit cpu. See: https://www.reddit.com/r/kubernetes/comments/all1vg/on_kubernetes_cpu_limits", [obj.kind, obj.metadata.name, container.name, container.resources.limits.cpu]))
}