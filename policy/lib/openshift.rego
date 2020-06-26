package lib.openshift

import data.lib.konstraint

is_deploymentconfig {
  lower(konstraint.object.apiVersion) == "apps.openshift.io/v1"
  lower(konstraint.object.kind) == "deploymentconfig"
}

is_route {
  lower(konstraint.object.apiVersion) == "route.openshift.io/v1"
  lower(konstraint.object.kind) == "route"
}

is_workload_kind {
  is_deploymentconfig
}

is_workload_kind {
  konstraint.is_statefulset
}

is_workload_kind {
  konstraint.is_daemonset
}

is_workload_kind {
  konstraint.is_deployment
}

is_all_kind {
  is_workload_kind
}

is_all_kind {
  konstraint.is_service
}

is_all_kind {
  is_route
}

pods[pod] {
  is_deploymentconfig
  pod = konstraint.object.spec.template
}

pods[pod] {
  pod = konstraint.pods[_]
}

containers[container] {
  pods[pod]
  all_containers = konstraint.pod_containers(pod)
  container = all_containers[_]
}

containers[container] {
  container = konstraint.containers[_]
}