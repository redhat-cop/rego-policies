package main

warn[msg] {
  isCommonK8sLabelNotSet with input as input.metadata

  msg := sprintf("%s/%s: does not contain all the expected k8s labels in 'metadata.labels'. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels", [input.kind, input.metadata.name])
}

isCommonK8sLabelNotSet {
  not input.labels["app.kubernetes.io/name"]
}

isCommonK8sLabelNotSet {
  not input.labels["app.kubernetes.io/instance"]
}

isCommonK8sLabelNotSet {
  not input.labels["app.kubernetes.io/component"]
}

isCommonK8sLabelNotSet {
  not input.labels["app.kubernetes.io/part-of"]
}

isCommonK8sLabelNotSet {
  not input.labels["app.kubernetes.io/managed-by"]
}