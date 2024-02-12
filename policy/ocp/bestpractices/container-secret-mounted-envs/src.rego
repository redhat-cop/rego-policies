# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00016: Container secret not mounted as envs'
# description: |-
#   The content of Secret resources should be mounted into containers as volumes rather than passed in as environment variables.
#   This is to prevent that the secret values appear in the command that was used to start the container, which may be inspected
#   by individuals that shouldn't have access to the secret values.
#   See: Configuration and secrets -> https://learnk8s.io/production-best-practices#application-development
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
package ocp.bestpractices.container_secret_mounted_envs

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00016")
  container := openshift.containers[_]

  env := container.env[_]
  env.valueFrom.secretKeyRef

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' has a secret '%s' mounted as an environment variable. Secrets are meant to be secret, it is not a good practice to mount them as env vars.", [konstraint_core.kind, konstraint_core.name, container.name, env.valueFrom.secretKeyRef.name]), "RHCOP-OCP_BESTPRACT-00016")
}
