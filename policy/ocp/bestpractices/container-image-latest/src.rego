package ocp.bestpractices.container_image_latest

import data.lib.konstraint
import data.lib.openshift

# @title Container image is not set as latest
#
# Images should use immutable tags. Today's latest is not tomorrows latest.
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  endswith(container.image, ":latest")
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: container '%s' is using the latest tag for its image (%s), which is an anti-pattern.", [obj.kind, obj.metadata.name, container.name, container.image]))
}