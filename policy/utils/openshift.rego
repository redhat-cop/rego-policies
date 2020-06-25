package utils.openshift

isTemplate {
  input.apiVersion == "template.openshift.io/v1"
  input.kind == "Template"
}

isNotTemplate {
  not isTemplate
}
