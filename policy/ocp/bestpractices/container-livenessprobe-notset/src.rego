package ocp.bestpractices.container_livenessprobe_notset

import data.lib.konstraint
import data.lib.openshift

# @title Container liveness prob is not set
#
# A Liveness checks determines if the container in which it is scheduled is still running.
# If the liveness probe fails due to a condition such as a deadlock, the kubelet kills the container.
# See: https://docs.openshift.com/container-platform/4.4/applications/application-health.html
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  konstraint.missing_field(container, "livenessProbe")
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: container '%s' has no livenessProbe. See: https://docs.openshift.com/container-platform/4.4/applications/application-health.html", [obj.kind, obj.metadata.name, container.name]))
}