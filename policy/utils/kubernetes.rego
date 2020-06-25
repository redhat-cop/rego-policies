package utils.kubernetes

isList {
  input.apiVersion == "v1"
  input.kind == "List"
}

isNotList {
  not isList
}

isDeployment {
  input.apiVersion == "apps/v1"
  input.kind == "Deployment"
}
