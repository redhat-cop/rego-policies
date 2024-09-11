# METADATA
# title: 'RHCOP-OCP_DEPRECATED-ocp3_11-00001: BuildConfig no longer served by v1'
# description: OCP4.x expects build.openshift.io/v1.
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - v1
#       kinds:
#       - BuildConfig
#   skipConstraint: true
package ocp.deprecated.ocp3_11.buildconfig_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
	lower(konstraint_core.api_version) == "v1"
	lower(konstraint_core.kind) == "buildconfig"

	msg := konstraint_core.format_with_id(sprintf("%s/%s: API v1 for BuildConfig is no longer served by default, use build.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-3.11-00001")
}
