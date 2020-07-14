#!/usr/bin/env bats

load bats-support-clone
load test_helper/bats-support/load
load test_helper/redhatcop-bats-library/load

@test "_test/deny-k8s-rolebinding-roleref" {
  local tmp=$(split_files "_test/deny-k8s-rolebinding-roleref")

  local cmd="conftest test ${tmp} --output tap"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - RoleBinding/NoApiGroup: RoleBinding roleRef.apiGroup key is null, use rbac.authorization.k8s.io instead." ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - RoleBinding/NoKind: RoleBinding roleRef.kind key is null, use ClusterRole or Role instead." ]
  [ "${lines[3]}" = "# Successes" ]
}

@test "_test/deny-ocp42-all-deprecated-apiversions" {
  local tmp=$(split_files "_test/deny-ocp42-all-deprecated-apiversions")

  local cmd="conftest test ${tmp} --output tap"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Foo/Bar: servicecatalog.k8s.io/v1beta1 is deprecated." ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - Foo/Bar: automationbroker.io/v1alpha1 is deprecated." ]
  [ "${lines[3]}" = "not ok 3 - ${tmp}/list.yml - Foo/Bar: osb.openshift.io/v1 is deprecated." ]
  [ "${lines[4]}" = "not ok 4 - ${tmp}/list.yml - Foo/Bar: operatorsources.operators.coreos.com/v1 is deprecated." ]
  [ "${lines[5]}" = "not ok 5 - ${tmp}/list.yml - Foo/Bar: catalogsourceconfigs.operators.coreos.com/v1 is deprecated." ]
  [ "${lines[6]}" = "not ok 6 - ${tmp}/list.yml - Foo/Bar: catalogsourceconfigs.operators.coreos.com/v2 is deprecated." ]
  [ "${lines[7]}" = "# Successes" ]
}

@test "_test/deny-ocp43-all-deprecated-apiversions/template.yml" {
  local tmp=$(split_files "_test/deny-ocp43-all-deprecated-apiversions/template.yml")

  local cmd="conftest test ${tmp}/template.yml --output tap"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/template.yml - Template/Foo: API v1 for Template is no longer served by default, use template.openshift.io/v1 instead." ]
  [ "${lines[2]}" = "# Successes" ]
}

@test "_test/deny-ocp43-all-deprecated-apiversions/list.yml" {
  local tmp=$(split_files "_test/deny-ocp43-all-deprecated-apiversions/list.yml")

  local cmd="conftest test ${tmp}/list.yml --output tap"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - SecurityContextConstraints/Bar: API v1 for SecurityContextConstraints is no longer served by default, use security.openshift.io/v1 instead." ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - ProjectRequest/Bar: API v1 for ProjectRequest is no longer served by default, use project.openshift.io/v1 instead." ]
  [ "${lines[3]}" = "not ok 3 - ${tmp}/list.yml - ImageStream/Bar: API v1 for ImageStream is no longer served by default, use image.openshift.io/v1 instead." ]
  [ "${lines[4]}" = "not ok 4 - ${tmp}/list.yml - BuildConfig/Bar: API v1 for BuildConfig is no longer served by default, use build.openshift.io/v1 instead." ]
  [ "${lines[5]}" = "not ok 5 - ${tmp}/list.yml - DeploymentConfig/Bar: API v1 for DeploymentConfig is no longer served by default, use apps.openshift.io/v1 instead." ]
  [ "${lines[6]}" = "not ok 6 - ${tmp}/list.yml - RoleBinding/Bar: API v1 for RoleBinding is no longer served by default, use rbac.authorization.k8s.io/v1 instead." ]
  [ "${lines[7]}" = "not ok 7 - ${tmp}/list.yml - Route/Bar: API v1 for Route is no longer served by default, use route.openshift.io/v1 instead." ]
}

