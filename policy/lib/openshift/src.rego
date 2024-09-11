package lib.openshift

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.konstraint.pods as konstraint_pods
import data.lib.kubernetes

pod := konstraint_pods.pod {
	# regal ignore:redundant-existence-check
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

is_policy_active(policy_id) {
	# regal ignore:external-reference
	konstraint_core.is_gatekeeper

	not label_contains(_namespace_disabled_policies_label, policy_id)
}

label_contains(disabled_policies, policy_id) {
	policy_id in disabled_policies
}

_namespace_disabled_policies_label := disabled_policies {
	namepace := data.inventory.cluster.v1.Namespace[konstraint_core.resource.metadata.namespace]
	label := namepace.metadata.labels["redhat-cop.github.com/gatekeeper-disabled-policies"]
	disabled_policies := split(label, ",")
}

_namespace_disabled_policies_label := [""] {
	namepace := data.inventory.cluster.v1.Namespace[konstraint_core.resource.metadata.namespace]
	not namepace.metadata.labels["redhat-cop.github.com/gatekeeper-disabled-policies"]
}
