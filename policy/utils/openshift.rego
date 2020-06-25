package utils.openshift

import data.utils.kubernetes

isTemplate {
  input.apiVersion == "template.openshift.io/v1"
  input.kind == "Template"
}

isNotTemplate {
  not isTemplate
}

isDeploymentConfig {
  input.apiVersion == "apps.openshift.io/v1"
  input.kind == "DeploymentConfig"
}

isDeploymentOrDeploymentConfig {
  isDeploymentConfig
}

isDeploymentOrDeploymentConfig {
  kubernetes.isDeployment
}