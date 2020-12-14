package ocp.bestpractices.container_liveness_readinessprobe_equal

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

# @title Container liveness and readiness probes are equal
#
# When Liveness and Readiness probes are pointing to the same endpoint, the effects of the probes are combined.
# When the app signals that it's not ready or live, the kubelet detaches the container from the Service and delete it at the same time.
# You might notice dropping connections because the container does not have enough time to drain the current connections or process the incoming ones.
# See: Health checks -> https://learnk8s.io/production-best-practices#application-development
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  container.livenessProbe
  container.readinessProbe
  container.livenessProbe == container.readinessProbe
  obj := konstraint.object

  msg := konstraint_core.format(sprintf("%s/%s: container '%s' livenessProbe and readinessProbe are equal, which is an anti-pattern.", [konstraint_core.kind, konstraint_core.name, container.name]))
}