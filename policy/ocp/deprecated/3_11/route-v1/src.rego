package ocp.deprecated.ocp3_11.route_v1

import data.lib.konstraint.core as konstraint_core

# @title Route no longer served by v1
#
# OCP4.x expects route.openshift.io/v1.
#
# @kinds v1/Route
violation[msg] {
  obj := konstraint.object
  lower(obj.apiVersion) == "v1"
  lower(obj.kind) == "route"

  msg := konstraint_core.format(sprintf("%s/%s: API v1 for Route is no longer served by default, use route.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]))
}
