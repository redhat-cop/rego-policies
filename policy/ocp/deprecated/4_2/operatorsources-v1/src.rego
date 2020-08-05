package ocp.deprecated.ocp4_2.operatorsources_v1

import data.lib.konstraint

# @title operators coreos com v1 OperatorSource is deprecated
#
# 'operators.coreos.com/v1:OperatorSource' is deprecated in OCP 4.2 and will be removed in a future version.
# See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
#
# @kinds operators.coreos.com/OperatorSource
violation[msg] {
  obj := konstraint.object
  contains(lower(obj.apiVersion), "operators.coreos.com/v1")
  lower(obj.kind) == "operatorsource"

  msg := konstraint.format(sprintf("%s/%s: operators.coreos.com/v1 is deprecated.", [obj.kind, obj.metadata.name]))
}