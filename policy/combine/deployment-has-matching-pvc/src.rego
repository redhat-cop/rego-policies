package combine.deployment_has_matching_pvc

import data.lib.konstraint

# violation: Check if a Deployment has 'spec.template.spec.volumes.persistentVolumeClaim' set, there is a matching v1:PersistentVolumeClaim
# @Kinds apps/Deployment core/PersistentVolumeClaim
violation[msg] {
  manifests := input[_]
  some i

  lower(manifests[i].apiVersion) == "apps/v1"
  lower(manifests[i].kind) == "deployment"
  deployment := manifests[i]
  deployment.spec.template.spec.volumes[_].persistentVolumeClaim

  not deployment_has_matching_persistentvolumeclaim(deployment, manifests)

  msg := sprintf("%s/%s has persistentVolumeClaim in its spec.template.spec.volumes but could not find corrasponding v1:PersistentVolumeClaim.", [deployment.kind, deployment.metadata.name])
}

deployment_has_matching_persistentvolumeclaim(deployment, manifests) {
  current := manifests[_]

  lower(current.apiVersion) == "v1"
  lower(current.kind) == "persistentvolumeclaim"

  deployment.spec.template.spec.volumes[_].persistentVolumeClaim.claimName == current.metadata.name
}