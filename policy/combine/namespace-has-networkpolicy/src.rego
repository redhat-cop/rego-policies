package combine.namespace_has_networkpolicy

import data.lib.konstraint.core as konstraint_core

# @title Namespace has a NetworkPolicy
#
# Kubernetes network policies specify the access permissions for groups of pods,
# much like security groups in the cloud are used to control access to VM instances.
# In other words, it creates firewalls between pods running on a Kubernetes cluster.
# See: Network policies -> https://learnk8s.io/production-best-practices#governance
#
# @kinds core/Namespace networking.k8s.io/NetworkPolicy
violation[msg] {
  manifests := input[_]
  some i

  lower(manifests[i].apiVersion) == "v1"
  lower(manifests[i].kind) == "namespace"
  namespace := manifests[i]

  not namespace_has_networkpolicy(manifests)

  msg := konstraint_core.format(sprintf("%s/%s does not have a networking.k8s.io/v1:NetworkPolicy. See: https://docs.openshift.com/container-platform/4.6/networking/network_policy/about-network-policy.html", [namespace.kind, namespace.metadata.name]))
}

namespace_has_networkpolicy(manifests) {
  current := manifests[_]

  lower(current.apiVersion) == "networking.k8s.io/v1"
  lower(current.kind) == "networkpolicy"
}