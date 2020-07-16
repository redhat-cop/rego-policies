package ocp.deprecated.ocp4_2.automationbroker_v1alpha1

import data.lib.konstraint

# violation: Check for deprecated automationbroker.io/v1alpha1 apiVersion. See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
# @Kinds automationbroker.io/Bundle automationbroker.io/BundleBinding automationbroker.io/BundleInstance
violation[msg] {
  obj := konstraint.object
  contains(lower(obj.apiVersion), "automationbroker.io/v1alpha1")

  msg := konstraint.format(sprintf("%s/%s: automationbroker.io/v1alpha1 is deprecated.", [obj.kind, obj.metadata.name]))
}