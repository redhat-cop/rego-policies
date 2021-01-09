package ocp.deprecated.ocp4_2.servicecatalog_v1beta1

import data.lib.konstraint.core as konstraint_core

# @title servicecatalog k8s io v1beta1 is deprecated
#
# 'servicecatalog.k8s.io/v1beta1' is deprecated in OCP 4.2 and removed in 4.5.
# See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
# See: https://docs.openshift.com/container-platform/4.5/release_notes/ocp-4-5-release-notes.html#ocp-4-5-deprecated-removed-features
#
# @kinds servicecatalog.k8s.io/ClusterServiceBroker servicecatalog.k8s.io/ClusterServiceClass servicecatalog.k8s.io/ClusterServicePlan servicecatalog.k8s.io/ServiceInstance servicecatalog.k8s.io/ServiceBinding
violation[msg] {
  contains(lower(konstraint_core.apiVersion), "servicecatalog.k8s.io/v1beta1")

  msg := konstraint_core.format(sprintf("%s/%s: servicecatalog.k8s.io/v1beta1 is deprecated.", [konstraint_core.kind, konstraint_core.name]))
}