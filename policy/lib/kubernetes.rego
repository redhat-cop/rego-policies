package lib.kubernetes

import data.lib.konstraint

is_rolebinding {
  lower(konstraint.object.apiVersion) == "rbac.authorization.k8s.io/v1"
  lower(konstraint.object.kind) == "rolebinding"
}