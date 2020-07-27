package podman.history.contains_layer

# violation: Check the image contains a specific SHA in its history
# @kinds redhat-cop.github.com/PodmanHistory
violation[msg] {
  lower(input.apiVersion) == "redhat-cop.github.com/v1"
  lower(input.kind) == "podmanhistory"

  not image_history_contains_layer(input.items)

  msg := sprintf("%s: did not find expected SHA.", [input.image])
}

image_history_contains_layer(layers) {
  layers[_].id == "cd343f0d83042932fa992e095cd4a93a89a3520873f99b0e15fde69eb46e7e10"
}