package podman.images.image_size_not_greater_than

import data.lib.memory

# violation: Check the image size is not greater than a specific value
# @kinds redhat-cop.github.com/PodmanImages
violation[msg] {
  lower(input.apiVersion) == "redhat-cop.github.com/v1"
  lower(input.kind) == "podmanimages"

  #NOTE: upperBound is an arbitrary number and it should be changed to what your company believes is the correct policy
  upperBound := 512

  image := input.items[_]
  sizeInMb := image.size / memory.mb
  sizeInMb > upperBound

  msg := sprintf("%s: has a size of '%fMi', which is greater than '%dMi' limit.", [input.image, sizeInMb, upperBound])
}