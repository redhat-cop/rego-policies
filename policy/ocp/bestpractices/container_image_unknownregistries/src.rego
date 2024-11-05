# METADATA
# title: 'RHCOP-OCP_BESTPRACT-00004: Container image is not from a known registry'
# description: Only images from trusted and known registries should be used
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - ""
#       kinds:
#       - Pod
#       - ReplicationController
#     - apiGroups:
#       - apps
#       kinds:
#       - DaemonSet
#       - Deployment
#       - Job
#       - ReplicaSet
#       - StatefulSet
#     - apiGroups:
#       - apps.openshift.io
#       kinds:
#       - DeploymentConfig
#     - apiGroups:
#       - batch
#       kinds:
#       - CronJob
package ocp.bestpractices.container_image_unknownregistries

import future.keywords.in

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
	openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00004")
	some container in openshift.containers

	registry := _resolve_registry(container.image)
	not _known_registry(registry)

	msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' is from (%s), which is an unknown registry.", [konstraint_core.kind, konstraint_core.name, container.name, container.image]), "RHCOP-OCP_BESTPRACT-00004")
}

_resolve_registry(image) := registry {
	contains(image, "/")
	registry := lower(split(image, "/")[0])

	# Check its an external URL and not internal OCP registry ref
	contains(registry, ".")
}

_known_registry(registry) {
	known_registries := ["image-registry.openshift-image-registry.svc", "registry.redhat.io", "registry.connect.redhat.com", "quay.io"]
	registry in known_registries
}
