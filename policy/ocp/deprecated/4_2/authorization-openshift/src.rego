package ocp.deprecated.ocp4_2.authorization_openshift

import data.lib.konstraint

# @title authorization openshift io is deprecated
#
# From OCP4.2 onwards, you should migrate from 'authorization.openshift.io' to rbac.authorization.k8s.io/v1.
# See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
#
# @kinds authorization.openshift.io/ClusterRole authorization.openshift.io/ClusterRoleBinding authorization.openshift.io/Role authorization.openshift.io/RoleBinding
violation[msg] {
  obj := konstraint.object
  contains(lower(obj.apiVersion), "authorization.openshift.io")

  msg := konstraint.format(sprintf("%s/%s: API authorization.openshift.io for ClusterRole, ClusterRoleBinding, Role and RoleBinding is deprecated, use rbac.authorization.k8s.io/v1 instead.", [obj.kind, obj.metadata.name]))
}