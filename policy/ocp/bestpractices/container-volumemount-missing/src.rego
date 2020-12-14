package ocp.bestpractices.container_volumemount_missing

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

# @title Container volume mount not set
#
# A volume does not have a corresponding volume mount. There is probably a mistake in your definition.
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  volume := openshift.pods[_].spec.volumes[_]

  not containers_volumemounts_contains_volume(openshift.containers, volume)
  obj := konstraint.object

  msg := konstraint_core.format(sprintf("%s/%s: volume '%s' does not have a volumeMount in any of the containers.", [konstraint_core.kind, konstraint_core.name, volume.name]))
}

containers_volumemounts_contains_volume(containers, volume) {
  containers[_].volumeMounts[_].name == volume.name
}