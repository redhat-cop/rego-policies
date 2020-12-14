package ocp.bestpractices.rolebinding_roleref_apigroup_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes

# @title RoleBinding has apiGroup set
#
# Migrating from 3.11 to 4.x requires the 'roleRef.apiGroup' to be set.
#
# @kinds rbac.authorization.k8s.io/RoleBinding
violation[msg] {
  kubernetes.is_rolebinding

  konstraint_core.missing_field(konstraint_core.resource.roleRef, "apiGroup")

  msg := konstraint_core.format(sprintf("%s/%s: RoleBinding roleRef.apiGroup key is null, use rbac.authorization.k8s.io instead.", [konstraint_core.kind, konstraint_core.name]))
}