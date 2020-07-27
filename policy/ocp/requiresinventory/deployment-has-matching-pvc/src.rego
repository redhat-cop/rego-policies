package ocp.requiresinventory.deployment_has_matching_pvc

import data.lib.konstraint

# violation: Check if a Deployment has 'spec.template.spec.volumes.persistentVolumeClaim' set, there is a matching v1:PersistentVolumeClaim
# @Kinds apps/Deployment
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