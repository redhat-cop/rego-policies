package ocp.bestpractices.container_labelkey_inconsistent

import data.lib.konstraint
import data.lib.openshift

# violation: Check workload kinds have consistent key names for their labels
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  some key
  obj := konstraint.object
  value := obj.metadata.labels[key]

  not label_key_starts_with_expected(key)

  msg := konstraint.format(sprintf("%s/%s: has a label key which did not start with 'app.kubernetes.io/' or 'redhat-cop.github.com/'. Found '%s'", [obj.kind, obj.metadata.name, key]))
}

label_key_starts_with_expected(key) {
  startswith(key, "app.kubernetes.io/")
}

label_key_starts_with_expected(key) {
  startswith(key, "redhat-cop.github.com/")
}