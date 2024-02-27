# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00023: RoleBinding has apiGroup set'
# description: Migrating from 3.11 to 4.x requires the 'roleRef.apiGroup' to be set.
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - rbac.authorization.k8s.io
#       kinds:
#       - RoleBinding
#   skipConstraint: true
package ocp.bestpractices.rolebinding_roleref_apigroup_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes

violation[msg] {
	kubernetes.is_rolebinding

	konstraint_core.missing_field(konstraint_core.resource.roleRef, "apiGroup")

	msg := konstraint_core.format_with_id(sprintf("%s/%s: RoleBinding roleRef.apiGroup key is null, use rbac.authorization.k8s.io instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_BESTPRACT-00023")
}
