# @title RHCOP-OCP_BESTPRACT-00008: Container liveness prob is not set
#
# A Liveness checks determines if the container in which it is scheduled is still running.
# If the liveness probe fails due to a condition such as a deadlock, the kubelet kills the container.
# See: https://docs.openshift.com/container-platform/4.6/applications/application-health.html
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet core/ReplicationController apps/StatefulSet core/Pod batch/CronJob
package ocp.bestpractices.container_livenessprobe_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00008")
  container := openshift.containers[_]

  konstraint_core.missing_field(container, "livenessProbe")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has no livenessProbe. See: https://docs.openshift.com/container-platform/4.6/applications/application-health.html", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00008")
}