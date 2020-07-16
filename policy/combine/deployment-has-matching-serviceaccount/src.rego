package combine.deployment_has_matching_serviceaccount

import data.lib.konstraint

# violation: Check if a Deployment has 'spec.serviceAccountName' set, there is a matching v1:ServiceAccount
# @Kinds apps/Deployment core/ServiceAccount
violation[msg] {
  manifests := input[_]
  some i

  lower(manifests[i].apiVersion) == "apps/v1"
  lower(manifests[i].kind) == "deployment"
  deployment := manifests[i]
  deployment.spec.serviceAccountName

  not deployment_has_matching_serviceaccount(deployment, manifests)

  msg := sprintf("%s/%s has spec.serviceAccountName '%s' but could not find corrasponding v1:ServiceAccount.", [deployment.kind, deployment.metadata.name, deployment.spec.serviceAccountName])
}

deployment_has_matching_serviceaccount(deployment, manifests) {
  current := manifests[_]

  lower(current.apiVersion) == "v1"
  lower(current.kind) == "serviceaccount"

  deployment.spec.serviceAccountName == current.metadata.name
}