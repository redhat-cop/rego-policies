package ocp.bestpractices.container_secret_mounted_envs

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

# @title RHCOP-OCP_BESTPRACT-00016: Container secret not mounted as envs
#
# The content of Secret resources should be mounted into containers as volumes rather than passed in as environment variables.
# This is to prevent that the secret values appear in the command that was used to start the container, which may be inspected
# by individuals that shouldn't have access to the secret values.
# See: Configuration and secrets -> https://learnk8s.io/production-best-practices#application-development
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet core/ReplicationController apps/StatefulSet core/Pod batch/CronJob
violation[msg] {
  container := openshift.containers[_]

  env := container.env[_]
  env.valueFrom.secretKeyRef

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has a secret '%s' mounted as an environment variable. As secrets are not secret, its not good practice to mount as env vars.", [konstraint_core.kind, konstraint_core.name, container.name, env.valueFrom.secretKeyRef.name]), "RHCOP-OCP_BESTPRACT-00016")
}