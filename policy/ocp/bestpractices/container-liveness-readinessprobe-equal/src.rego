package ocp.bestpractices.container_liveness_readinessprobe_equal

import data.lib.konstraint
import data.lib.openshift

# violation: Check workload kinds have not set their probes to be the same
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  container.livenessProbe
  container.readinessProbe
  container.livenessProbe == container.readinessProbe
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: container '%s' livenessProbe and readinessProbe are equal, which is an anti-pattern.", [obj.kind, obj.metadata.name, container.name]))
}