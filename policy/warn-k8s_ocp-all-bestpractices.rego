package main

import data.utils.labels

warn[msg] {
  labels.isCommonK8sLabelNotSet with input as input.metadata

  msg := sprintf("%s/%s: does not contain all the expected k8s labels in 'metadata.labels'. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels", [input.kind, input.metadata.name])
}