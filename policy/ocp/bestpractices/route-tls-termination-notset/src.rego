package ocp.bestpractices.route_tls_termination_notset

import data.lib.konstraint.core as konstraint_core
import data.lib.openshift

# @title Route has TLS Termination Defined
#
# Routes should specify a TLS termination type to allow only secure ingress.
#
# @kinds route.openshift.io/Route
violation[msg] {
  openshift.is_route

  obj := konstraint.object
  not obj.spec.tls.termination

  msg := konstraint_core.format(sprintf("%s/%s: TLS termination type not set. See https://docs.openshift.com/container-platform/4.6/networking/routes/secured-routes.html", [konstraint_core.kind, konstraint_core.name]))
}