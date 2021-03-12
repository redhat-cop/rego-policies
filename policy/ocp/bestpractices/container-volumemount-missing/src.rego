# @title RHCOP-OCP_BESTPRACT-00018: Container volume mount not set
#
# A volume does not have a corresponding volume mount. There is probably a mistake in your definition.
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet core/ReplicationController apps/StatefulSet core/Pod batch/CronJob
package ocp.bestpractices.container_volumemount_missing

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  volume := openshift.pod.spec.volumes[_]

  not containers_volumemounts_contains_volume(openshift.containers, volume)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: volume '%s' does not have a volumeMount in any of the containers.", [konstraint_core.kind, konstraint_core.name, volume.name]), "RHCOP-OCP_BESTPRACT-00018")
}

containers_volumemounts_contains_volume(containers, volume) {
  containers[_].volumeMounts[_].name == volume.name
}