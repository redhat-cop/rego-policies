# METADATA
# title: 'RHCOP-OCP_DEPRECATED-3_11-00007: SecurityContextConstraints no longer served
#   by v1'
# description: OCP4.x expects security.openshift.io/v1.
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - v1
#       kinds:
#       - SecurityContextConstraints
#   skipConstraint: true
package ocp.deprecated.ocp3_11.securitycontextconstraints_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
	lower(konstraint_core.api_version) == "v1"
	lower(konstraint_core.kind) == "securitycontextconstraints"

	msg := konstraint_core.format_with_id(sprintf("%s/%s: API v1 for SecurityContextConstraints is no longer served by default, use security.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-3.11-00007")
}
