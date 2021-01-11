package ocp.requiresinventory.deployment_has_matching_service

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes

# @title RHCOP-OCP_REQ_INV-00003: Deployment has a matching Service
#
# All Deployments should have matching Service, via 'spec.template.metadata.labels'.
# Deployments without a Service are not accessible and should be questioned as to why.
#
# @kinds apps/Deployment
violation[msg] {
  kubernetes.is_deployment

  deployment := konstraint_core.resource

  not deployment_labels_matches_service_selector(deployment, data.inventory.namespace[deployment.metadata.namespace])

  msg := konstraint_core.format_with_id(sprintf("%s/%s does not have a v1:Service or its selector labels dont match. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#service-and-replicationcontroller", [deployment.kind, deployment.metadata.name]), "RHCOP-OCP_REQ_INV-00003")
}

deployment_labels_matches_service_selector(deployment, manifests) {
  cached := manifests["v1"]["Service"]
  current := cached[_]

  deployment.spec.template.metadata.labels == current.spec.selector
}