@test "_test/warn-k8s-deployment-conftestcombine-bestpractices" {
  local tmp=$(split_files "_test/warn-k8s-deployment-conftestcombine-bestpractices")

  local cmd="conftest test ${tmp} --output tap --combine"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "# Warnings" ]
  [ "${lines[2]}" = "not ok 1 - Combined - Deployment/HasMissingSvc does not have a v1:Service or its selector labels dont match. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#service-and-replicationcontroller" ]
  [ "${lines[3]}" = "not ok 2 - Combined - Deployment/HasSvcWithIncorrectLabels does not have a v1:Service or its selector labels dont match. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#service-and-replicationcontroller" ]
  [ "${lines[4]}" = "not ok 3 - Combined - Deployment/HasMissingPDB does not have a policy/v1beta1:PodDisruptionBudget or its selector labels dont match. See: https://kubernetes.io/docs/tasks/run-application/configure-pdb/#specifying-a-poddisruptionbudget" ]
  [ "${lines[5]}" = "not ok 4 - Combined - Deployment/PDBHasIncorrectLabels does not have a policy/v1beta1:PodDisruptionBudget or its selector labels dont match. See: https://kubernetes.io/docs/tasks/run-application/configure-pdb/#specifying-a-poddisruptionbudget" ]
  [ "${lines[6]}" = "not ok 5 - Combined - Deployment/HasMissingSvcAccount has spec.serviceAccountName 'missing' but could not find corrasponding v1:ServiceAccount." ]
  [ "${lines[7]}" = "not ok 6 - Combined - Deployment/HasMissingPVC has persistentVolumeClaim in its spec.template.spec.volumes but could not find corrasponding v1:PersistentVolumeClaim." ]
  [ "${lines[8]}" = "# Successes" ]
}

@test "_test/warn-k8s-namespace-conftestcombine-bestpractices" {
  local tmp=$(split_files "_test/warn-k8s-namespace-conftestcombine-bestpractices")

  local cmd="conftest test ${tmp} --output tap --combine"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "# Warnings" ]
  [ "${lines[2]}" = "not ok 1 - Combined - Namespace/Foo does not have a networking.k8s.io/v1:NetworkPolicy. See: https://docs.openshift.com/container-platform/4.4/networking/configuring-networkpolicy.html" ]
  [ "${lines[3]}" = "# Successes" ]
}

@test "_test/warn-k8s-service-conftestcombine-bestpractices" {
  local tmp=$(split_files "_test/warn-k8s-service-conftestcombine-bestpractices")

  local cmd="conftest test ${tmp} --output tap --combine"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "# Warnings" ]
  [ "${lines[2]}" = "not ok 1 - Combined - Service/HasMissingSvcMon does not have a monitoring.coreos.com/v1:ServiceMonitor or its selector labels dont match. See: https://docs.openshift.com/container-platform/4.4/monitoring/monitoring-your-own-services.html" ]
  [ "${lines[3]}" = "not ok 2 - Combined - Service/HasSvcMonWithIncorrectLabels does not have a monitoring.coreos.com/v1:ServiceMonitor or its selector labels dont match. See: https://docs.openshift.com/container-platform/4.4/monitoring/monitoring-your-own-services.html" ]
  [ "${lines[4]}" = "# Successes" ]
}

@test "_test/warn-k8s_ocp-all-bestpractices" {
  local tmp=$(split_files "_test/warn-k8s_ocp-all-bestpractices")

  local cmd="conftest test ${tmp} --output tap"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "# Warnings" ]
  [ "${lines[2]}" = "not ok 1 - ${tmp}/list.yml - Service/NoLabels: does not contain all the expected k8s labels in 'metadata.labels'. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels" ]
  [ "${lines[3]}" = "# Successes" ]
}

