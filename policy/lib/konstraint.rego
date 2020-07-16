package lib.konstraint

default is_gatekeeper = false

is_gatekeeper {
  has_field(input, "review")
  has_field(input.review, "object")
}

object = input {
  not is_gatekeeper
}

object = input.review.object {
  is_gatekeeper
}

format(msg) = gatekeeper_format {
  is_gatekeeper
  gatekeeper_format = {"msg": msg}
}

format(msg) = msg {
  not is_gatekeeper
}

name = object.metadata.name

kind = object.kind

has_field(obj, field) {
  obj[field]
}

missing_field(obj, field) = true {
  obj[field] == ""
}

missing_field(obj, field) = true {
  not has_field(obj, field)
}

is_service {
  lower(kind) == "service"
}

is_statefulset {
  lower(kind) == "statefulset"
}

is_daemonset {
  lower(kind) == "daemonset"
}

is_deployment {
  lower(kind) == "deployment"
}

is_pod {
  lower(kind) == "pod"
}

is_namespace {
  lower(kind) == "namespace"
}

is_workload {
  containers[_]
}

pod_containers(pod) = all_containers {
  keys = {"containers", "initContainers"}
  all_containers = [c | keys[k]; c = pod.spec[k][_]]
}

containers[container] {
  pods[pod]
  all_containers = pod_containers(pod)
  container = all_containers[_]
}

containers[container] {
  all_containers = pod_containers(object)
  container = all_containers[_]
}

container_images[image] {
  containers[container]
  image = container.image
}

container_images[image] {
  image = object.spec.image
}

split_image(image) = [image, "latest"] {
  not contains(image, ":")
}

split_image(image) = [image_name, tag] {
  [image_name, tag] = split(image, ":")
}

pods[pod] {
  is_statefulset
  pod = object.spec.template
}

pods[pod] {
  is_daemonset
  pod = object.spec.template
}

pods[pod] {
  is_deployment
  pod = object.spec.template
}

pods[pod] {
  is_pod
  pod = object
}

volumes[volume] {
  pods[pod]
  volume = pod.spec.volumes[_]
}

# 10 ** 21
mem_multiple("E") = 1000000000000000000000 { true }

# 10 ** 18
mem_multiple("P") = 1000000000000000000 { true }

# 10 ** 15
mem_multiple("T") = 1000000000000000 { true }

# 10 ** 12
mem_multiple("G") = 1000000000000 { true }

# 10 ** 9
mem_multiple("M") = 1000000000 { true }

# 10 ** 6
mem_multiple("k") = 1000000 { true }

# 10 ** 3
mem_multiple("") = 1000 { true }

# Kubernetes accepts millibyte precision when it probably shouldn't.
# https://github.com/kubernetes/kubernetes/issues/28741
# 10 ** 0
mem_multiple("m") = 1 { true }

# 1000 * 2 ** 10
mem_multiple("Ki") = 1024000 { true }

# 1000 * 2 ** 20
mem_multiple("Mi") = 1048576000 { true }

# 1000 * 2 ** 30
mem_multiple("Gi") = 1073741824000 { true }

# 1000 * 2 ** 40
mem_multiple("Ti") = 1099511627776000 { true }

# 1000 * 2 ** 50
mem_multiple("Pi") = 1125899906842624000 { true }

# 1000 * 2 ** 60
mem_multiple("Ei") = 1152921504606846976000 { true }

get_suffix(mem) = suffix {
  not is_string(mem)
  suffix := ""
}

get_suffix(mem) = suffix {
  is_string(mem)
  count(mem) > 0
  suffix := substring(mem, count(mem) - 1, -1)
  mem_multiple(suffix)
}

get_suffix(mem) = suffix {
  is_string(mem)
  count(mem) > 1
  suffix := substring(mem, count(mem) - 2, -1)
  mem_multiple(suffix)
}

get_suffix(mem) = suffix {
  is_string(mem)
  count(mem) > 1
  not mem_multiple(substring(mem, count(mem) - 1, -1))
  not mem_multiple(substring(mem, count(mem) - 2, -1))
  suffix := ""
}

get_suffix(mem) = suffix {
  is_string(mem)
  count(mem) == 1
  not mem_multiple(substring(mem, count(mem) - 1, -1))
  suffix := ""
}

get_suffix(mem) = suffix {
  is_string(mem)
  count(mem) == 0
  suffix := ""
}

canonify_mem(orig) = new {
  is_number(orig)
  new := orig * 1000
}

canonify_mem(orig) = new {
  not is_number(orig)
  suffix := get_suffix(orig)
  raw := replace(orig, suffix, "")
  re_match("^[0-9]+$", raw)
  new := to_number(raw) * mem_multiple(suffix)
}

canonify_storage(orig) = new {
  is_number(orig)
  new := orig
}

canonify_storage(orig) = new {
  not is_number(orig)
  suffix := get_suffix(orig)
  raw := replace(orig, suffix, "")
  re_match("^[0-9]+$", raw)
  new := to_number(raw) * mem_multiple(suffix)
}

canonify_cpu(orig) = new {
  is_number(orig)
  new := orig * 1000
}

canonify_cpu(orig) = new {
  not is_number(orig)
  endswith(orig, "m")
  new := to_number(replace(orig, "m", ""))
}

canonify_cpu(orig) = new {
  not is_number(orig)
  not endswith(orig, "m")
  re_match("^[0-9]+$", orig)
  new := to_number(orig) * 1000
}

dropped_capability(container, cap) {
  container.securityContext.capabilities.drop[_] == cap
}

added_capability(container, cap) {
  container.securityContext.capabilities.add[_] == cap
}

no_read_only_filesystem(c) {
  not has_field(c, "securityContext")
}

no_read_only_filesystem(c) {
  has_field(c, "securityContext")
  not has_field(c.securityContext, "readOnlyRootFilesystem")
}

priviledge_escalation_allowed(c) {
  not has_field(c, "securityContext")
}

priviledge_escalation_allowed(c) {
  has_field(c, "securityContext")
  has_field(c.securityContext, "allowPrivilegeEscalation")
}
