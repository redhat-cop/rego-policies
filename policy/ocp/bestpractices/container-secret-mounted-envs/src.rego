package ocp.bestpractices.container_secret_mounted_envs

import data.lib.konstraint
import data.lib.openshift

# violation: Check workload kinds do not have secrets mounted as envs
# @Kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  env := container.env[_]
  env.valueFrom.secretKeyRef
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: container '%s' has a secret '%s' mounted as an environment variable. As secrets are not secret, its not good practice to mount as env vars.", [obj.kind, obj.metadata.name, container.name, env.valueFrom.secretKeyRef.name]))
}