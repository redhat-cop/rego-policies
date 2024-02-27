# METADATA
# title: 'RHCOP-OCP_REQ_INV-00003: Deployment has a matching Service'
# description: |-
#   All Deployments should have matching Service, via 'spec.template.metadata.labels'.
#   Deployments without a Service are not accessible and should be questioned as to why.
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - apps
#       kinds:
#       - Deployment
package ocp.requiresinventory.deployment_has_matching_service

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_REQ_INV-00003")
	kubernetes.is_deployment

	deployment := konstraint_core.resource

	not deployment_labels_matches_service_selector(deployment, data.inventory.namespace[deployment.metadata.namespace])

	msg := konstraint_core.format_with_id(sprintf("%s/%s does not have a v1:Service or its selector labels dont match. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#service-and-replicationcontroller", [deployment.kind, deployment.metadata.name]), "RHCOP-OCP_REQ_INV-00003")
}

deployment_labels_matches_service_selector(deployment, manifests) {
	cached := manifests.v1.Service
	some current in cached

	deployment.spec.template.metadata.labels == current.spec.selector
}
