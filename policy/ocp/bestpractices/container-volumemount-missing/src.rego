# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00018: Container volume mount not set'
# description: A volume does not have a corresponding volume mount. There is probably
#   a mistake in your definition.
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - ""
#       kinds:
#       - Pod
#       - ReplicationController
#     - apiGroups:
#       - apps
#       kinds:
#       - DaemonSet
#       - Deployment
#       - Job
#       - ReplicaSet
#       - StatefulSet
#     - apiGroups:
#       - apps.openshift.io
#       kinds:
#       - DeploymentConfig
#     - apiGroups:
#       - batch
#       kinds:
#       - CronJob
package ocp.bestpractices.container_volumemount_missing

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00018")
  volume := openshift.pod.spec.volumes[_]

  not containers_volumemounts_contains_volume(openshift.containers, volume)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: volume '%s' does not have a volumeMount in any of the containers.", [konstraint_core.kind, konstraint_core.name, volume.name]), "RHCOP-OCP_BESTPRACT-00018")
}

containers_volumemounts_contains_volume(containers, volume) {
  containers[_].volumeMounts[_].name == volume.name
}