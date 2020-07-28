package ocp.requiresinventory.service_has_matching_servicenonitor

import data.lib.konstraint

# @title Service has matching ServiceMonitor
#
# All Service should have a matching ServiceMonitor, via 'spec.selector'.
# Service without a ServiceMonitor are not being monitored and should be questioned as to why.
#
# @kinds core/Service
violation[msg] {
  konstraint.is_service

  service := konstraint.object

  not service_has_matching_servicemonitor(service, data.inventory.namespace[service.metadata.namespace])

  msg := konstraint.format(sprintf("%s/%s does not have a monitoring.coreos.com/v1:ServiceMonitor or its selector labels dont match. See: https://docs.openshift.com/container-platform/4.4/monitoring/monitoring-your-own-services.html", [service.kind, service.metadata.name]))
}

service_has_matching_servicemonitor(service, manifests) {
  cached := manifests["monitoring.coreos.com/v1"]["ServiceMonitor"]
  current := cached[_]

  service.spec.selector == current.spec.selector.matchLabels
}