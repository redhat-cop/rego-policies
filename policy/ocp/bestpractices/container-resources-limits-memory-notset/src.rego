# @title RHCOP-OCP_BESTPRACT-00012: Container resource limits memory not set
#
# A container without a memory limit has memory utilisation of zero — according to the scheduler.
# An unlimited number of Pods if schedulable on any nodes leading to resource overcommitment and potential node (and kubelet) crashes.
# See: Resources utilisation -> https://learnk8s.io/production-best-practices#application-development
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet core/ReplicationController apps/StatefulSet core/Pod batch/CronJob
package ocp.bestpractices.container_resources_limits_memory_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00012")
  container := openshift.containers[_]

  # TODO: Maybe should use below factored out?
  #konstraint.missing_field(container.resources.limits, "memory")
  not container.resources.limits.memory

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has no memory limits. It is recommended to limit memory, as memory always has a maximum. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers", [konstraint_core.kind, konstraint_core.name, container.name]), "RHCOP-OCP_BESTPRACT-00012")
}