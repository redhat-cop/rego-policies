# @title RHCOP-COMBINE-00002: Namespace has a ResourceQuota
#
# With ResourceQuotas, you can limit the total resource consumption of all containers inside a Namespace.
# Defining a resource quota for a namespace limits the total amount of CPU, memory or storage resources
# that can be consumed by all containers belonging to that namespace. You can also set quotas for other
# Kubernetes objects such as the number of Pods in the current namespace.
# See: Namespace limits -> https://learnk8s.io/production-best-practices#governance
#
# @skip-constraint
# @kinds core/Namespace core/ResourceQuota
package combine.namespace_has_resourcequota

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  manifests := input[_]
  some i

  lower(manifests[i].apiVersion) == "v1"
  lower(manifests[i].kind) == "namespace"
  namespace := manifests[i]

  not namespace_has_resourcequota(manifests)

  msg := konstraint_core.format_with_id(sprintf("%s/%s does not have a core/v1:ResourceQuota. See: https://docs.openshift.com/container-platform/4.6/applications/quotas/quotas-setting-per-project.html", [namespace.kind, namespace.metadata.name]), "RHCOP-COMBINE-00002")
}

namespace_has_resourcequota(manifests) {
  current := manifests[_]

  lower(current.apiVersion) == "v1"
  lower(current.kind) == "resourcequota"
}