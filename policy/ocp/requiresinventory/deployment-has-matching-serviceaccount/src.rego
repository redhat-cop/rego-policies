# METADATA
# title: 'RHCOP-OCP_REQ_INV-00004: Deployment has matching ServiceAccount'
# description: |-
#   If Deployment has 'spec.serviceAccountName' set, there should be matching ServiceAccount.
#   If not, this would suggest a mistake.
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - apps
#       kinds:
#       - Deployment
package ocp.requiresinventory.deployment_has_matching_serviceaccount

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_REQ_INV-00004")
  kubernetes.is_deployment

  deployment := konstraint_core.resource
  deployment.spec.template.spec.serviceAccountName

  not deployment_has_matching_serviceaccount(deployment, data.inventory.namespace[deployment.metadata.namespace])

  msg := konstraint_core.format_with_id(sprintf("%s/%s has spec.serviceAccountName '%s' but could not find corrasponding v1:ServiceAccount.", [deployment.kind, deployment.metadata.name, deployment.spec.template.spec.serviceAccountName]), "RHCOP-OCP_REQ_INV-00004")
}

deployment_has_matching_serviceaccount(deployment, manifests) {
  cached := manifests["v1"]["ServiceAccount"]
  current := cached[_]

  deployment.spec.template.spec.serviceAccountName == current.metadata.name
}