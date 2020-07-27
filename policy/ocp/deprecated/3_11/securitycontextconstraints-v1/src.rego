package ocp.deprecated.ocp3_11.securitycontextconstraints_v1

import data.lib.konstraint

# @title SecurityContextConstraints no longer served by v1
#
# OCP4.x expects security.openshift.io/v1.
#
# @kinds v1/SecurityContextConstraints
violation[msg] {
  obj := konstraint.object
  lower(obj.apiVersion) == "v1"
  lower(obj.kind) == "securitycontextconstraints"

  msg := konstraint.format(sprintf("%s/%s: API v1 for SecurityContextConstraints is no longer served by default, use security.openshift.io/v1 instead.", [obj.kind, obj.metadata.name]))
}