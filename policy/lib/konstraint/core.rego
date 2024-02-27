package lib.konstraint.core

default is_gatekeeper := false

is_gatekeeper {
	has_field(input, "review")
	has_field(input.review, "object")
}

resource := input.review.object {
	is_gatekeeper
}

resource := input {
	not is_gatekeeper
}

format(msg) := {"msg": msg}

format_with_id(msg, id) := {
	"msg": sprintf("%s: %s", [id, msg]),
	"details": {"policyID": id},
}

api_version := resource.apiVersion

name := resource.metadata.name

kind := resource.kind

labels := resource.metadata.labels

annotations := resource.metadata.annotations

gv := split(api_version, "/")

group := gv[0] {
	contains(api_version, "/")
}

group := "core" {
	not contains(api_version, "/")
}

version := gv[count(gv) - 1]

has_field(obj, field) {
	not object.get(obj, field, "N_DEFINED") == "N_DEFINED"
}

missing_field(obj, field) {
	obj[field] == ""
}

missing_field(obj, field) {
	not has_field(obj, field)
}
