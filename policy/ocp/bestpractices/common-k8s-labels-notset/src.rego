# @title RHCOP-OCP_BESTPRACT-00001: Common k8s labels are set
#
# Check if all workload related kinds contain labels as suggested by k8s.
# See: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet core/ReplicationController apps/StatefulSet core/Pod batch/CronJob core/Service route.openshift.io/Route
package ocp.bestpractices.common_k8s_labels_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00001")
  openshift.is_pod_or_networking

  not is_common_labels_set(konstraint_core.resource.metadata)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: does not contain all the expected k8s labels in 'metadata.labels'. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_BESTPRACT-00001")
}

is_common_labels_set(metadata) {
  metadata.labels["app.kubernetes.io/name"]
  metadata.labels["app.kubernetes.io/instance"]
  metadata.labels["app.kubernetes.io/version"]
  metadata.labels["app.kubernetes.io/component"]
  metadata.labels["app.kubernetes.io/part-of"]
  metadata.labels["app.kubernetes.io/managed-by"]
}