package ocp.deprecated.ocp4_2.servicecatalog_v1beta1

import data.lib.konstraint

# violation: Check for deprecated servicecatalog.k8s.io/v1beta1 apiVersion. See: https://docs.openshift.com/container-platform/4.2/release_notes/ocp-4-2-release-notes.html#ocp-4-2-deprecated-features
# @Kinds servicecatalog.k8s.io/ClusterServiceBroker servicecatalog.k8s.io/ClusterServiceClass servicecatalog.k8s.io/ClusterServicePlan servicecatalog.k8s.io/ServiceInstance servicecatalog.k8s.io/ServiceBinding
violation[msg] {
  obj := konstraint.object
  contains(lower(obj.apiVersion), "servicecatalog.k8s.io/v1beta1")

  msg := konstraint.format(sprintf("%s/%s: servicecatalog.k8s.io/v1beta1 is deprecated.", [obj.kind, obj.metadata.name]))
}