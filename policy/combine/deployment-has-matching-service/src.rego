package combine.deployment_has_matching_service

import data.lib.konstraint

# violation: Check if a Deployment has a matching v1:Service, via 'spec.template.metadata.labels'
# @Kinds apps/Deployment core/Service
violation[msg] {
  manifests := input[_]

  # NOTE: Interested in how 'i' works? See: https://www.openpolicyagent.org/docs/latest/policy-language/#variable-keys
  some i

  lower(manifests[i].apiVersion) == "apps/v1"
  lower(manifests[i].kind) == "deployment"
  deployment := manifests[i]

  not deployment_labels_matches_service_selector(deployment, manifests)

  msg := sprintf("%s/%s does not have a v1:Service or its selector labels dont match. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#service-and-replicationcontroller", [deployment.kind, deployment.metadata.name])
}

deployment_labels_matches_service_selector(deployment, manifests) {
  current := manifests[_]

  lower(current.apiVersion) == "v1"
  lower(current.kind) == "service"

  deployment.spec.template.metadata.labels == current.spec.selector
}