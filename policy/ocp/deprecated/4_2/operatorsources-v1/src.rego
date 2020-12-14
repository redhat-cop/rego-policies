package ocp.deprecated.ocp4_2.operatorsources_v1

import data.lib.konstraint.core as konstraint_core

# @title operators coreos com v1 OperatorSource is deprecated
#
# 'operators.coreos.com/v1:OperatorSource' is deprecated in OCP 4.2 and will be removed in a future version.
# See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
#
# @kinds operators.coreos.com/OperatorSource
violation[msg] {
  contains(lower(konstraint_core.apiVersion), "operators.coreos.com/v1")
  lower(konstraint_core.kind) == "operatorsource"

  msg := konstraint_core.format(sprintf("%s/%s: operators.coreos.com/v1 is deprecated.", [konstraint_core.kind, konstraint_core.name]))
}