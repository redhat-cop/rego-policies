# METADATA
# title: 'RHCOP-OCP_REQ_INV-00002: Deployment has matching PersistentVolumeClaim'
# description: |-
#   If Deployment has 'spec.template.spec.volumes.persistentVolumeClaim' set, there should be matching PersistentVolumeClaim.
#   If not, this would suggest a mistake.
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - apps
#       kinds:
#       - Deployment
package ocp.requiresinventory.deployment_has_matching_pvc

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_REQ_INV-00002")
	kubernetes.is_deployment

	deployment := konstraint_core.resource
	has_persistentvolumeclaim(deployment.spec.template.spec.volumes)

	not has_matching_persistentvolumeclaim(deployment, data.inventory.namespace[deployment.metadata.namespace])

	msg := konstraint_core.format_with_id(sprintf("%s/%s has persistentVolumeClaim in its spec.template.spec.volumes but could not find corrasponding v1:PersistentVolumeClaim.", [deployment.kind, deployment.metadata.name]), "RHCOP-OCP_REQ_INV-00002")
}

has_persistentvolumeclaim(volumes) {
	some volume in volumes
	volume.persistentVolumeClaim
}

has_matching_persistentvolumeclaim(deployment, manifests) {
	cached := manifests.v1.PersistentVolumeClaim
	some current in cached

	some volume in deployment.spec.template.spec.volumes
	volume.persistentVolumeClaim.claimName == current.metadata.name
}
