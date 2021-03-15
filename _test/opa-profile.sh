#!/usr/bin/env bats

load bats-support-clone
load test_helper/bats-support/load
load test_helper/redhatcop-bats-library/load

setup_file() {
  rm -rf /tmp/rhcop
  rm -f opa-profile.log
}

####################
# ocp/bestpractices
####################

@test "policy/ocp/bestpractices/common-k8s-labels-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/common-k8s-labels-notset/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.common_k8s_labels_notset"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-env-maxmemory-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-env-maxmemory-notset/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_env_maxmemory_notset"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-image-latest" {
  tmp=$(split_files "policy/ocp/bestpractices/container-image-latest/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_image_latest"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}


@test "policy/ocp/bestpractices/container-image-unknownregistries" {
  tmp=$(split_files "policy/ocp/bestpractices/container-image-unknownregistries/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_image_unknownregistries"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-java-xmx-set" {
  tmp=$(split_files "policy/ocp/bestpractices/container-java-xmx-set/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_java_xmx_set"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-labelkey-inconsistent" {
  tmp=$(split_files "policy/ocp/bestpractices/container-labelkey-inconsistent/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_labelkey_inconsistent"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-liveness-readinessprobe-equal" {
  tmp=$(split_files "policy/ocp/bestpractices/container-liveness-readinessprobe-equal/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_liveness_readinessprobe_equal"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-livenessprobe-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-livenessprobe-notset/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_livenessprobe_notset"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-readinessprobe-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-readinessprobe-notset/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_readinessprobe_notset"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-resources-limits-cpu-set" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-cpu-set/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_resources_limits_cpu_set"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-resources-limits-memory-greater-than" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-memory-greater-than/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_resources_limits_memory_greater_than"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-resources-limits-memory-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-memory-notset/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_resources_limits_memory_notset"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-resources-memoryunit-incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-memoryunit-incorrect/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_resources_memoryunit_incorrect"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-resources-requests-cpuunit-incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-requests-cpuunit-incorrect/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_resources_requests_cpuunit_incorrect"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-resources-requests-memory-greater-than" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-requests-memory-greater-than/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_resources_requests_memory_greater_than"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-secret-mounted-envs" {
  tmp=$(split_files "policy/ocp/bestpractices/container-secret-mounted-envs/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_secret_mounted_envs"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-volumemount-inconsistent-path" {
  tmp=$(split_files "policy/ocp/bestpractices/container-volumemount-inconsistent-path/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_volumemount_inconsistent_path"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/container-volumemount-missing" {
  tmp=$(split_files "policy/ocp/bestpractices/container-volumemount-missing/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.container_volumemount_missing"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/deploymentconfig-triggers-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/deploymentconfig-triggers-notset/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.bestpractices.deploymentconfig_triggers_notset"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/pod-hostnetwork" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-hostnetwork/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.pod_hostnetwork"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/pod-replicas-below-one" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-replicas-below-one/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.pod_replicas_below_one"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/pod-replicas-not-odd" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-replicas-not-odd/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.pod_replicas_not_odd"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/rolebinding-roleref-apigroup-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/rolebinding-roleref-apigroup-notset/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.bestpractices.rolebinding_roleref_apigroup_notset"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/rolebinding-roleref-kind-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/rolebinding-roleref-kind-notset/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.bestpractices.rolebinding_roleref_kind_notset"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/route-tls-termination-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/route-tls-termination-notset/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.bestpractices.route_tls_termination_notset"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/pod-antiaffinity-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-antiaffinity-notset/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/list.yml --profile --format=pretty data.ocp.bestpractices.pod_antiaffinity_notset"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

####################
# ocp/deprecated
####################

@test "policy/ocp/deprecated/3_11/buildconfig-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/buildconfig-v1/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp3_11.buildconfig_v1"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/3_11/deploymentconfig-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/deploymentconfig-v1/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp3_11.deploymentconfig_v1"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/3_11/imagestream-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/imagestream-v1/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp3_11.imagestream_v1"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/3_11/projectrequest-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/projectrequest-v1/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp3_11.projectrequest_v1"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/3_11/rolebinding-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/rolebinding-v1/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp3_11.rolebinding_v1"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/3_11/route-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/route-v1/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp3_11.route_v1"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/3_11/securitycontextconstraints-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/securitycontextconstraints-v1/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp3_11.securitycontextconstraints_v1"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/3_11/template-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/template-v1/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp3_11.template_v1"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/4_1/buildconfig-custom-strategy" {
  tmp=$(split_files "policy/ocp/deprecated/4_1/buildconfig-custom-strategy/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp4_1.buildconfig_custom_strategy"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/4_2/authorization-openshift" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/authorization-openshift/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp4_2.authorization_openshift"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/4_2/automationbroker-v1alpha1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/automationbroker-v1alpha1/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp4_2.automationbroker_v1alpha1"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/4_2/catalogsourceconfigs-v1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/catalogsourceconfigs-v1/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp4_2.catalogsourceconfigs_v1"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/4_2/catalogsourceconfigs-v2" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/catalogsourceconfigs-v2/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp4_2.catalogsourceconfigs_v2"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/4_2/operatorsources-v1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/operatorsources-v1/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp4_2.operatorsources_v1"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/4_2/osb-v1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/osb-v1/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp4_2.osb_v1"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/4_2/servicecatalog-v1beta1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/servicecatalog-v1beta1/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp4_2.servicecatalog_v1beta1"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/ocp/deprecated/4_3/buildconfig-jenkinspipeline-strategy" {
  tmp=$(split_files "policy/ocp/deprecated/4_3/buildconfig-jenkinspipeline-strategy/test_data/unit")

  cmd="opa eval --bundle policy/ --input ${tmp}/example.yml --profile --format=pretty data.ocp.deprecated.ocp4_3.buildconfig_jenkinspipeline_strategy"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

####################
# podman
####################

@test "policy/podman/history/contains-layer" {
  tmp=$(split_files "policy/podman/history/contains-layer/test_data/unit/jenkins-python-mising.json" "true")

  cmd="opa eval --bundle policy/ --input ${tmp}/jenkins-python-mising.json --profile --format=pretty data.podman.history.contains_layer"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}

@test "policy/podman/images/image-size-not-greater-than" {
  tmp=$(split_files "policy/podman/images/image-size-not-greater-than/test_data/unit" "true")

  cmd="opa eval --bundle policy/ --input ${tmp}/jenkins-base.json --profile --format=pretty data.podman.images.image_size_not_greater_than"
  run ${cmd}

  echo "${cmd} ${output}" >> opa-profile.log
  [ "$status" -eq 0 ]
}