# METADATA
# title: 'RHCOP-PODMAN-00002: Image size is not greater than an expected value'
# description: |-
#   Typically, the "smaller the better" rule applies to images so lets enforce that.
#
#   parameter image_size_upperbound integer
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - redhat-cop.github.com
#       kinds:
#       - PodmanImages
#   skipConstraint: true
package podman.images.image_size_not_greater_than

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.memory

violation[msg] {
	lower(input.apiVersion) == "redhat-cop.github.com/v1"
	lower(input.kind) == "podmanimages"

	some image in input.items
	size_mb := image.size / memory.mb
	size_mb > data.parameters.image_size_upperbound

	msg := konstraint_core.format_with_id(sprintf("%s: has a size of '%fMi', which is greater than '%dMi' limit.", [input.image, size_mb, data.parameters.image_size_upperbound]), "RHCOP-PODMAN-00002")
}
