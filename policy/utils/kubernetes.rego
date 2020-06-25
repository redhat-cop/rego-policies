package utils.kubernetes

isList {
  input.apiVersion == "v1"
  input.kind == "List"
}

isNotList {
  not isList
}
