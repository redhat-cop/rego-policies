# METADATA
# title: 'RHCOP-OCP_REQ_INV-00005: Service has matching ServiceMonitor'
# description: |-
#   All Service should have a matching ServiceMonitor, via 'spec.selector'.
#   Service without a ServiceMonitor are not being monitored and should be questioned as to why.
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - ""
#       kinds:
#       - Service
package ocp.requiresinventory.service_has_matching_servicenonitor

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_REQ_INV-00005")
  kubernetes.is_service

  service := konstraint_core.resource

  not service_has_matching_servicemonitor(service, data.inventory.namespace[service.metadata.namespace])

  msg := konstraint_core.format_with_id(sprintf("%s/%s does not have a monitoring.coreos.com/v1:ServiceMonitor or its selector labels dont match. See: https://docs.openshift.com/container-platform/4.6/monitoring/enabling-monitoring-for-user-defined-projects.html", [service.kind, service.metadata.name]), "RHCOP-OCP_REQ_INV-00005")
}

service_has_matching_servicemonitor(service, manifests) {
  cached := manifests["monitoring.coreos.com/v1"]["ServiceMonitor"]
  current := cached[_]

  service.spec.selector == current.spec.selector.matchLabels
}