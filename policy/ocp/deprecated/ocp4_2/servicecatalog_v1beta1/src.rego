# METADATA
# title: 'RHCOP-OCP_DEPRECATED-ocp4_2-00007: servicecatalog k8s io v1beta1 is deprecated'
# description: |-
#   'servicecatalog.k8s.io/v1beta1' is deprecated in OCP 4.2 and removed in 4.5.
#   See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
#   See: https://docs.openshift.com/container-platform/4.5/release_notes/ocp-4-5-release-notes.html#ocp-4-5-deprecated-removed-features
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - servicecatalog.k8s.io
#       kinds:
#       - ClusterServiceBroker
#       - ClusterServiceClass
#       - ClusterServicePlan
#       - ServiceBinding
#       - ServiceInstance
#   skipConstraint: true
package ocp.deprecated.ocp4_2.servicecatalog_v1beta1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
	contains(lower(konstraint_core.api_version), "servicecatalog.k8s.io/v1beta1")

	msg := konstraint_core.format_with_id(sprintf("%s/%s: servicecatalog.k8s.io/v1beta1 is deprecated.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00007")
}
