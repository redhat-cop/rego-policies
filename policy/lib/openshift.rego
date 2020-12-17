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

is_policy_active(policyId) {
    not konstraint_core.is_gatekeeper
}

is_policy_active(policyId) {
    konstraint_core.is_gatekeeper

    disabledpolicies := namespace_disabled_policies_label
    not label_contains(disabledpolicies, policyId)
}

label_contains(disabledpolicies, policyId) {
    policyId == disabledpolicies[_]
}

namespace_disabled_policies_label = disabledpolicies {
    namepace := data.inventory.cluster["v1"].Namespace[konstraint_core.resource.metadata.namespace]
    label := namepace.metadata.labels["redhat-cop.github.com/gatekeeper-disabled-policies"]
    disabledpolicies := split(label, ",")
}

namespace_disabled_policies_label = [""] {
    namepace := data.inventory.cluster["v1"].Namespace[konstraint_core.resource.metadata.namespace]
    not namepace.metadata.labels["redhat-cop.github.com/gatekeeper-disabled-policies"]
}