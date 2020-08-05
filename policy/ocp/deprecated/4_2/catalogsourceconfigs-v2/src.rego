package ocp.deprecated.ocp4_2.catalogsourceconfigs_v2

import data.lib.konstraint

# @title operators coreos com v2 CatalogSourceConfigs is deprecated
#
# 'operators.coreos.com/v2:CatalogSourceConfigs' is deprecated in OCP 4.2 and removed in 4.5.
# See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
# See: https://docs.openshift.com/container-platform/4.5/release_notes/ocp-4-5-release-notes.html#ocp-4-5-deprecated-removed-features
#
# @kinds operators.coreos.com/CatalogSourceConfigs
violation[msg] {
  obj := konstraint.object
  contains(lower(obj.apiVersion), "operators.coreos.com/v2")
  lower(obj.kind) == "catalogsourceconfigs"

  msg := konstraint.format(sprintf("%s/%s: operators.coreos.com/v2 is deprecated.", [obj.kind, obj.metadata.name]))
}