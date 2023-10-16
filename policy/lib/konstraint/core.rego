package lib.konstraint.core

default is_gatekeeper := false

is_gatekeeper {
    has_field(input, "review")
    has_field(input.review, "object")
}

resource := input.review.object {
    is_gatekeeper
}

# This is a bug in Regal causing a false positive
# to be reported. It's been fixed, and this can
# safely be removed following the next (above
# v0.10.1) release.
# https://github.com/StyraInc/regal/issues/401
#
# regal ignore:top-level-iteration
resource := input {
    not is_gatekeeper
}

format(msg) := {"msg": msg}

format_with_id(msg, id) := {
    "msg": sprintf("%s: %s", [id, msg]),
    "details": {"policyID": id}
}

apiVersion := resource.apiVersion
name := resource.metadata.name
kind := resource.kind
labels := resource.metadata.labels
annotations := resource.metadata.annotations
gv := split(apiVersion, "/")
group := gv[0] {
    contains(apiVersion, "/")
}
group := "core" {
    not contains(apiVersion, "/")
}
version := gv[count(gv) - 1]

#parameters = input.parameters {
#    is_gatekeeper
#}

#parameters = data.parameters {
#   not is_gatekeeper
#}

has_field(obj, field) {
    not object.get(obj, field, "N_DEFINED") == "N_DEFINED"
}

missing_field(obj, field) := true {
    obj[field] == ""
}

missing_field(obj, field) := true {
    not has_field(obj, field)
}
