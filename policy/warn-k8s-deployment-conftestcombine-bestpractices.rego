package main

warn[msg] {
  manifests := input[_]

  # NOTE: Interested in how 'i' works? See: https://www.openpolicyagent.org/docs/latest/policy-language/#variable-keys
  some i

  manifests[i].apiVersion == "apps/v1"
  manifests[i].kind == "Deployment"
  deployment := manifests[i]

  not deploymentLabelsMatchesServiceSelector(deployment, manifests)

  msg := sprintf("%s/%s does not have a v1:Service or its selector labels dont match. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#service-and-replicationcontroller", [deployment.kind, deployment.metadata.name])
}

deploymentLabelsMatchesServiceSelector(deployment, manifests) {
  current := manifests[_]

  current.apiVersion == "v1"
  current.kind == "Service"

  deployment.spec.template.metadata.labels == current.spec.selector
}

warn[msg] {
  manifests := input[_]
  some i

  manifests[i].apiVersion == "apps/v1"
  manifests[i].kind == "Deployment"
  deployment := manifests[i]

  not deploymentHasMatchingPodDisruptionBudget(deployment, manifests)

  msg := sprintf("%s/%s does not have a policy/v1beta1:PodDisruptionBudget or its selector labels dont match. See: https://kubernetes.io/docs/tasks/run-application/configure-pdb/#specifying-a-poddisruptionbudget", [deployment.kind, deployment.metadata.name])
}

deploymentHasMatchingPodDisruptionBudget(deployment, manifests) {
  current := manifests[_]

  current.apiVersion == "policy/v1beta1"
  current.kind == "PodDisruptionBudget"

  deployment.spec.template.metadata.labels == current.spec.selector.matchLabels
}

warn[msg] {
  manifests := input[_]
  some i

  manifests[i].apiVersion == "apps/v1"
  manifests[i].kind == "Deployment"
  deployment := manifests[i]

  not deploymentHasMatchingServiceAccount(deployment, manifests)

  msg := sprintf("%s/%s has spec.serviceAccountName '%s' but could not find corrasponding v1:ServiceAccount.", [deployment.kind, deployment.metadata.name, deployment.spec.serviceAccountName])
}

deploymentHasMatchingServiceAccount(deployment, manifests) {
  current := manifests[_]

  current.apiVersion == "v1"
  current.kind == "ServiceAccount"

  deployment.spec.serviceAccountName == current.metadata.name
}

warn[msg] {
  manifests := input[_]
  some i

  manifests[i].apiVersion == "apps/v1"
  manifests[i].kind == "Deployment"
  deployment := manifests[i]
  deployment.spec.template.spec.volumes[_].persistentVolumeClaim

  not deploymentHasMatchingPersistentVolumeClaim(deployment, manifests)

  msg := sprintf("%s/%s has persistentVolumeClaim in its spec.template.spec.volumes but could not find corrasponding v1:PersistentVolumeClaim.", [deployment.kind, deployment.metadata.name])
}

deploymentHasMatchingPersistentVolumeClaim(deployment, manifests) {
  current := manifests[_]

  current.apiVersion == "v1"
  current.kind == "PersistentVolumeClaim"

  deployment.spec.template.spec.volumes[_].persistentVolumeClaim.claimName == current.metadata.name
}