package main

warn[msg] {
  input.kind == "PodmanHistory"
  not imageHistoryContainsLayer(input.items)

  msg := sprintf("%s: did not find expected SHA", [input.image])
}

imageHistoryContainsLayer(layers) {
  layers[_].id == "cd343f0d83042932fa992e095cd4a93a89a3520873f99b0e15fde69eb46e7e10"
}