@test "_test/warn-k8s_ocp-deployment_deploymentconfig-bestpractices/list-Deployment.yml" {
  local tmp=$(split_files "_test/warn-k8s_ocp-deployment_deploymentconfig-bestpractices/list-Deployment.yml")

  local cmd="conftest test ${tmp}/list-Deployment.yml --output tap"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "# Warnings" ]
  [ "${lines[2]}" = "not ok 1 - ${tmp}/list-Deployment.yml - Deployment/ReplicaIsNull: replicas is null." ]
  [ "${lines[3]}" = "not ok 2 - ${tmp}/list-Deployment.yml - Deployment/ReplicaIsOne: replicas is 1 - expected replicas to be greater than 1 for HA guarantees." ]
  [ "${lines[4]}" = "not ok 3 - ${tmp}/list-Deployment.yml - Deployment/ReplicaIsEven: replicas is 2 - expected an odd number for HA guarantees." ]
  [ "${lines[5]}" = "not ok 4 - ${tmp}/list-Deployment.yml - Deployment/NoProbsSet: container 'Bar' has no readinessProbe. See: https://docs.openshift.com/container-platform/4.4/applications/application-health.html" ]
  [ "${lines[6]}" = "not ok 5 - ${tmp}/list-Deployment.yml - Deployment/NoProbsSet: container 'Bar' has no livenessProbe. See: https://docs.openshift.com/container-platform/4.4/applications/application-health.html" ]
  [ "${lines[7]}" = "not ok 6 - ${tmp}/list-Deployment.yml - Deployment/ProbsSetAreSame: container 'Bar' livenessProbe and readinessProbe are equal, which is an anti-pattern." ]
  [ "${lines[8]}" = "not ok 7 - ${tmp}/list-Deployment.yml - Deployment/ResourceLimitsAndRequestsNotSet: container 'Bar' has no limits/request for its resources. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers" ]
  [ "${lines[9]}" = "not ok 8 - ${tmp}/list-Deployment.yml - Deployment/ResourceLimitsAndRequestsNotSet: container 'Bar' has no memory limits. It is recommended to limit memory, as memory always has a maximum. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers" ]
  [ "${lines[10]}" = "not ok 9 - ${tmp}/list-Deployment.yml - Deployment/InvalidResourcesRequestsMemoryUnits: container 'Bar' memory resources for limits or requests (2Gi / 100MB) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes" ]
  [ "${lines[11]}" = "not ok 10 - ${tmp}/list-Deployment.yml - Deployment/InvalidResourcesLimitsMemoryUnits: container 'Bar' memory resources for limits or requests (2GB / 100Mi) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes" ]
  [ "${lines[12]}" = "not ok 11 - ${tmp}/list-Deployment.yml - Deployment/InvalidResourcesRequestCpuUnits container 'Bar' cpu resources for requests (100M) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes" ]
  [ "${lines[13]}" = "not ok 12 - ${tmp}/list-Deployment.yml - Deployment/InvertedMemoryResources: container 'Bar' memory resources for limits/requests (1Gi / 2Gi) are inverted. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes" ]
  [ "${lines[14]}" = "not ok 13 - ${tmp}/list-Deployment.yml - Deployment/ResourcesLimitsCpuSet: container 'Bar' has cpu limits (1). It is not recommended to limit cpu. See: https://www.reddit.com/r/kubernetes/comments/all1vg/on_kubernetes_cpu_limits" ]
  [ "${lines[15]}" = "not ok 14 - ${tmp}/list-Deployment.yml - Deployment/ImageUsesLatestTag: container 'Bar' is using the latest tag for its image (quay.io/redhat-cop/openshift-applier:latest), which is an anti-pattern." ]
  [ "${lines[16]}" = "not ok 15 - ${tmp}/list-Deployment.yml - Deployment/HostNetworkIsSet: hostNetwork is present which gives the pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other pods on the same node." ]
  [ "${lines[17]}" = "not ok 16 - ${tmp}/list-Deployment.yml - Deployment/MissingVolumeMount: volume 'my-missing-pvc' does not have a volumeMount in any of the containers." ]
  [ "${lines[18]}" = "not ok 17 - ${tmp}/list-Deployment.yml - Deployment/MissingVolumes: container 'BarBar' has a volumeMount 'my-pvc' which does not have a mapped volume." ]
  [ "${lines[19]}" = "not ok 18 - ${tmp}/list-Deployment.yml - Deployment/NotVarRunVolumeMountsPath: container 'Bar' has a volumeMount 'my-secret' mountPath at '/some/random/path/my-secret'. A good practice is to use consistent mount paths, such as: /var/run/{organization}/{mount} - i.e.: /var/run/io.redhat-cop/my-secret" ]
  [ "${lines[20]}" = "not ok 19 - ${tmp}/list-Deployment.yml - Deployment/SecretEnvVars: container 'Bar' has a secret 'my-secret' mounted as an environment variable. As secrets are not secret, its not good practice to mount as env vars." ]
  [ "${lines[21]}" = "not ok 20 - ${tmp}/list-Deployment.yml - Deployment/MissingK8sCommonLabel: does not contain all the expected k8s labels in 'spec.template.metadata.labels'. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels" ]
  [ "${lines[22]}" = "not ok 21 - ${tmp}/list-Deployment.yml - Deployment/NoDownwardMemoryEnv: container 'Bar' does not have an env named 'CONTAINER_MAX_MEMORY' which is used by the Red Hat base images to calculate memory. See: https://docs.openshift.com/container-platform/4.4/nodes/clusters/nodes-cluster-resource-configure.html and https://github.com/jboss-openshift/cct_module/blob/master/jboss/container/java/jvm/bash/artifacts/opt/jboss/container/java/jvm/java-default-options" ]
  [ "${lines[23]}" = "not ok 22 - ${tmp}/list-Deployment.yml - Deployment/NoneStandardLabel: has a label key which did not start with 'app.kubernetes.io/' or 'redhat-cop.github.com'. Found 'app'" ]
  [ "${lines[24]}" = "not ok 23 - ${tmp}/list-Deployment.yml - Deployment/CommandNotArray: container 'Bar' command 'ansible-playbook -i .applier/ cluster-seed.yml' is not an array. See: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container" ]
  [ "${lines[25]}" = "not ok 24 - ${tmp}/list-Deployment.yml - Deployment/ArgNotArray: container 'Bar' args '-i .applier/ cluster-seed.yml' is not an array. See: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container" ]
  [ "${lines[26]}" = "not ok 25 - ${tmp}/list-Deployment.yml - Deployment/XmxViaCommand: container 'Bar' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'" ]
  [ "${lines[27]}" = "not ok 26 - ${tmp}/list-Deployment.yml - Deployment/XmxViaArgs: container 'Bar' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'" ]
  [ "${lines[28]}" = "not ok 27 - ${tmp}/list-Deployment.yml - Deployment/XmxViaEnv: container 'Bar' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'" ]
  [ "${lines[29]}" = "not ok 28 - ${tmp}/list-Deployment.yml - Deployment/MemoryLimitTooLarge: container 'Bar' has a memory limit of '7Gi' which is larger than the upper '6Gi' limit." ]
  [ "${lines[30]}" = "not ok 29 - ${tmp}/list-Deployment.yml - Deployment/MemoryRequestTooLarge: container 'Bar' has a memory request of '3Gi' which is larger than the upper '2Gi' limit." ]
  [ "${lines[31]}" = "# Successes" ]
}

