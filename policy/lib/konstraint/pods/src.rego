package lib.konstraint.pods

import future.keywords.in

import data.lib.konstraint.core

default pod := false

pod := core.resource.spec.template {
	lower(core.kind) in {"daemonset", "deployment", "job", "replicaset", "replicationcontroller", "statefulset"}
}

pod := core.resource {
	lower(core.kind) == "pod"
}

pod := core.resource.spec.jobTemplate.spec.template {
	lower(core.kind) == "cronjob"
}

containers[container] {
	keys := {"containers", "initContainers"}

	# regal ignore:prefer-some-in-iteration
	all_containers := [c | some k; keys[k]; c = pod.spec[k][_]]

	# regal ignore:prefer-some-in-iteration
	container := all_containers[_]
}

volumes[pod.spec.volumes[_]]
