package podman.images.image_size_not_greater_than

import data.lib.konstraint.core as konstraint_core
import data.lib.memory

# @title Image size is not greater than an expected value
#
# Typically, the "smaller the better" rule applies to images so lets enforce that.
#
# @kinds redhat-cop.github.com/PodmanImages
# parameter image_size_upperbound integer
violation[msg] {
  lower(input.apiVersion) == "redhat-cop.github.com/v1"
  lower(input.kind) == "podmanimages"

  image := input.items[_]
  sizeInMb := image.size / memory.mb
  sizeInMb > data.parameters.image_size_upperbound

  msg := konstraint_core.format(sprintf("%s: has a size of '%fMi', which is greater than '%dMi' limit.", [input.image, sizeInMb, data.parameters.image_size_upperbound]))
}