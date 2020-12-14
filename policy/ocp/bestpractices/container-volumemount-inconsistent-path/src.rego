package ocp.bestpractices.container_volumemount_inconsistent_path

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

# @title Container volume mount path is consistent
#
# Mount paths should be mounted at '/var/run/company.com' to allow a consistent understanding.
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]

  volumeMount := container.volumeMounts[_]
  not startswith(volumeMount.mountPath, "/var/run")
  obj := konstraint.object

  msg := konstraint_core.format(sprintf("%s/%s: container '%s' has a volumeMount '%s' mountPath at '%s'. A good practice is to use consistent mount paths, such as: /var/run/{organization}/{mount} - i.e.: /var/run/io.redhat-cop/my-secret", [konstraint_core.kind, konstraint_core.name, container.name, volumeMount.name, volumeMount.mountPath]))
}