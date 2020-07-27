package ocp.deprecated.ocp4_2.osb_v1

import data.lib.konstraint

# violation: Check for deprecated osb.openshift.io/v1 apiVersion. See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
# @kinds osb.openshift.io/TemplateServiceBroker osb.openshift.io/AutomationBroker
violation[msg] {
  obj := konstraint.object
  contains(lower(obj.apiVersion), "osb.openshift.io/v1")

  msg := konstraint.format(sprintf("%s/%s: osb.openshift.io/v1 is deprecated.", [obj.kind, obj.metadata.name]))
}