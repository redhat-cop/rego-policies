# @title RHCOP-OCP_DEPRECATED-3_11-00006: Route no longer served by v1
#
# OCP4.x expects route.openshift.io/v1.
#
# @skip-constraint
# @kinds v1/Route
package ocp.deprecated.ocp3_11.route_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.apiVersion) == "v1"
  lower(konstraint_core.kind) == "route"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: API v1 for Route is no longer served by default, use route.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-3.11-00006")
}
