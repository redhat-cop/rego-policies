# @title RHCOP-OCP_BESTPRACT-00020: Pod hostnetwork not set
#
# Pods which require 'spec.hostNetwork' should be limited due to security concerns.
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet core/ReplicationController apps/StatefulSet core/Pod batch/CronJob
package ocp.bestpractices.pod_hostnetwork

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00020")
  openshift.pod.spec.hostNetwork

  msg := konstraint_core.format_with_id(sprintf("%s/%s: hostNetwork is present which gives the pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other pods on the same node.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_BESTPRACT-00020")
}