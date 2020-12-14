package ocp.bestpractices.container_labelkey_inconsistent

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

# @title Label key is consistent
#
# Label keys should be qualified by 'app.kubernetes.io' or 'company.com' to allow a consistent understanding.
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  some key
  obj := konstraint.object
  value := obj.metadata.labels[key]

  not label_key_starts_with_expected(key)

  msg := konstraint_core.format(sprintf("%s/%s: has a label key which did not start with 'app.kubernetes.io/' or 'redhat-cop.github.com/'. Found '%s'", [konstraint_core.kind, konstraint_core.name, key]))
}

label_key_starts_with_expected(key) {
  startswith(key, "app.kubernetes.io/")
}

label_key_starts_with_expected(key) {
  startswith(key, "redhat-cop.github.com/")
}