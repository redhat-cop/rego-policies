#!/usr/bin/env bats

load bats-support-clone
load test_helper/bats-support/load
load test_helper/redhatcop-bats-library/load

setup_file() {
  rm -rf /tmp/rhcop
  rm -f opa-profile.log
}

check_violations() {
  tmp_file="${1}"
  policy_dir="${2}"
  policy_package="${3}"
  opa_data_params="${4}"

  tmp_path=$(dirname "${tmp_file}")

  opa eval --input ${tmp_file} --data policy/lib ${opa_data_params} --data ${policy_dir}/src.rego ${policy_package} | jq '.' > ${tmp_path}/eval.json
  violation_count=$(jq '.result[].expressions[].value.violation | length' ${tmp_path}/eval.json)
  if [[ "${violation_count}" -ne 1 ]] ; then
    batslib_err "# opa eval --input ${tmp_file} --data policy/lib ${opa_data_params} --data ${policy_dir}/src.rego ${policy_package}"
    fail "# FATAL-ERROR: check_violations: '.result[].expressions[].value.violation' count == ${violation_count}" || return $?
  fi

  policy_id=$(jq -r '.result[0].expressions[0].value.violation[0].details.policyID' ${tmp_path}/eval.json)
  echo "${policy_id}"
}

####################
# ocp/bestpractices
####################

@test "policy/ocp/bestpractices/common-k8s-labels-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/common-k8s-labels-notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/common-k8s-labels-notset"
  policy_package="data.ocp.bestpractices.common_k8s_labels_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00001" ]
}

@test "policy/ocp/bestpractices/container-env-maxmemory-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-env-maxmemory-notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-env-maxmemory-notset"
  policy_package="data.ocp.bestpractices.container_env_maxmemory_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00002" ]
}

@test "policy/ocp/bestpractices/container-image-latest" {
  tmp=$(split_files "policy/ocp/bestpractices/container-image-latest/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-image-latest"
  policy_package="data.ocp.bestpractices.container_image_latest"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00003" ]
}


@test "policy/ocp/bestpractices/container-image-unknownregistries" {
  tmp=$(split_files "policy/ocp/bestpractices/container-image-unknownregistries/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-image-unknownregistries"
  policy_package="data.ocp.bestpractices.container_image_unknownregistries"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00004" ]
}

@test "policy/ocp/bestpractices/container-java-xmx-set" {
  tmp=$(split_files "policy/ocp/bestpractices/container-java-xmx-set/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-java-xmx-set"
  policy_package="data.ocp.bestpractices.container_java_xmx_set"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00005" ]
}

@test "policy/ocp/bestpractices/container-labelkey-inconsistent" {
  tmp=$(split_files "policy/ocp/bestpractices/container-labelkey-inconsistent/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-labelkey-inconsistent"
  policy_package="data.ocp.bestpractices.container_labelkey_inconsistent"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00006" ]
}

@test "policy/ocp/bestpractices/container-liveness-readinessprobe-equal" {
  tmp=$(split_files "policy/ocp/bestpractices/container-liveness-readinessprobe-equal/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-liveness-readinessprobe-equal"
  policy_package="data.ocp.bestpractices.container_liveness_readinessprobe_equal"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00007" ]
}

@test "policy/ocp/bestpractices/container-livenessprobe-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-livenessprobe-notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-livenessprobe-notset"
  policy_package="data.ocp.bestpractices.container_livenessprobe_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00008" ]
}

@test "policy/ocp/bestpractices/container-readinessprobe-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-readinessprobe-notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-readinessprobe-notset"
  policy_package="data.ocp.bestpractices.container_readinessprobe_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00009" ]
}

@test "policy/ocp/bestpractices/container-resources-limits-cpu-set" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-cpu-set/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-resources-limits-cpu-set"
  policy_package="data.ocp.bestpractices.container_resources_limits_cpu_set"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00010" ]
}

@test "policy/ocp/bestpractices/container-resources-limits-memory-greater-than" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-memory-greater-than/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-resources-limits-memory-greater-than"
  policy_package="data.ocp.bestpractices.container_resources_limits_memory_greater_than"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00011" ]
}

@test "policy/ocp/bestpractices/container-resources-limits-memory-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-memory-notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-resources-limits-memory-notset"
  policy_package="data.ocp.bestpractices.container_resources_limits_memory_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00012" ]
}

@test "policy/ocp/bestpractices/container-resources-memoryunit-incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-memoryunit-incorrect/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-resources-memoryunit-incorrect"
  policy_package="data.ocp.bestpractices.container_resources_memoryunit_incorrect"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00013" ]
}

@test "policy/ocp/bestpractices/container-resources-requests-cpuunit-incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-requests-cpuunit-incorrect/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-resources-requests-cpuunit-incorrect"
  policy_package="data.ocp.bestpractices.container_resources_requests_cpuunit_incorrect"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00014" ]
}

