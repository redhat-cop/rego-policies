# @title RHCOP-PODMAN-00001: Image contains expected SHA in history.
#
# Most images are built from a subset of authorised base images in a company,
# this policy allows enforcement of that policy by checking for an expected SHA.
#
# @kinds redhat-cop.github.com/PodmanHistory
# parameter expected_layer_ids array string
package podman.history.contains_layer

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(input.apiVersion) == "redhat-cop.github.com/v1"
  lower(input.kind) == "podmanhistory"

  not image_history_contains_layer(input.items, data.parameters.expected_layer_ids)

  msg := konstraint_core.format_with_id(sprintf("%s: did not find expected SHA.", [input.image]), "RHCOP-PODMAN-00001")
}

image_history_contains_layer(layers, expected_layer_ids) {
  layers[_].id == expected_layer_ids[_]
}