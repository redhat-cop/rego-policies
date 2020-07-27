package ocp.requiresinventory.deployment_has_matching_poddisruptionbudget

import data.lib.konstraint

# violation: Check if a Deployment has a matching policy/v1beta1:PodDisruptionBudget, via 'spec.template.metadata.labels'
# @kinds apps/Deployment
violation[msg] {
  konstraint.is_deployment

  deployment := konstraint.object

  not deployment_has_matching_poddisruptionbudget(deployment, data.inventory.namespace[deployment.metadata.namespace])

  msg := konstraint.format(sprintf("%s/%s does not have a policy/v1beta1:PodDisruptionBudget or its selector labels dont match. See: https://kubernetes.io/docs/tasks/run-application/configure-pdb/#specifying-a-poddisruptionbudget", [deployment.kind, deployment.metadata.name]))
}

deployment_has_matching_poddisruptionbudget(deployment, manifests) {
  cached := manifests["policy/v1beta1"]["PodDisruptionBudget"]
  current := cached[_]

  deployment.spec.template.metadata.labels == current.spec.selector.matchLabels
}