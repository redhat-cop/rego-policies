# @title RHCOP-OCP_DEPRECATED-3.11-00003: ImageStream no longer served by v1
#
# OCP4.x expects image.openshift.io/v1.
#
# @kinds v1/ImageStream
package ocp.deprecated.ocp3_11.imagestream_v1

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.apiVersion) == "v1"
  lower(konstraint_core.kind) == "imagestream"

  msg := konstraint_core.format_with_id(sprintf("%s/%s: API v1 for ImageStream is no longer served by default, use image.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-3.11-00003")
}