package combine.service_has_matching_servicemonitor

import data.lib.konstraint

# violation: Check if a Service has a matching monitoring.coreos.com/v1:ServiceMonitor, via 'spec.selector'
# @Kinds core/Service monitoring.coreos.com/ServiceMonitor
violation[msg] {
  manifests := input[_]
  some i

  lower(manifests[i].apiVersion) == "v1"
  lower(manifests[i].kind) == "service"
  service := manifests[i]

  not service_has_matching_servicemonitor(service, manifests)

  msg := sprintf("%s/%s does not have a monitoring.coreos.com/v1:ServiceMonitor or its selector labels dont match. See: https://docs.openshift.com/container-platform/4.4/monitoring/monitoring-your-own-services.html", [service.kind, service.metadata.name])
}

service_has_matching_servicemonitor(service, manifests) {
  current := manifests[_]

  lower(current.apiVersion) == "monitoring.coreos.com/v1"
  lower(current.kind) == "servicemonitor"

  service.spec.selector == current.spec.selector.matchLabels
}