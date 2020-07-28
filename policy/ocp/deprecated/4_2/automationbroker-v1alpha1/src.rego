package ocp.deprecated.ocp4_2.automationbroker_v1alpha1

import data.lib.konstraint

# @title automationbroker io v1alpha1 is deprecated
#
# 'automationbroker.io/v1alpha1' is deprecated in OCP 4.2 and removed in 4.4.
# See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
# See: https://docs.openshift.com/container-platform/4.4/release_notes/ocp-4-4-release-notes.html#ocp-4-4-deprecated-removed-features
#
# @kinds automationbroker.io/Bundle automationbroker.io/BundleBinding automationbroker.io/BundleInstance
violation[msg] {
  obj := konstraint.object
  contains(lower(obj.apiVersion), "automationbroker.io/v1alpha1")

  msg := konstraint.format(sprintf("%s/%s: automationbroker.io/v1alpha1 is deprecated.", [obj.kind, obj.metadata.name]))
}