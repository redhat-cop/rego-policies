package main

warn[msg] {
  manifests := input[_]
  some i

  manifests[i].apiVersion == "v1"
  manifests[i].kind == "Service"
  service := manifests[i]

  not serviceHasMatchingServiceMonitor(service, manifests)

  msg := sprintf("%s/%s does not have a monitoring.coreos.com/v1:ServiceMonitor or its selector labels dont match. See: https://docs.openshift.com/container-platform/4.4/monitoring/monitoring-your-own-services.html", [service.kind, service.metadata.name])
}

serviceHasMatchingServiceMonitor(service, manifests) {
  current := manifests[_]

  current.apiVersion == "monitoring.coreos.com/v1"
  current.kind == "ServiceMonitor"

  service.spec.selector == current.spec.selector.matchLabels
}