# @title RHCOP-OCP_BESTPRACT-00025: Route has TLS Termination Defined
#
# Routes should specify a TLS termination type to allow only secure ingress.
#
# @kinds route.openshift.io/Route
package ocp.bestpractices.route_tls_termination_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

violation[msg] {
  openshift.is_policy_active("RHCOP-OCP_BESTPRACT-00025")
  openshift.is_route

  not konstraint_core.resource.spec.tls.termination

  msg := konstraint_core.format_with_id(sprintf("%s/%s: TLS termination type not set. See https://docs.openshift.com/container-platform/4.6/networking/routes/secured-routes.html", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_BESTPRACT-00025")
}