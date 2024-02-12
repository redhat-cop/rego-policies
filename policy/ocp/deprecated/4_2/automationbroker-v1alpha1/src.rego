# METADATA
# title: 'RHCOP-OCP_DEPRECATED-4_2-00002: automationbroker io v1alpha1 is deprecated'
# description: |-
#   'automationbroker.io/v1alpha1' is deprecated in OCP 4.2 and removed in 4.4.
#   See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
#   See: https://docs.openshift.com/container-platform/4.4/release_notes/ocp-4-4-release-notes.html#ocp-4-4-deprecated-removed-features
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - automationbroker.io
#       kinds:
#       - Bundle
#       - BundleBinding
#       - BundleInstance
#   skipConstraint: true
package ocp.deprecated.ocp4_2.automationbroker_v1alpha1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  contains(lower(konstraint_core.apiVersion), "automationbroker.io/v1alpha1")

  msg := konstraint_core.format_with_id(sprintf("%s/%s: automationbroker.io/v1alpha1 is deprecated.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.2-00002")
}