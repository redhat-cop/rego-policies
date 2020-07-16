package combine.deployment_has_matching_poddisruptionbudget

import data.lib.konstraint

# violation: Check if a Deployment has a matching policy/v1beta1:PodDisruptionBudget, via 'spec.template.metadata.labels'
# @Kinds apps/Deployment policy/PodDisruptionBudget
violation[msg] {
  manifests := input[_]
  some i

  lower(manifests[i].apiVersion) == "apps/v1"
  lower(manifests[i].kind) == "deployment"
  deployment := manifests[i]

  not deployment_has_matching_poddisruptionbudget(deployment, manifests)

  msg := sprintf("%s/%s does not have a policy/v1beta1:PodDisruptionBudget or its selector labels dont match. See: https://kubernetes.io/docs/tasks/run-application/configure-pdb/#specifying-a-poddisruptionbudget", [deployment.kind, deployment.metadata.name])
}

deployment_has_matching_poddisruptionbudget(deployment, manifests) {
  current := manifests[_]

  lower(current.apiVersion) == "policy/v1beta1"
  lower(current.kind) == "poddisruptionbudget"

  deployment.spec.template.metadata.labels == current.spec.selector.matchLabels
}