package ocp.bestpractices.rolebinding_roleref_kind_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes

# @title RoleBinding has kind set
#
# Migrating from 3.11 to 4.x requires the 'roleRef.kind' to be set.
#
# @kinds rbac.authorization.k8s.io/RoleBinding
violation[msg] {
  kubernetes.is_rolebinding

  obj := konstraint.object
  konstraint.missing_field(obj.roleRef, "kind")

  msg := konstraint.format(sprintf("%s/%s: RoleBinding roleRef.kind key is null, use ClusterRole or Role instead.", [obj.kind, obj.metadata.name]))
}