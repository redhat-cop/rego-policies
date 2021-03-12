# @title RHCOP-OCP_BESTPRACT-00004: Container image is not from a known registry
#
# Only images from trusted and known registries should be used
#
# @kinds apps.openshift.io/DeploymentConfig apps/DaemonSet apps/Deployment apps/Job apps/ReplicaSet core/ReplicationController apps/StatefulSet core/Pod batch/CronJob
package ocp.bestpractices.container_image_unknownregistries

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  container := openshift.containers[_]

  registry := get_registry(container.image)
  not known_registry(container.image, registry)

  msg := konstraint_core.format_with_id(sprintf("%s/%s: container '%s' is from (%s), which is an unknown registry.", [konstraint_core.kind, konstraint_core.name, container.name, container.image]), "RHCOP-OCP_BESTPRACT-00004")
}

get_registry(image) = registry {
  contains(image, "/")
  possible_registry := lower(split(image, "/")[0])
  contains(possible_registry, ".")

  registry := possible_registry
}

known_registry(image, registry) {
  known_registries := ["image-registry.openshift-image-registry.svc", "registry.redhat.io", "registry.connect.redhat.com", "quay.io"]
  registry == known_registries[_]
}