@test "_test/warn-k8s_ocp-deployment_deploymentconfig-bestpractices/list-DeploymentConfig.yml" {
  local tmp=$(split_files "_test/warn-k8s_ocp-deployment_deploymentconfig-bestpractices/list-DeploymentConfig.yml")

  local cmd="conftest test ${tmp}/list-DeploymentConfig.yml --output tap"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "# Warnings" ]
  [ "${lines[2]}" = "not ok 1 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/ReplicaIsNull: replicas is null." ]
  [ "${lines[3]}" = "not ok 2 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/ReplicaIsOne: replicas is 1 - expected replicas to be greater than 1 for HA guarantees." ]
  [ "${lines[4]}" = "not ok 3 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/ReplicaIsEven: replicas is 2 - expected an odd number for HA guarantees." ]
  [ "${lines[5]}" = "not ok 4 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/NoProbsSet: container 'Bar' has no readinessProbe. See: https://docs.openshift.com/container-platform/4.4/applications/application-health.html" ]
  [ "${lines[6]}" = "not ok 5 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/NoProbsSet: container 'Bar' has no livenessProbe. See: https://docs.openshift.com/container-platform/4.4/applications/application-health.html" ]
  [ "${lines[7]}" = "not ok 6 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/ProbsSetAreSame: container 'Bar' livenessProbe and readinessProbe are equal, which is an anti-pattern." ]
  [ "${lines[8]}" = "not ok 7 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/ResourceLimitsAndRequestsNotSet: container 'Bar' has no limits/request for its resources. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers" ]
  [ "${lines[9]}" = "not ok 8 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/ResourceLimitsAndRequestsNotSet: container 'Bar' has no memory limits. It is recommended to limit memory, as memory always has a maximum. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers" ]
  [ "${lines[10]}" = "not ok 9 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/InvalidResourcesRequestsMemoryUnits: container 'Bar' memory resources for limits or requests (2Gi / 100MB) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes" ]
  [ "${lines[11]}" = "not ok 10 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/InvalidResourcesLimitsMemoryUnits: container 'Bar' memory resources for limits or requests (2GB / 100Mi) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes" ]
  [ "${lines[12]}" = "not ok 11 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/InvalidResourcesRequestCpuUnits container 'Bar' cpu resources for requests (100M) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes" ]
  [ "${lines[13]}" = "not ok 12 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/InvertedMemoryResources: container 'Bar' memory resources for limits/requests (1Gi / 2Gi) are inverted. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes" ]
  [ "${lines[14]}" = "not ok 13 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/ResourcesLimitsCpuSet: container 'Bar' has cpu limits (1). It is not recommended to limit cpu. See: https://www.reddit.com/r/kubernetes/comments/all1vg/on_kubernetes_cpu_limits" ]
  [ "${lines[15]}" = "not ok 14 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/ImageUsesLatestTag: container 'Bar' is using the latest tag for its image (quay.io/redhat-cop/openshift-applier:latest), which is an anti-pattern." ]
  [ "${lines[16]}" = "not ok 15 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/HostNetworkIsSet: hostNetwork is present which gives the pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other pods on the same node." ]
  [ "${lines[17]}" = "not ok 16 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/MissingVolumeMount: volume 'my-missing-pvc' does not have a volumeMount in any of the containers." ]
  [ "${lines[18]}" = "not ok 17 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/MissingVolumes: container 'BarBar' has a volumeMount 'my-pvc' which does not have a mapped volume." ]
  [ "${lines[19]}" = "not ok 18 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/NotVarRunVolumeMountsPath: container 'Bar' has a volumeMount 'my-secret' mountPath at '/some/random/path/my-secret'. A good practice is to use consistent mount paths, such as: /var/run/{organization}/{mount} - i.e.: /var/run/io.redhat-cop/my-secret" ]
  [ "${lines[20]}" = "not ok 19 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/SecretEnvVars: container 'Bar' has a secret 'my-secret' mounted as an environment variable. As secrets are not secret, its not good practice to mount as env vars." ]
  [ "${lines[21]}" = "not ok 20 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/MissingK8sCommonLabel: does not contain all the expected k8s labels in 'spec.template.metadata.labels'. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels" ]
  [ "${lines[22]}" = "not ok 21 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/NoDownwardMemoryEnv: container 'Bar' does not have an env named 'CONTAINER_MAX_MEMORY' which is used by the Red Hat base images to calculate memory. See: https://docs.openshift.com/container-platform/4.4/nodes/clusters/nodes-cluster-resource-configure.html and https://github.com/jboss-openshift/cct_module/blob/master/jboss/container/java/jvm/bash/artifacts/opt/jboss/container/java/jvm/java-default-options" ]
  [ "${lines[23]}" = "not ok 22 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/NoneStandardLabel: has a label key which did not start with 'app.kubernetes.io/' or 'redhat-cop.github.com'. Found 'app'" ]
  [ "${lines[24]}" = "not ok 23 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/CommandNotArray: container 'Bar' command 'ansible-playbook -i .applier/ cluster-seed.yml' is not an array. See: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container" ]
  [ "${lines[25]}" = "not ok 24 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/ArgNotArray: container 'Bar' args '-i .applier/ cluster-seed.yml' is not an array. See: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container" ]
  [ "${lines[26]}" = "not ok 25 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/XmxViaCommand: container 'Bar' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'" ]
  [ "${lines[27]}" = "not ok 26 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/XmxViaArgs: container 'Bar' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'" ]
  [ "${lines[28]}" = "not ok 27 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/XmxViaEnv: container 'Bar' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'" ]
  [ "${lines[29]}" = "not ok 28 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/MemoryLimitTooLarge: container 'Bar' has a memory limit of '7Gi' which is larger than the upper '6Gi' limit." ]
  [ "${lines[30]}" = "not ok 29 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/MemoryRequestTooLarge: container 'Bar' has a memory request of '3Gi' which is larger than the upper '2Gi' limit." ]
  [ "${lines[31]}" = "# Successes" ]
}

