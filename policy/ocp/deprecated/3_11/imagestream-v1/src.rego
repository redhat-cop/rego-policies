package ocp.deprecated.ocp3_11.imagestream_v1

import data.lib.konstraint.core as konstraint_core

# @title ImageStream no longer served by v1
#
# OCP4.x expects image.openshift.io/v1.
#
# @kinds v1/ImageStream
violation[msg] {
  obj := konstraint.object
  lower(obj.apiVersion) == "v1"
  lower(obj.kind) == "imagestream"

  msg := konstraint_core.format(sprintf("%s/%s: API v1 for ImageStream is no longer served by default, use image.openshift.io/v1 instead.", [konstraint_core.kind, konstraint_core.name]))
}