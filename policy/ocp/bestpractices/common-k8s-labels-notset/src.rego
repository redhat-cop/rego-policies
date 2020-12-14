package ocp.bestpractices.common_k8s_labels_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

# @title Common k8s labels are set
#
# Check if all workload related kinds contain labels as suggested by k8s.
# See: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet core/Service route.openshift.io/Route
violation[msg] {
  openshift.is_all_kind

  obj := konstraint.object
  not is_common_labels_set(obj.metadata)

  msg := konstraint_core.format(sprintf("%s/%s: does not contain all the expected k8s labels in 'metadata.labels'. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels", [konstraint_core.kind, konstraint_core.name]))
}

is_common_labels_set(metadata) {
  metadata.labels["app.kubernetes.io/name"]
  metadata.labels["app.kubernetes.io/instance"]
  metadata.labels["app.kubernetes.io/version"]
  metadata.labels["app.kubernetes.io/component"]
  metadata.labels["app.kubernetes.io/part-of"]
  metadata.labels["app.kubernetes.io/managed-by"]
}