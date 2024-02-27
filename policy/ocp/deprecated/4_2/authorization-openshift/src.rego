# METADATA
# title: 'RHCOP-OCP_DEPRECATED-4_2-00001: authorization openshift io is deprecated'
# description: |-
#   From OCP4.2 onwards, you should migrate from 'authorization.openshift.io' to rbac.authorization.k8s.io/v1.
#   See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - authorization.openshift.io
#       kinds:
#       - ClusterRole
#       - ClusterRoleBinding
#       - Role
#       - RoleBinding
#   skipConstraint: true
package ocp.deprecated.ocp4_2.authorization_openshift

import data.lib.konstraint.core as konstraint_core

violation[msg] {
	contains(lower(konstraint_core.api_version), "authorization.openshift.io")

	msg := konstraint_core.format_with_id(sprintf("%s/%s: API authorization.openshift.io for ClusterRole, ClusterRoleBinding, Role and RoleBinding is deprecated, use rbac.authorization.k8s.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00001")
}
