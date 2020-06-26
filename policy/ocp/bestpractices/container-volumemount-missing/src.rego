package ocp.bestpractices.container_volumemount_missing

import data.lib.konstraint
import data.lib.openshift

# violation: Check workload kinds does not specify a volume without a corresponding volume mount
# @Kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  volume := openshift.pods[_].spec.volumes[_]

  not containers_volumemounts_contains_volume(openshift.containers, volume)
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: volume '%s' does not have a volumeMount in any of the containers.", [obj.kind, obj.metadata.name, volume.name]))
}

containers_volumemounts_contains_volume(containers, volume) {
  containers[_].volumeMounts[_].name == volume.name
}