@test "policy/ocp/bestpractices/container-resources-requests-memory-greater-than" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-requests-memory-greater-than/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-resources-requests-memory-greater-than"
  policy_package="data.ocp.bestpractices.container_resources_requests_memory_greater_than"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00015" ]
}

@test "policy/ocp/bestpractices/container-secret-mounted-envs" {
  tmp=$(split_files "policy/ocp/bestpractices/container-secret-mounted-envs/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-secret-mounted-envs"
  policy_package="data.ocp.bestpractices.container_secret_mounted_envs"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00016" ]
}

@test "policy/ocp/bestpractices/container-volumemount-inconsistent-path" {
  tmp=$(split_files "policy/ocp/bestpractices/container-volumemount-inconsistent-path/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-volumemount-inconsistent-path"
  policy_package="data.ocp.bestpractices.container_volumemount_inconsistent_path"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00017" ]
}

@test "policy/ocp/bestpractices/container-volumemount-missing" {
  tmp=$(split_files "policy/ocp/bestpractices/container-volumemount-missing/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container-volumemount-missing"
  policy_package="data.ocp.bestpractices.container_volumemount_missing"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00018" ]
}

@test "policy/ocp/bestpractices/deploymentconfig-triggers-containername" {
  tmp=$(split_files "policy/ocp/bestpractices/deploymentconfig-triggers-containername/test_data/unit")

  policy_dir="policy/ocp/bestpractices/deploymentconfig-triggers-containername"
  policy_package="data.ocp.bestpractices.deploymentconfig_triggers_containername"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00027" ]
}

@test "policy/ocp/bestpractices/deploymentconfig-triggers-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/deploymentconfig-triggers-notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/deploymentconfig-triggers-notset"
  policy_package="data.ocp.bestpractices.deploymentconfig_triggers_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00019" ]
}

@test "policy/ocp/bestpractices/pod-hostnetwork" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-hostnetwork/test_data/unit")

  policy_dir="policy/ocp/bestpractices/pod-hostnetwork"
  policy_package="data.ocp.bestpractices.pod_hostnetwork"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00020" ]
}

@test "policy/ocp/bestpractices/pod-replicas-below-one" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-replicas-below-one/test_data/unit")

  policy_dir="policy/ocp/bestpractices/pod-replicas-below-one"
  policy_package="data.ocp.bestpractices.pod_replicas_below_one"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00021" ]
}

@test "policy/ocp/bestpractices/pod-replicas-not-odd" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-replicas-not-odd/test_data/unit")

  policy_dir="policy/ocp/bestpractices/pod-replicas-not-odd"
  policy_package="data.ocp.bestpractices.pod_replicas_not_odd"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00022" ]
}

@test "policy/ocp/bestpractices/rolebinding-roleref-apigroup-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/rolebinding-roleref-apigroup-notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/rolebinding-roleref-apigroup-notset"
  policy_package="data.ocp.bestpractices.rolebinding_roleref_apigroup_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00023" ]
}

@test "policy/ocp/bestpractices/rolebinding-roleref-kind-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/rolebinding-roleref-kind-notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/rolebinding-roleref-kind-notset"
  policy_package="data.ocp.bestpractices.rolebinding_roleref_kind_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00024" ]
}

@test "policy/ocp/bestpractices/route-tls-termination-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/route-tls-termination-notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/route-tls-termination-notset"
  policy_package="data.ocp.bestpractices.route_tls_termination_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00025" ]
}

@test "policy/ocp/bestpractices/pod-antiaffinity-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-antiaffinity-notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/pod-antiaffinity-notset"
  policy_package="data.ocp.bestpractices.pod_antiaffinity_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00026" ]
}

####################
# ocp/deprecated
####################

@test "policy/ocp/deprecated/3_11/buildconfig-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/buildconfig-v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/3_11/buildconfig-v1"
  policy_package="data.ocp.deprecated.ocp3_11.buildconfig_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00001" ]
}

@test "policy/ocp/deprecated/3_11/deploymentconfig-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/deploymentconfig-v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/3_11/deploymentconfig-v1"
  policy_package="data.ocp.deprecated.ocp3_11.deploymentconfig_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00002" ]
}

@test "policy/ocp/deprecated/3_11/imagestream-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/imagestream-v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/3_11/imagestream-v1"
  policy_package="data.ocp.deprecated.ocp3_11.imagestream_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00003" ]
}

@test "policy/ocp/deprecated/3_11/projectrequest-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/projectrequest-v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/3_11/projectrequest-v1"
  policy_package="data.ocp.deprecated.ocp3_11.projectrequest_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00004" ]
}

@test "policy/ocp/deprecated/3_11/rolebinding-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/rolebinding-v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/3_11/rolebinding-v1"
  policy_package="data.ocp.deprecated.ocp3_11.rolebinding_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00005" ]
}

