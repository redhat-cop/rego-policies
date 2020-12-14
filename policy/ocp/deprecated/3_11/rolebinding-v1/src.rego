package ocp.deprecated.ocp3_11.rolebinding_v1

import data.lib.konstraint.core as konstraint_core

# @title RoleBinding no longer served by v1
#
# OCP4.x expects rbac.authorization.k8s.io/v1
#
# @kinds v1/RoleBinding
violation[msg] {
  obj := konstraint.object
  lower(obj.apiVersion) == "v1"
  lower(obj.kind) == "rolebinding"

  msg := konstraint_core.format(sprintf("%s/%s: API v1 for RoleBinding is no longer served by default, use rbac.authorization.k8s.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]))
}