@test "_test/warn-ocp-deploymentconfig-bestpractices" {
  local tmp=$(split_files "_test/warn-ocp-deploymentconfig-bestpractices")

  local cmd="conftest test ${tmp} --output tap"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "# Warnings" ]
  [ "${lines[2]}" = "not ok 1 - ${tmp}/list-DeploymentConfig.yml - DeploymentConfig/NoTriggers: has no triggers set. Could you use a k8s native Deployment? See: https://kubernetes.io/docs/concepts/workloads/controllers/deployment" ]
  [ "${lines[3]}" = "# Successes" ]
}

@test "_test/warn-podman-history-bestpractices" {
  local tmp=$(split_files "_test/warn-podman-history-bestpractices/jenkins-python-mising.json" "true")

  local cmd="conftest test ${tmp}/jenkins-python-mising.json --output tap"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "# Warnings" ]
  [ "${lines[2]}" = "not ok 1 - ${tmp}/jenkins-python-mising.json - quay.io/redhat-cop/jenkins-agent-python:has-missing-sha: did not find expected SHA" ]
  [ "${lines[3]}" = "# Successes" ]
}

@test "_test/warn-podman-images-bestpractices" {
  local tmp=$(split_files "_test/warn-podman-images-bestpractices" "true")

  local cmd="conftest test ${tmp} --output tap"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "# Warnings" ]
  [ "${lines[2]}" = "not ok 1 - ${tmp}/jenkins-base.json - quay.io/openshift/origin-jenkins-agent-base:4.4: has a size of '692.095652Mi', which is greater than '512Mi' limit." ]
  [ "${lines[3]}" = "# Successes" ]
}