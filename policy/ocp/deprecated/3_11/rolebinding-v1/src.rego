# @title RHCOP-OCP_DEPRECATED-3.11-00005: RoleBinding no longer served by v1
#
# OCP4.x expects rbac.authorization.k8s.io/v1
#
# @kinds v1/RoleBinding
package ocp.deprecated.ocp3_11.rolebinding_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.apiVersion) == "v1"
  lower(konstraint_core.kind) == "rolebinding"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: API v1 for RoleBinding is no longer served by default, use rbac.authorization.k8s.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-3.11-00005")
}