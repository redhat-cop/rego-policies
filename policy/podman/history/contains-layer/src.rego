package podman.history.contains_layer

# @title Image contains expected SHA in history.
#
# Most images are built from a subset of authorised base images in a company,
# this policy allows enforcement of that policy by checking for an expected SHA.
#
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