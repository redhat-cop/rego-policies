package ocp.deprecated.ocp3_11.imagestream_v1

import data.lib.konstraint

# @title ImageStream no longer served by v1
#
# OCP4.x expects image.openshift.io/v1.
#
# @kinds v1/ImageStream
violation[msg] {
  obj := konstraint.object
  lower(obj.apiVersion) == "v1"
  lower(obj.kind) == "imagestream"

  msg := konstraint.format(sprintf("%s/%s: API v1 for ImageStream is no longer served by default, use image.openshift.io/v1 instead.", [obj.kind, obj.metadata.name]))
}