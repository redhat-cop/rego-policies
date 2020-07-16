package ocp.deprecated.ocp4_2.catalogsourceconfigs_v2

import data.lib.konstraint

# violation: Check for deprecated operators.coreos.com/v2 apiVersion. See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
# @Kinds operators.coreos.com/CatalogSourceConfigs
violation[msg] {
  obj := konstraint.object
  contains(lower(obj.apiVersion), "operators.coreos.com/v2")

  msg := konstraint.format(sprintf("%s/%s: operators.coreos.com/v2 is deprecated.", [obj.kind, obj.metadata.name]))
}