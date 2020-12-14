package lib.kubernetes

import data.lib.konstraint.core as konstraint_core

is_deployment {
    lower(konstraint_core.apiVersion) == "apps/v1"
    lower(konstraint_core.kind) == "deployment"
}

is_service {
    lower(konstraint_core.apiVersion) == "v1"
    lower(konstraint_core.kind) == "service"
}

is_rolebinding {
    lower(konstraint_core.apiVersion) == "rbac.authorization.k8s.io/v1"
    lower(konstraint_core.kind) == "rolebinding"
}