@test "policy/ocp/deprecated/3_11/route-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/route-v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/3_11/route-v1"
  policy_package="data.ocp.deprecated.ocp3_11.route_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00006" ]
}

@test "policy/ocp/deprecated/3_11/securitycontextconstraints-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/securitycontextconstraints-v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/3_11/securitycontextconstraints-v1"
  policy_package="data.ocp.deprecated.ocp3_11.securitycontextconstraints_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00007" ]
}

@test "policy/ocp/deprecated/3_11/template-v1" {
  tmp=$(split_files "policy/ocp/deprecated/3_11/template-v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/3_11/template-v1"
  policy_package="data.ocp.deprecated.ocp3_11.template_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00008" ]
}

@test "policy/ocp/deprecated/4_1/buildconfig-custom-strategy" {
  tmp=$(split_files "policy/ocp/deprecated/4_1/buildconfig-custom-strategy/test_data/unit")

  policy_dir="policy/ocp/deprecated/4_1/buildconfig-custom-strategy"
  policy_package="data.ocp.deprecated.ocp4_1.buildconfig_custom_strategy"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.1-00001" ]
}

@test "policy/ocp/deprecated/4_2/authorization-openshift" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/authorization-openshift/test_data/unit")

  policy_dir="policy/ocp/deprecated/4_2/authorization-openshift"
  policy_package="data.ocp.deprecated.ocp4_2.authorization_openshift"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.2-00001" ]
}

@test "policy/ocp/deprecated/4_2/automationbroker-v1alpha1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/automationbroker-v1alpha1/test_data/unit")

  policy_dir="policy/ocp/deprecated/4_2/automationbroker-v1alpha1"
  policy_package="data.ocp.deprecated.ocp4_2.automationbroker_v1alpha1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.2-00002" ]
}

@test "policy/ocp/deprecated/4_2/catalogsourceconfigs-v1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/catalogsourceconfigs-v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/4_2/catalogsourceconfigs-v1"
  policy_package="data.ocp.deprecated.ocp4_2.catalogsourceconfigs_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.2-00003" ]
}

@test "policy/ocp/deprecated/4_2/catalogsourceconfigs-v2" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/catalogsourceconfigs-v2/test_data/unit")

  policy_dir="policy/ocp/deprecated/4_2/catalogsourceconfigs-v2"
  policy_package="data.ocp.deprecated.ocp4_2.catalogsourceconfigs_v2"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.2-00004" ]
}

@test "policy/ocp/deprecated/4_2/operatorsources-v1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/operatorsources-v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/4_2/operatorsources-v1"
  policy_package="data.ocp.deprecated.ocp4_2.operatorsources_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.2-00005" ]
}

@test "policy/ocp/deprecated/4_2/osb-v1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/osb-v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/4_2/osb-v1"
  policy_package="data.ocp.deprecated.ocp4_2.osb_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.2-00006" ]
}

@test "policy/ocp/deprecated/4_2/servicecatalog-v1beta1" {
  tmp=$(split_files "policy/ocp/deprecated/4_2/servicecatalog-v1beta1/test_data/unit")

  policy_dir="policy/ocp/deprecated/4_2/servicecatalog-v1beta1"
  policy_package="data.ocp.deprecated.ocp4_2.servicecatalog_v1beta1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.2-00007" ]
}

@test "policy/ocp/deprecated/4_3/buildconfig-jenkinspipeline-strategy" {
  tmp=$(split_files "policy/ocp/deprecated/4_3/buildconfig-jenkinspipeline-strategy/test_data/unit")

  policy_dir="policy/ocp/deprecated/4_3/buildconfig-jenkinspipeline-strategy"
  policy_package="data.ocp.deprecated.ocp4_3.buildconfig_jenkinspipeline_strategy"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.3-00001" ]
}

####################
# podman
####################

@test "policy/podman/history/contains-layer" {
  tmp=$(split_files "policy/podman/history/contains-layer/test_data/unit/jenkins-python-mising.json" "true")

  policy_dir="policy/podman/history/contains-layer"
  policy_package="data.podman.history.contains_layer"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/jenkins-python-mising.json --data policy/lib --data policy/podman/data_parameters.rego --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/jenkins-python-mising.json" "${policy_dir}" "${policy_package}" "--data policy/podman/data_parameters.rego")
  [ "${policy_id}" = "RHCOP-PODMAN-00001" ]
}

@test "policy/podman/images/image-size-not-greater-than" {
  tmp=$(split_files "policy/podman/images/image-size-not-greater-than/test_data/unit" "true")

  policy_dir="policy/podman/images/image-size-not-greater-than"
  policy_package="data.podman.images.image_size_not_greater_than"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --input ${tmp}/jenkins-base.json --data policy/lib --data policy/podman/data_parameters.rego --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/jenkins-base.json" "${policy_dir}" "${policy_package}" "--data policy/podman/data_parameters.rego")
  [ "${policy_id}" = "RHCOP-PODMAN-00002" ]
}