package ocp.bestpractices.rolebinding_roleref_kind_notset

import data.lib.konstraint
import data.lib.kubernetes

# violation: Check if a RoleBinding has 'roleRef.kind' set
# @Kinds rbac.authorization.k8s.io/RoleBinding
violation[msg] {
  kubernetes.is_rolebinding

  obj := konstraint.object
  konstraint.missing_field(obj.roleRef, "kind")

  msg := konstraint.format(sprintf("%s/%s: RoleBinding roleRef.kind key is null, use ClusterRole or Role instead.", [obj.kind, obj.metadata.name]))
}