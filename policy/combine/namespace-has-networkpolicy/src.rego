package combine.namespace_has_networkpolicy

import data.lib.konstraint

# violation: Check if a Namespace has a networking.k8s.io/v1:NetworkPolicy
# @Kinds core/Namespace networking.k8s.io/NetworkPolicy
violation[msg] {
  manifests := input[_]
  some i

  lower(manifests[i].apiVersion) == "v1"
  lower(manifests[i].kind) == "namespace"
  namespace := manifests[i]

  not namespace_has_networkpolicy(manifests)

  msg := sprintf("%s/%s does not have a networking.k8s.io/v1:NetworkPolicy. See: https://docs.openshift.com/container-platform/4.4/networking/configuring-networkpolicy.html", [namespace.kind, namespace.metadata.name])
}

namespace_has_networkpolicy(manifests) {
  current := manifests[_]

  lower(current.apiVersion) == "networking.k8s.io/v1"
  lower(current.kind) == "networkpolicy"
}