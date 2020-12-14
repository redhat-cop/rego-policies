package ocp.requiresinventory.service_has_matching_servicenonitor

import data.lib.konstraint.core as konstraint_core
import data.lib.kubernetes

# @title Service has matching ServiceMonitor
#
# All Service should have a matching ServiceMonitor, via 'spec.selector'.
# Service without a ServiceMonitor are not being monitored and should be questioned as to why.
#
# @kinds core/Service
violation[msg] {
  kubernetes.is_service

  service := konstraint_core.resource

  not service_has_matching_servicemonitor(service, data.inventory.namespace[service.metadata.namespace])

  msg := konstraint_core.format(sprintf("%s/%s does not have a monitoring.coreos.com/v1:ServiceMonitor or its selector labels dont match. See: https://docs.openshift.com/container-platform/4.6/monitoring/enabling-monitoring-for-user-defined-projects.html", [service.kind, service.metadata.name]))
}

service_has_matching_servicemonitor(service, manifests) {
  cached := manifests["monitoring.coreos.com/v1"]["ServiceMonitor"]
  current := cached[_]

  service.spec.selector == current.spec.selector.matchLabels
}