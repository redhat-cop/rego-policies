package utils.labels

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