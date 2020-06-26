package ocp.bestpractices.rolebinding_roleref_apigroup_notset

import data.lib.konstraint
import data.lib.kubernetes

# violation: Check if a RoleBinding has 'roleRef.apiGroup' set
# @Kinds rbac.authorization.k8s.io/RoleBinding
violation[msg] {
  kubernetes.is_rolebinding

  obj := konstraint.object
  konstraint.missing_field(obj.roleRef, "apiGroup")

  msg := konstraint.format(sprintf("%s/%s: RoleBinding roleRef.apiGroup key is null, use rbac.authorization.k8s.io instead.", [obj.kind, obj.metadata.name]))
}