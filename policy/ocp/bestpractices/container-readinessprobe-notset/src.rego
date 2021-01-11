package ocp.bestpractices.container_readinessprobe_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

# @title RHCOP-OCP_BESTPRACT-00009: Container readiness prob is not set
#
# A Readiness check determines if the container in which it is scheduled is ready to service requests.
# If the readiness probe fails a container, the endpoints controller ensures the container has its IP address removed from the endpoints of all services.
# See: https://docs.openshift.com/container-platform/4.6/applications/application-health.html
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet core/ReplicationController apps/StatefulSet core/Pod batch/CronJob
violation[msg] {
  container := openshift.containers[_]

  konstraint_core.missing_field(container, "readinessProbe")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has no readinessProbe. See: https://docs.openshift.com/container-platform/4.6/applications/application-health.html", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00009")
}