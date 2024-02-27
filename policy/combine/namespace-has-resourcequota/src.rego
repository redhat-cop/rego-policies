# METADATA
# title: 'RHCOP-COMBINE-00002: Namespace has a ResourceQuota'
# description: |-
#   With ResourceQuotas, you can limit the total resource consumption of all containers inside a Namespace.
#   Defining a resource quota for a namespace limits the total amount of CPU, memory or storage resources
#   that can be consumed by all containers belonging to that namespace. You can also set quotas for other
#   Kubernetes objects such as the number of Pods in the current namespace.
#   See: Namespace limits -> https://learnk8s.io/production-best-practices#governance
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - ""
#       kinds:
#       - Namespace
#       - ResourceQuota
#   skipConstraint: true
package combine.namespace_has_resourcequota

import future.keywords.in

import data.lib.konstraint.core as konstraint_core

violation[msg] {
	some manifests in input
	some namespace in manifests

	lower(namespace.apiVersion) == "v1"
	lower(namespace.kind) == "namespace"

	not has_resourcequota(manifests)

	msg := konstraint_core.format_with_id(sprintf("%s/%s does not have a core/v1:ResourceQuota. See: https://docs.openshift.com/container-platform/4.6/applications/quotas/quotas-setting-per-project.html", [namespace.kind, namespace.metadata.name]), "RHCOP-COMBINE-00002")
}

has_resourcequota(manifests) {
	some current in manifests

	lower(current.apiVersion) == "v1"
	lower(current.kind) == "resourcequota"
}
