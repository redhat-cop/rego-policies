#!/usr/bin/env bats

load bats-support-clone
load test_helper/bats-support/load
load test_helper/redhatcop-bats-library/load

# renovate: datasource=github-releases depName=garethahealy/openshift-json-schema
ocp_schema_version="4.18.0"

setup_file() {
  rm -rf /tmp/rhcop
  rm -f opa-profile.log

  if [[ ! -d "_test/schema-generation/openshift-json-schema" ]]; then
    mkdir -p _test/schema-generation/openshift-json-schema
    rm -rf /tmp/openshift-json-schema

    # Download openshift-json-schema dynamically so it doesnt need to be added into source
    git clone https://github.com/garethahealy/openshift-json-schema.git /tmp/openshift-json-schema --depth 1

    mv /tmp/openshift-json-schema/v${ocp_schema_version}/schemas/* _test/schema-generation/openshift-json-schema
  fi
}

check_violations() {
  tmp_file="${1}"
  policy_dir="${2}"
  policy_package="${3}"
  opa_data_params="${4}"

  tmp_path=$(dirname "${tmp_file}")

  opa eval --v0-compatible --input ${tmp_file} --data policy/lib ${opa_data_params} --data ${policy_dir}/src.rego ${policy_package} | jq '.' > ${tmp_path}/eval.json
  violation_count=$(jq '.result[].expressions[].value.violation | length' ${tmp_path}/eval.json)
  if [[ "${violation_count}" -ne 1 ]] ; then
    batslib_err "# opa eval --v0-compatible --input ${tmp_file} --data policy/lib ${opa_data_params} --data ${policy_dir}/src.rego ${policy_package}"
    fail "# FATAL-ERROR: check_violations: '.result[].expressions[].value.violation' count == ${violation_count}" || return $?
  fi

  policy_id=$(jq -r '.result[0].expressions[0].value.violation[0].details.policyID' ${tmp_path}/eval.json)
  echo "${policy_id}"
}

####################
# ocp/bestpractices
####################

@test "policy/ocp/bestpractices/common_k8s_labels_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/common_k8s_labels_notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/common_k8s_labels_notset"
  policy_package="data.ocp.bestpractices.common_k8s_labels_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00001" ]
}

@test "policy/ocp/bestpractices/container_env_maxmemory_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container_env_maxmemory_notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_env_maxmemory_notset"
  policy_package="data.ocp.bestpractices.container_env_maxmemory_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00002" ]
}

@test "policy/ocp/bestpractices/container_image_latest" {
  tmp=$(split_files "policy/ocp/bestpractices/container_image_latest/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_image_latest"
  policy_package="data.ocp.bestpractices.container_image_latest"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00003" ]
}


@test "policy/ocp/bestpractices/container_image_unknownregistries" {
  tmp=$(split_files "policy/ocp/bestpractices/container_image_unknownregistries/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_image_unknownregistries"
  policy_package="data.ocp.bestpractices.container_image_unknownregistries"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00004" ]
}

@test "policy/ocp/bestpractices/container_java_xmx_set" {
  tmp=$(split_files "policy/ocp/bestpractices/container_java_xmx_set/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_java_xmx_set"
  policy_package="data.ocp.bestpractices.container_java_xmx_set"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00005" ]
}

@test "policy/ocp/bestpractices/container_labelkey_inconsistent" {
  tmp=$(split_files "policy/ocp/bestpractices/container_labelkey_inconsistent/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_labelkey_inconsistent"
  policy_package="data.ocp.bestpractices.container_labelkey_inconsistent"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00006" ]
}

@test "policy/ocp/bestpractices/container_liveness_readinessprobe_equal" {
  tmp=$(split_files "policy/ocp/bestpractices/container_liveness_readinessprobe_equal/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_liveness_readinessprobe_equal"
  policy_package="data.ocp.bestpractices.container_liveness_readinessprobe_equal"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00007" ]
}

@test "policy/ocp/bestpractices/container_livenessprobe_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container_livenessprobe_notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_livenessprobe_notset"
  policy_package="data.ocp.bestpractices.container_livenessprobe_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00008" ]
}

@test "policy/ocp/bestpractices/container_readinessprobe_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container_readinessprobe_notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_readinessprobe_notset"
  policy_package="data.ocp.bestpractices.container_readinessprobe_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00009" ]
}

@test "policy/ocp/bestpractices/container_resources_limits_cpu_set" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_limits_cpu_set/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_resources_limits_cpu_set"
  policy_package="data.ocp.bestpractices.container_resources_limits_cpu_set"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00010" ]
}

@test "policy/ocp/bestpractices/container_resources_limits_memory_greater_than" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_limits_memory_greater_than/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_resources_limits_memory_greater_than"
  policy_package="data.ocp.bestpractices.container_resources_limits_memory_greater_than"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00011" ]
}

@test "policy/ocp/bestpractices/container_resources_limits_memory_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_limits_memory_notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_resources_limits_memory_notset"
  policy_package="data.ocp.bestpractices.container_resources_limits_memory_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00012" ]
}

@test "policy/ocp/bestpractices/container_resources_memoryunit_incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_memoryunit_incorrect/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_resources_memoryunit_incorrect"
  policy_package="data.ocp.bestpractices.container_resources_memoryunit_incorrect"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00013" ]
}

@test "policy/ocp/bestpractices/container_resources_requests_cpuunit_incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_requests_cpuunit_incorrect/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_resources_requests_cpuunit_incorrect"
  policy_package="data.ocp.bestpractices.container_resources_requests_cpuunit_incorrect"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00014" ]
}

@test "policy/ocp/bestpractices/container_resources_requests_memory_greater_than" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_requests_memory_greater_than/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_resources_requests_memory_greater_than"
  policy_package="data.ocp.bestpractices.container_resources_requests_memory_greater_than"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00015" ]
}

@test "policy/ocp/bestpractices/container_secret_mounted_envs" {
  tmp=$(split_files "policy/ocp/bestpractices/container_secret_mounted_envs/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_secret_mounted_envs"
  policy_package="data.ocp.bestpractices.container_secret_mounted_envs"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00016" ]
}

@test "policy/ocp/bestpractices/container_volumemount_inconsistent_path" {
  tmp=$(split_files "policy/ocp/bestpractices/container_volumemount_inconsistent_path/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_volumemount_inconsistent_path"
  policy_package="data.ocp.bestpractices.container_volumemount_inconsistent_path"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00017" ]
}

@test "policy/ocp/bestpractices/container_volumemount_missing" {
  tmp=$(split_files "policy/ocp/bestpractices/container_volumemount_missing/test_data/unit")

  policy_dir="policy/ocp/bestpractices/container_volumemount_missing"
  policy_package="data.ocp.bestpractices.container_volumemount_missing"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00018" ]
}

@test "policy/ocp/bestpractices/deploymentconfig_triggers_containername" {
  tmp=$(split_files "policy/ocp/bestpractices/deploymentconfig_triggers_containername/test_data/unit")

  policy_dir="policy/ocp/bestpractices/deploymentconfig_triggers_containername"
  policy_package="data.ocp.bestpractices.deploymentconfig_triggers_containername"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00027" ]
}

@test "policy/ocp/bestpractices/deploymentconfig_triggers_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/deploymentconfig_triggers_notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/deploymentconfig_triggers_notset"
  policy_package="data.ocp.bestpractices.deploymentconfig_triggers_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00019" ]
}

@test "policy/ocp/bestpractices/pod_hostnetwork" {
  tmp=$(split_files "policy/ocp/bestpractices/pod_hostnetwork/test_data/unit")

  policy_dir="policy/ocp/bestpractices/pod_hostnetwork"
  policy_package="data.ocp.bestpractices.pod_hostnetwork"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00020" ]
}

@test "policy/ocp/bestpractices/pod_replicas_below_one" {
  tmp=$(split_files "policy/ocp/bestpractices/pod_replicas_below_one/test_data/unit")

  policy_dir="policy/ocp/bestpractices/pod_replicas_below_one"
  policy_package="data.ocp.bestpractices.pod_replicas_below_one"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00021" ]
}

@test "policy/ocp/bestpractices/pod_replicas_not_odd" {
  tmp=$(split_files "policy/ocp/bestpractices/pod_replicas_not_odd/test_data/unit")

  policy_dir="policy/ocp/bestpractices/pod_replicas_not_odd"
  policy_package="data.ocp.bestpractices.pod_replicas_not_odd"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/list.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00022" ]
}

@test "policy/ocp/bestpractices/rolebinding_roleref_apigroup_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/rolebinding_roleref_apigroup_notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/rolebinding_roleref_apigroup_notset"
  policy_package="data.ocp.bestpractices.rolebinding_roleref_apigroup_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00023" ]
}

@test "policy/ocp/bestpractices/rolebinding_roleref_kind_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/rolebinding_roleref_kind_notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/rolebinding_roleref_kind_notset"
  policy_package="data.ocp.bestpractices.rolebinding_roleref_kind_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00024" ]
}

@test "policy/ocp/bestpractices/route_tls_termination_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/route_tls_termination_notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/route_tls_termination_notset"
  policy_package="data.ocp.bestpractices.route_tls_termination_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_BESTPRACT-00025" ]
}

@test "policy/ocp/bestpractices/pod_antiaffinity_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/pod_antiaffinity_notset/test_data/unit")

  policy_dir="policy/ocp/bestpractices/pod_antiaffinity_notset"
  policy_package="data.ocp.bestpractices.pod_antiaffinity_notset"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/list.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
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

@test "policy/ocp/deprecated/ocp3_11/buildconfig_v1" {
  tmp=$(split_files "policy/ocp/deprecated/ocp3_11/buildconfig_v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp3_11/buildconfig_v1"
  policy_package="data.ocp.deprecated.ocp3_11.buildconfig_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00001" ]
}

@test "policy/ocp/deprecated/ocp3_11/deploymentconfig_v1" {
  tmp=$(split_files "policy/ocp/deprecated/ocp3_11/deploymentconfig_v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp3_11/deploymentconfig_v1"
  policy_package="data.ocp.deprecated.ocp3_11.deploymentconfig_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00002" ]
}

@test "policy/ocp/deprecated/ocp3_11/imagestream_v1" {
  tmp=$(split_files "policy/ocp/deprecated/ocp3_11/imagestream_v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp3_11/imagestream_v1"
  policy_package="data.ocp.deprecated.ocp3_11.imagestream_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00003" ]
}

@test "policy/ocp/deprecated/ocp3_11/projectrequest_v1" {
  tmp=$(split_files "policy/ocp/deprecated/ocp3_11/projectrequest_v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp3_11/projectrequest_v1"
  policy_package="data.ocp.deprecated.ocp3_11.projectrequest_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00004" ]
}

@test "policy/ocp/deprecated/ocp3_11/rolebinding_v1" {
  tmp=$(split_files "policy/ocp/deprecated/ocp3_11/rolebinding_v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp3_11/rolebinding_v1"
  policy_package="data.ocp.deprecated.ocp3_11.rolebinding_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00005" ]
}

@test "policy/ocp/deprecated/ocp3_11/route_v1" {
  tmp=$(split_files "policy/ocp/deprecated/ocp3_11/route_v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp3_11/route_v1"
  policy_package="data.ocp.deprecated.ocp3_11.route_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00006" ]
}

@test "policy/ocp/deprecated/ocp3_11/securitycontextconstraints_v1" {
  tmp=$(split_files "policy/ocp/deprecated/ocp3_11/securitycontextconstraints_v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp3_11/securitycontextconstraints_v1"
  policy_package="data.ocp.deprecated.ocp3_11.securitycontextconstraints_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00007" ]
}

@test "policy/ocp/deprecated/ocp3_11/template_v1" {
  tmp=$(split_files "policy/ocp/deprecated/ocp3_11/template_v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp3_11/template_v1"
  policy_package="data.ocp.deprecated.ocp3_11.template_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-3.11-00008" ]
}

@test "policy/ocp/deprecated/ocp4_1/buildconfig_custom_strategy" {
  tmp=$(split_files "policy/ocp/deprecated/ocp4_1/buildconfig_custom_strategy/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp4_1/buildconfig_custom_strategy"
  policy_package="data.ocp.deprecated.ocp4_1.buildconfig_custom_strategy"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.1-00001" ]
}

@test "policy/ocp/deprecated/ocp4_2/authorization_openshift" {
  tmp=$(split_files "policy/ocp/deprecated/ocp4_2/authorization_openshift/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp4_2/authorization_openshift"
  policy_package="data.ocp.deprecated.ocp4_2.authorization_openshift"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.2-00001" ]
}

@test "policy/ocp/deprecated/ocp4_2/automationbroker_v1alpha1" {
  tmp=$(split_files "policy/ocp/deprecated/ocp4_2/automationbroker_v1alpha1/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp4_2/automationbroker_v1alpha1"
  policy_package="data.ocp.deprecated.ocp4_2.automationbroker_v1alpha1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.2-00002" ]
}

@test "policy/ocp/deprecated/ocp4_2/catalogsourceconfigs_v1" {
  tmp=$(split_files "policy/ocp/deprecated/ocp4_2/catalogsourceconfigs_v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp4_2/catalogsourceconfigs_v1"
  policy_package="data.ocp.deprecated.ocp4_2.catalogsourceconfigs_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.2-00003" ]
}

@test "policy/ocp/deprecated/ocp4_2/catalogsourceconfigs_v2" {
  tmp=$(split_files "policy/ocp/deprecated/ocp4_2/catalogsourceconfigs_v2/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp4_2/catalogsourceconfigs_v2"
  policy_package="data.ocp.deprecated.ocp4_2.catalogsourceconfigs_v2"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.2-00004" ]
}

@test "policy/ocp/deprecated/ocp4_2/operatorsources_v1" {
  tmp=$(split_files "policy/ocp/deprecated/ocp4_2/operatorsources_v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp4_2/operatorsources_v1"
  policy_package="data.ocp.deprecated.ocp4_2.operatorsources_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.2-00005" ]
}

@test "policy/ocp/deprecated/ocp4_2/osb_v1" {
  tmp=$(split_files "policy/ocp/deprecated/ocp4_2/osb_v1/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp4_2/osb_v1"
  policy_package="data.ocp.deprecated.ocp4_2.osb_v1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.2-00006" ]
}

@test "policy/ocp/deprecated/ocp4_2/servicecatalog_v1beta1" {
  tmp=$(split_files "policy/ocp/deprecated/ocp4_2/servicecatalog_v1beta1/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp4_2/servicecatalog_v1beta1"
  policy_package="data.ocp.deprecated.ocp4_2.servicecatalog_v1beta1"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/example.yml" "${policy_dir}" "${policy_package}")
  [ "${policy_id}" = "RHCOP-OCP_DEPRECATED-4.2-00007" ]
}

@test "policy/ocp/deprecated/ocp4_3/buildconfig_jenkinspipeline_strategy" {
  tmp=$(split_files "policy/ocp/deprecated/ocp4_3/buildconfig_jenkinspipeline_strategy/test_data/unit")

  policy_dir="policy/ocp/deprecated/ocp4_3/buildconfig_jenkinspipeline_strategy"
  policy_package="data.ocp.deprecated.ocp4_3.buildconfig_jenkinspipeline_strategy"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/example.yml --data policy/lib --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
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

@test "policy/podman/history/contains_layer" {
  tmp=$(split_files "policy/podman/history/contains_layer/test_data/unit/jenkins-python-mising.json" "true")

  policy_dir="policy/podman/history/contains_layer"
  policy_package="data.podman.history.contains_layer"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/jenkins-python-mising.json --data policy/lib --data policy/podman/data_parameters.rego --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/jenkins-python-mising.json" "${policy_dir}" "${policy_package}" "--data policy/podman/data_parameters.rego")
  [ "${policy_id}" = "RHCOP-PODMAN-00001" ]
}

@test "policy/podman/images/image_size_not_greater_than" {
  tmp=$(split_files "policy/podman/images/image_size_not_greater_than/test_data/unit" "true")

  policy_dir="policy/podman/images/image_size_not_greater_than"
  policy_package="data.podman.images.image_size_not_greater_than"
  schema_dir="_test/schema-generation/openshift-json-schema"

  cmd="opa eval --v0-compatible --input ${tmp}/jenkins-base.json --data policy/lib --data policy/podman/data_parameters.rego --data ${policy_dir}/src.rego --profile --format pretty --schema ${schema_dir} ${policy_package}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  echo "${cmd} ${output}" >> opa-profile.log

  policy_id=$(check_violations "${tmp}/jenkins-base.json" "${policy_dir}" "${policy_package}" "--data policy/podman/data_parameters.rego")
  [ "${policy_id}" = "RHCOP-PODMAN-00002" ]
}
