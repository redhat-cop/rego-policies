package main

warn[msg] {
  manifests := input[_]
  some i

  manifests[i].apiVersion == "v1"
  manifests[i].kind == "Namespace"
  namespace := manifests[i]

  not namespaceHasNetworkPolicy(namespace, manifests)

  msg := sprintf("%s/%s does not have a networking.k8s.io/v1:NetworkPolicy. See: https://docs.openshift.com/container-platform/4.4/networking/configuring-networkpolicy.html", [namespace.kind, namespace.metadata.name])
}

namespaceHasNetworkPolicy(namespace, manifests) {
  current := manifests[_]

  current.apiVersion == "networking.k8s.io/v1"
  current.kind == "NetworkPolicy"
}