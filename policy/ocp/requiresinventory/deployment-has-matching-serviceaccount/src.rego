package ocp.requiresinventory.deployment_has_matching_serviceaccount

import data.lib.konstraint

# violation: Check if a Deployment has 'spec.serviceAccountName' set, there is a matching v1:ServiceAccount
# @Kinds apps/Deployment
violation[msg] {
  konstraint.is_deployment

  deployment := konstraint.object
  deployment.spec.template.spec.serviceAccountName

  not deployment_has_matching_serviceaccount(deployment, data.inventory.namespace[deployment.metadata.namespace])

  msg := konstraint.format(sprintf("%s/%s has spec.serviceAccountName '%s' but could not find corrasponding v1:ServiceAccount.", [deployment.kind, deployment.metadata.name, deployment.spec.template.spec.serviceAccountName]))
}

deployment_has_matching_serviceaccount(deployment, manifests) {
  cached := manifests["v1"]["ServiceAccount"]
  current := cached[_]

  deployment.spec.template.spec.serviceAccountName == current.metadata.name
}