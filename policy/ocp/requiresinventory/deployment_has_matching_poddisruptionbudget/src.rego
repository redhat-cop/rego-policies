# METADATA
# title: 'RHCOP-OCP_REQ_INV-00001: Deployment has a matching PodDisruptionBudget'
# description: |-
#   All Deployments should have matching PodDisruptionBudget, via 'spec.template.metadata.labels', to provide HA guarantees.
#   See: Fault tolerance -> https://learnk8s.io/production-best-practices#application-development
#   See: https://kubernetes.io/docs/tasks/run-application/configure-pdb/
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - apps
#       kinds:
#       - Deployment
package ocp.requiresinventory.deployment_has_matching_poddisruptionbudget

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_REQ_INV-00001")
	kubernetes.is_deployment

	deployment := konstraint_core.resource

	not _has_matching_poddisruptionbudget(deployment, data.inventory.namespace[deployment.metadata.namespace])

	msg := konstraint_core.format_with_id(sprintf("%s/%s does not have a policy/v1:PodDisruptionBudget or its selector labels dont match. See: https://kubernetes.io/docs/tasks/run-application/configure-pdb/#specifying-a-poddisruptionbudget", [deployment.kind, deployment.metadata.name]), "RHCOP-OCP_REQ_INV-00001")
}

_has_matching_poddisruptionbudget(deployment, manifests) {
	cached := manifests["policy/v1"].PodDisruptionBudget
	some current in cached

	deployment.spec.template.metadata.labels == current.spec.selector.matchLabels
}
