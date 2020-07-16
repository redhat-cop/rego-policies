package ocp.bestpractices.container_livenessprobe_notset

import data.lib.konstraint
import data.lib.openshift

# violation: Check workload kinds have their liveness prob set
# @Kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  konstraint.missing_field(container, "livenessProbe")
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: container '%s' has no livenessProbe. See: https://docs.openshift.com/container-platform/4.4/applications/application-health.html", [obj.kind, obj.metadata.name, container.name]))
}