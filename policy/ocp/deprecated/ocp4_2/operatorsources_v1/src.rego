# METADATA
# title: 'RHCOP-OCP_DEPRECATED-ocp4_2-00005: operators coreos com v1 OperatorSource is
#   deprecated'
# description: |-
#   'operators.coreos.com/v1:OperatorSource' is deprecated in OCP 4.2 and will be removed in a future version.
#   See: https://docs.redhat.com/en/documentation/openshift_container_platform/4.2/html/release_notes/ocp-4-2-release-notes#ocp-4-2-deprecated-features
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - operators.coreos.com
#       kinds:
#       - OperatorSource
#   skipConstraint: true
package ocp.deprecated.ocp4_2.operatorsources_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
	contains(lower(konstraint_core.api_version), "operators.coreos.com/v1")
	lower(konstraint_core.kind) == "operatorsource"

	msg := konstraint_core.format_with_id(sprintf("%s/%s: operators.coreos.com/v1 is deprecated.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00005")
}
