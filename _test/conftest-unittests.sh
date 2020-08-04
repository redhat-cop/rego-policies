#!/usr/bin/env bats

load bats-support-clone
load test_helper/bats-support/load
load test_helper/redhatcop-bats-library/load

setup_file() {
  rm -rf /tmp/rhcop
}

####################
# all-namespaces
####################

@test "_test/all-namespaces/ocp/bestpractices" {
  tmp=$(split_files "_test/all-namespaces/ocp/bestpractices")

  cmd="conftest test ${tmp} --output tap --all-namespaces"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "# Successes" ]
}

####################
# combine
####################

@test "policy/combine/namespace-has-networkpolicy" {
  tmp=$(split_files "policy/combine/namespace-has-networkpolicy/test_data/unit")

  cmd="conftest test ${tmp} --output tap --combine --namespace combine.namespace_has_networkpolicy"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - Combined - Namespace/foo does not have a networking.k8s.io/v1:NetworkPolicy. See: https://docs.openshift.com/container-platform/4.4/networking/configuring-networkpolicy.html" ]
  [ "${lines[2]}" = "" ]
}

####################
# ocp/bestpractices
####################

@test "policy/ocp/bestpractices/common-k8s-labels-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/common-k8s-labels-notset/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.common_k8s_labels_notset"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/nolabels: does not contain all the expected k8s labels in 'metadata.labels'. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels" ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/nolabels: does not contain all the expected k8s labels in 'metadata.labels'. See: https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels" ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-env-maxmemory-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-env-maxmemory-notset/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_env_maxmemory_notset"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/nodownwardmemoryenv: container 'bar' does not have an env named 'CONTAINER_MAX_MEMORY' which is used by the Red Hat base images to calculate memory. See: https://docs.openshift.com/container-platform/4.4/nodes/clusters/nodes-cluster-resource-configure.html and https://github.com/jboss-openshift/cct_module/blob/master/jboss/container/java/jvm/bash/artifacts/opt/jboss/container/java/jvm/java-default-options" ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/nodownwardmemoryenv: container 'bar' does not have an env named 'CONTAINER_MAX_MEMORY' which is used by the Red Hat base images to calculate memory. See: https://docs.openshift.com/container-platform/4.4/nodes/clusters/nodes-cluster-resource-configure.html and https://github.com/jboss-openshift/cct_module/blob/master/jboss/container/java/jvm/bash/artifacts/opt/jboss/container/java/jvm/java-default-options" ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-image-latest" {
  tmp=$(split_files "policy/ocp/bestpractices/container-image-latest/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_image_latest"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/imageuseslatesttag: container 'bar' is using the latest tag for its image (quay.io/redhat-cop/openshift-applier:latest), which is an anti-pattern." ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/imageuseslatesttag: container 'bar' is using the latest tag for its image (quay.io/redhat-cop/openshift-applier:latest), which is an anti-pattern." ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-image-unknownregistries" {
  tmp=$(split_files "policy/ocp/bestpractices/container-image-unknownregistries/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_image_unknownregistries"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/imagefromunknownregistry: container 'bar' is using an image from an unknown registry (docker.io/alpine:3.12)" ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/imagefromunknownregistry: container 'bar' is using an image from an unknown registry (docker.io/alpine:3.12)" ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-java-xmx-set" {
  tmp=$(split_files "policy/ocp/bestpractices/container-java-xmx-set/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_java_xmx_set"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/xmxviacommand: container 'bar' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'" ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - Deployment/xmxviaargs: container 'bar' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'" ]
  [ "${lines[3]}" = "not ok 3 - ${tmp}/list.yml - Deployment/xmxviaenv: container 'bar' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'" ]
  [ "${lines[4]}" = "not ok 4 - ${tmp}/list.yml - DeploymentConfig/xmxviacommand: container 'bar' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'" ]
  [ "${lines[5]}" = "not ok 5 - ${tmp}/list.yml - DeploymentConfig/xmxviaargs: container 'bar' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'" ]
  [ "${lines[6]}" = "not ok 6 - ${tmp}/list.yml - DeploymentConfig/xmxviaenv: container 'bar' contains -Xmx in either, command, args or env. Instead, it is suggested you use the downward API to set the env 'CONTAINER_MAX_MEMORY'" ]
  [ "${lines[7]}" = "" ]
}

@test "policy/ocp/bestpractices/container-labelkey-inconsistent" {
  tmp=$(split_files "policy/ocp/bestpractices/container-labelkey-inconsistent/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_labelkey_inconsistent"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/nonestandardlabel: has a label key which did not start with 'app.kubernetes.io/' or 'redhat-cop.github.com/'. Found 'app'" ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/nonestandardlabel: has a label key which did not start with 'app.kubernetes.io/' or 'redhat-cop.github.com/'. Found 'app'" ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-liveness-readinessprobe-equal" {
  tmp=$(split_files "policy/ocp/bestpractices/container-liveness-readinessprobe-equal/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_liveness_readinessprobe_equal"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/probssetaresame: container 'bar' livenessProbe and readinessProbe are equal, which is an anti-pattern." ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/probssetaresame: container 'bar' livenessProbe and readinessProbe are equal, which is an anti-pattern." ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-livenessprobe-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-livenessprobe-notset/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_livenessprobe_notset"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/noproblivenessset: container 'bar' has no livenessProbe. See: https://docs.openshift.com/container-platform/4.4/applications/application-health.html" ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/noproblivenessset: container 'bar' has no livenessProbe. See: https://docs.openshift.com/container-platform/4.4/applications/application-health.html" ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-readinessprobe-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-readinessprobe-notset/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_readinessprobe_notset"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/noreadinessprob: container 'bar' has no readinessProbe. See: https://docs.openshift.com/container-platform/4.4/applications/application-health.html" ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/noreadinessprob: container 'bar' has no readinessProbe. See: https://docs.openshift.com/container-platform/4.4/applications/application-health.html" ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-resources-limits-cpu-set" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-cpu-set/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_resources_limits_cpu_set"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/resourceslimitscpuset: container 'bar' has cpu limits (1). It is not recommended to limit cpu. See: https://www.reddit.com/r/kubernetes/comments/all1vg/on_kubernetes_cpu_limits" ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/resourceslimitscpuset: container 'bar' has cpu limits (1). It is not recommended to limit cpu. See: https://www.reddit.com/r/kubernetes/comments/all1vg/on_kubernetes_cpu_limits" ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-resources-limits-memory-greater-than" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-memory-greater-than/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_resources_limits_memory_greater_than"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/memorylimittoolarge: container 'bar' has a memory limit of '7Gi' which is larger than the upper '6Gi' limit." ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/memorylimittoolarge: container 'bar' has a memory limit of '7Gi' which is larger than the upper '6Gi' limit." ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-resources-limits-memory-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-memory-notset/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_resources_limits_memory_notset"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/resourcelimitsmemorynotset: container 'bar' has no memory limits. It is recommended to limit memory, as memory always has a maximum. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers" ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/resourcelimitsmemorynotset: container 'bar' has no memory limits. It is recommended to limit memory, as memory always has a maximum. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers" ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-resources-memoryunit-incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-memoryunit-incorrect/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_resources_memoryunit_incorrect"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/invalidresourcesrequestsmemoryunits: container 'bar' memory resources for limits or requests (2Gi / 100m) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes" ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - Deployment/invalidresourceslimitsmemoryunits: container 'bar' memory resources for limits or requests (20000000m / 1Mi) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes" ]
  [ "${lines[3]}" = "not ok 3 - ${tmp}/list.yml - DeploymentConfig/invalidresourcesrequestsmemoryunits: container 'bar' memory resources for limits or requests (2Gi / 100m) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes" ]
  [ "${lines[4]}" = "not ok 4 - ${tmp}/list.yml - DeploymentConfig/invalidresourceslimitsmemoryunits: container 'bar' memory resources for limits or requests (20000000m / 1Mi) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes" ]
  [ "${lines[5]}" = "" ]
}

@test "policy/ocp/bestpractices/container-resources-requests-cpuunit-incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-requests-cpuunit-incorrect/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_resources_requests_cpuunit_incorrect"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/invalidresourcesrequestcpuunits container 'bar' cpu resources for requests (100M) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes" ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/invalidresourcesrequestcpuunits container 'bar' cpu resources for requests (100M) has an incorrect unit. See: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes" ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-resources-requests-memory-greater-than" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-requests-memory-greater-than/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_resources_requests_memory_greater_than"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/memoryrequesttoolarge: container 'bar' has a memory request of '3Gi' which is larger than the upper '2Gi' limit." ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/memoryrequesttoolarge: container 'bar' has a memory request of '3Gi' which is larger than the upper '2Gi' limit." ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-secret-mounted-envs" {
  tmp=$(split_files "policy/ocp/bestpractices/container-secret-mounted-envs/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_secret_mounted_envs"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/secretenvvars: container 'bar' has a secret 'my-secret' mounted as an environment variable. As secrets are not secret, its not good practice to mount as env vars." ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/secretenvvars: container 'bar' has a secret 'my-secret' mounted as an environment variable. As secrets are not secret, its not good practice to mount as env vars." ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-volumemount-inconsistent-path" {
  tmp=$(split_files "policy/ocp/bestpractices/container-volumemount-inconsistent-path/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_volumemount_inconsistent_path"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/notvarrunvolumemountspath: container 'bar' has a volumeMount 'my-secret' mountPath at '/some/random/path/my-secret'. A good practice is to use consistent mount paths, such as: /var/run/{organization}/{mount} - i.e.: /var/run/io.redhat-cop/my-secret" ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/notvarrunvolumemountspath: container 'bar' has a volumeMount 'my-secret' mountPath at '/some/random/path/my-secret'. A good practice is to use consistent mount paths, such as: /var/run/{organization}/{mount} - i.e.: /var/run/io.redhat-cop/my-secret" ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/container-volumemount-missing" {
  tmp=$(split_files "policy/ocp/bestpractices/container-volumemount-missing/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.container_volumemount_missing"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/missingvolumemount: volume 'my-missing-pvc' does not have a volumeMount in any of the containers." ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/missingvolumemount: volume 'my-missing-pvc' does not have a volumeMount in any of the containers." ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/deploymentconfig-triggers-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/deploymentconfig-triggers-notset/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.deploymentconfig_triggers_notset"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - DeploymentConfig/notriggers: has no triggers set. Could you use a k8s native Deployment? See: https://kubernetes.io/docs/concepts/workloads/controllers/deployment" ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/bestpractices/pod-hostnetwork" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-hostnetwork/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.pod_hostnetwork"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/hostnetworkisset: hostNetwork is present which gives the pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other pods on the same node." ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/hostnetworkisset: hostNetwork is present which gives the pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other pods on the same node." ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/pod-replicas-below-one" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-replicas-below-one/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.pod_replicas_below_one"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/replicaisone: replicas is 1 - expected replicas to be greater than 1 for HA guarantees." ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/replicaisone: replicas is 1 - expected replicas to be greater than 1 for HA guarantees." ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/pod-replicas-not-odd" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-replicas-not-odd/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.pod_replicas_not_odd"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/list.yml - Deployment/replicaiseven: replicas is 2 - expected an odd number for HA guarantees." ]
  [ "${lines[2]}" = "not ok 2 - ${tmp}/list.yml - DeploymentConfig/replicaiseven: replicas is 2 - expected an odd number for HA guarantees." ]
  [ "${lines[3]}" = "" ]
}

@test "policy/ocp/bestpractices/rolebinding-roleref-apigroup-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/rolebinding-roleref-apigroup-notset/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.rolebinding_roleref_apigroup_notset"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - RoleBinding/noapigroup: RoleBinding roleRef.apiGroup key is null, use rbac.authorization.k8s.io instead." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/bestpractices/rolebinding-roleref-kind-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/rolebinding-roleref-kind-notset/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.bestpractices.rolebinding_roleref_kind_notset"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - RoleBinding/nokind: RoleBinding roleRef.kind key is null, use ClusterRole or Role instead." ]
  [ "${lines[2]}" = "" ]
}

####################
# ocp/deprecated
####################

@test "policy/ocp/deprecated/3_11/buildconfig-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/buildconfig-v1/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp3_11.buildconfig_v1"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - BuildConfig/bar: API v1 for BuildConfig is no longer served by default, use build.openshift.io/v1 instead." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/3_11/deploymentconfig-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/deploymentconfig-v1/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp3_11.deploymentconfig_v1"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - DeploymentConfig/bar: API v1 for DeploymentConfig is no longer served by default, use apps.openshift.io/v1 instead." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/3_11/imagestream-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/imagestream-v1/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp3_11.imagestream_v1"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - ImageStream/bar: API v1 for ImageStream is no longer served by default, use image.openshift.io/v1 instead." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/3_11/projectrequest-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/projectrequest-v1/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp3_11.projectrequest_v1"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - ProjectRequest/bar: API v1 for ProjectRequest is no longer served by default, use project.openshift.io/v1 instead." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/3_11/rolebinding-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/rolebinding-v1/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp3_11.rolebinding_v1"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - RoleBinding/bar: API v1 for RoleBinding is no longer served by default, use rbac.authorization.k8s.io/v1 instead." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/3_11/route-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/route-v1/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp3_11.route_v1"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - Route/bar: API v1 for Route is no longer served by default, use route.openshift.io/v1 instead." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/3_11/securitycontextconstraints-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/securitycontextconstraints-v1/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp3_11.securitycontextconstraints_v1"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - SecurityContextConstraints/bar: API v1 for SecurityContextConstraints is no longer served by default, use security.openshift.io/v1 instead." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/3_11/template-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/template-v1/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp3_11.template_v1"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - Template/bar: API v1 for Template is no longer served by default, use template.openshift.io/v1 instead." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/4_1/buildconfig-custom-strategy" {
  tmp=$(split_files "policy/ocp/deprecated/4_1/buildconfig-custom-strategy/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp4_1.buildconfig_custom_strategy"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - BuildConfig/custombuild: 'spec.strategy.customStrategy.exposeDockerSocket' is deprecated. If you want to continue using custom builds, you should replace your Docker invocations with Podman or Buildah." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/4_2/authorization-openshift" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/authorization-openshift/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp4_2.authorization_openshift"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - ClusterRole/bar: API authorization.openshift.io for ClusterRole, ClusterRoleBinding, Role and RoleBinding is deprecated, use rbac.authorization.k8s.io/v1 instead." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/4_2/automationbroker-v1alpha1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/automationbroker-v1alpha1/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp4_2.automationbroker_v1alpha1"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - Bundle/bar: automationbroker.io/v1alpha1 is deprecated." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/4_2/catalogsourceconfigs-v1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/catalogsourceconfigs-v1/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp4_2.catalogsourceconfigs_v1"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - CatalogSourceConfigs/bar: operators.coreos.com/v1 is deprecated." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/4_2/catalogsourceconfigs-v2" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/catalogsourceconfigs-v2/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp4_2.catalogsourceconfigs_v2"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - CatalogSourceConfigs/bar: operators.coreos.com/v2 is deprecated." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/4_2/operatorsources-v1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/operatorsources-v1/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp4_2.operatorsources_v1"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - OperatorSource/bar: operators.coreos.com/v1 is deprecated." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/4_2/osb-v1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/osb-v1/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp4_2.osb_v1"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - TemplateServiceBroker/bar: osb.openshift.io/v1 is deprecated." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/4_2/servicecatalog-v1beta1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/servicecatalog-v1beta1/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp4_2.servicecatalog_v1beta1"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - ClusterServiceBroker/bar: servicecatalog.k8s.io/v1beta1 is deprecated." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/ocp/deprecated/4_3/buildconfig-jenkinspipeline-strategy" {
  tmp=$(split_files "policy/ocp/deprecated/4_3/buildconfig-jenkinspipeline-strategy/test_data/unit")

  cmd="conftest test ${tmp} --output tap --namespace ocp.deprecated.ocp4_3.buildconfig_jenkinspipeline_strategy"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/example.yml - BuildConfig/jenkinspipeline: 'spec.strategy.jenkinsPipelineStrategy' is deprecated. Use Jenkinsfiles directly on Jenkins or OpenShift Pipelines instead." ]
  [ "${lines[2]}" = "" ]
}

####################
# podman
####################

@test "policy/podman/history/contains-layer" {
  tmp=$(split_files "policy/podman/history/contains-layer/test_data/unit/jenkins-python-mising.json" "true")

  cmd="conftest test ${tmp}/jenkins-python-mising.json --output tap --namespace podman.history.contains_layer"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/jenkins-python-mising.json - quay.io/redhat-cop/jenkins-agent-python:has-missing-sha: did not find expected SHA." ]
  [ "${lines[2]}" = "" ]
}

@test "policy/podman/images/image-size-not-greater-than" {
  tmp=$(split_files "policy/podman/images/image-size-not-greater-than/test_data/unit" "true")

  cmd="conftest test ${tmp} --output tap --namespace podman.images.image_size_not_greater_than"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - ${tmp}/jenkins-base.json - quay.io/openshift/origin-jenkins-agent-base:4.4: has a size of '692.095652Mi', which is greater than '512Mi' limit." ]
  [ "${lines[2]}" = "" ]
}