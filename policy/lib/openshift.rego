package lib.openshift

import data.lib.konstraint.core as konstraint_core
import data.lib.konstraint.pods as konstraint_pods
import data.lib.kubernetes

pod = konstraint_pods.pod {
    konstraint_pods.pod
}

pod = konstraint_core.resource.spec.template {
    is_deploymentconfig
}

containers[container] {
    keys = {"containers", "initContainers"}
    all_containers = [c | keys[k]; c = pod.spec[k][_]]
    container = all_containers[_]
}

is_deploymentconfig {
    lower(konstraint_core.apiVersion) == "apps.openshift.io/v1"
    lower(konstraint_core.kind) == "deploymentconfig"
}

is_route {
    lower(konstraint_core.apiVersion) == "route.openshift.io/v1"
    lower(konstraint_core.kind) == "route"
}

is_pod_or_networking {
    pod
}

is_pod_or_networking {
    kubernetes.is_service
}

is_pod_or_networking {
    is_route
}