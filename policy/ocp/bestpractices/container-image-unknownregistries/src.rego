package ocp.bestpractices.container_image_unknownregistries

import data.lib.konstraint
import data.lib.openshift

# @title Container image is not from a known registry
#
# Only images from trusted and known registries should be used
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/StatefulSet
violation[msg] {
  openshift.is_workload_kind

  container := openshift.containers[_]
  registry_list := ["image-registry.openshift-image-registry.svc", "registry.redhat.io/", "quay.io/"]

  not known_registry(container.image, registry_list)

  obj := konstraint.object
  msg := konstraint.format(sprintf("%s/%s: container '%s' is from (%s), which is an unknown registry.", [obj.kind, obj.metadata.name, container.name, container.image]))
}

known_registry(image, knownregistry){
  registry := knownregistry[_]
  startswith(image, registry)
}