package ocp.bestpractices.route_tls_termination_notset

import data.lib.konstraint
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

  msg := konstraint.format(sprintf("%s/%s: TLS termination type not set. See https://docs.openshift.com/container-platform/4.5/networking/routes/secured-routes.html", [obj.kind, obj.metadata.name]))
}