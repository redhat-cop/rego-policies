package ocp.deprecated.ocp3_11.securitycontextconstraints_v1

import data.lib.konstraint.core as konstraint_core

# @title SecurityContextConstraints no longer served by v1
#
# OCP4.x expects security.openshift.io/v1.
#
# @kinds v1/SecurityContextConstraints
violation[msg] {
  lower(konstraint_core.apiVersion) == "v1"
  lower(konstraint_core.kind) == "securitycontextconstraints"

  msg := konstraint_core.format(sprintf("%s/%s: API v1 for SecurityContextConstraints is no longer served by default, use security.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]))
}