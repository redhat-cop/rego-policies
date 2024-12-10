# METADATA
# title: 'RHCOP-PODMAN-00001: Image contains expected SHA in history'
# description: |-
#   Most images are built from a subset of authorised base images in a company,
#   this policy allows enforcement of that policy by checking for an expected SHA.
#
#   parameter expected_layer_ids array string
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - redhat-cop.github.com
#       kinds:
#       - PodmanHistory
#   skipConstraint: true
package podman.history.contains_layer

import future.keywords.in

import data.lib.konstraint.core as konstraint_core

violation[msg] {
	lower(input.apiVersion) == "redhat-cop.github.com/v1"
	lower(input.kind) == "podmanhistory"

	not _image_history_contains_layer(input.items, data.parameters.expected_layer_ids)

	msg := konstraint_core.format_with_id(sprintf("%s: did not find expected SHA.", [input.image]), "RHCOP-PODMAN-00001")
}

_image_history_contains_layer(layers, expected_layer_ids) {
	some layer in layers
	some expected_layer_id in expected_layer_ids
	layer.id == expected_layer_id
}
