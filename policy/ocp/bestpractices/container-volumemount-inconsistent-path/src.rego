package ocp.bestpractices.container_volumemount_inconsistent_path

import data.lib.konstraint
import data.lib.openshift

# violation: Check workload kinds have consistent paths for their volume mounts
# @Kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  volumeMount := container.volumeMounts[_]
  not startswith(volumeMount.mountPath, "/var/run")
  obj := konstraint.object

  msg := konstraint.format(sprintf("%s/%s: container '%s' has a volumeMount '%s' mountPath at '%s'. A good practice is to use consistent mount paths, such as: /var/run/{organization}/{mount} - i.e.: /var/run/io.redhat-cop/my-secret", [obj.kind, obj.metadata.name, container.name, volumeMount.name, volumeMount.mountPath]))
}