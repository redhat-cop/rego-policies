package ocp.requiresinventory.deployment_has_matching_pvc

import data.lib.konstraint

# @title Deployment has matching PersistentVolumeClaim
#
# If Deployment has 'spec.template.spec.volumes.persistentVolumeClaim' set, there should be matching PersistentVolumeClaim.
# If not, this would suggest a mistake.
#
# @kinds apps/Deployment
violation[msg] {
  konstraint.is_deployment

  deployment := konstraint.object
  deployment.spec.template.spec.volumes[_].persistentVolumeClaim

  not deployment_has_matching_persistentvolumeclaim(deployment, data.inventory.namespace[deployment.metadata.namespace])

  msg := konstraint.format(sprintf("%s/%s has persistentVolumeClaim in its spec.template.spec.volumes but could not find corrasponding v1:PersistentVolumeClaim.", [deployment.kind, deployment.metadata.name]))
}

deployment_has_matching_persistentvolumeclaim(deployment, manifests) {
  cached := manifests["v1"]["PersistentVolumeClaim"]
  current := cached[_]

  deployment.spec.template.spec.volumes[_].persistentVolumeClaim.claimName == current.metadata.name
}