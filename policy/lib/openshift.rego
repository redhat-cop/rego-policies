package lib.openshift

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.konstraint.pods as konstraint_pods
import data.lib.kubernetes

pod := konstraint_pods.pod {
	konstraint_pods.pod
}

pod := konstraint_core.resource.spec.template {
	is_deploymentconfig
}

containers[container] {
	keys := {"containers", "initContainers"}

	# regal ignore:prefer-some-in-iteration
	all_containers := [c | some k; keys[k]; c := pod.spec[k][_]]

	# regal ignore:prefer-some-in-iteration
	container := all_containers[_]
}

is_deploymentconfig {
	lower(konstraint_core.api_version) == "apps.openshift.io/v1"
	lower(konstraint_core.kind) == "deploymentconfig"
}

is_route {
	lower(konstraint_core.api_version) == "route.openshift.io/v1"
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

is_policy_active(_) {
	# regal ignore:external-reference
	not konstraint_core.is_gatekeeper
}

is_policy_active(policyId) {
	# regal ignore:external-reference
	konstraint_core.is_gatekeeper

	not label_contains(_namespace_disabled_policies_label, policyId)
}

label_contains(disabledpolicies, policyId) {
	policyId in disabledpolicies
}

_namespace_disabled_policies_label := disabledpolicies {
	namepace := data.inventory.cluster.v1.Namespace[konstraint_core.resource.metadata.namespace]
	label := namepace.metadata.labels["redhat-cop.github.com/gatekeeper-disabled-policies"]
	disabledpolicies := split(label, ",")
}

_namespace_disabled_policies_label := [""] {
	namepace := data.inventory.cluster.v1.Namespace[konstraint_core.resource.metadata.namespace]
	not namepace.metadata.labels["redhat-cop.github.com/gatekeeper-disabled-policies"]
}
