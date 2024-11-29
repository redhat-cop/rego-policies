#!/usr/bin/env bats

load bats-support-clone
load bats-support-setup
load test_helper/bats-support/load
load test_helper/redhatcop-bats-library/load

setup_file() {
  kubectl api-versions --request-timeout=5s || return $?
  kubectl cluster-info || return $?

  export project_name="regopolicies-undertest-$(date +'%d%m%Y-%H%M%S')"
  export project_name_disabled="regopolicies-undertest-disabled-$(date +'%d%m%Y-%H%M%S')"

  _setup_file "${project_name}" "${project_name_disabled}" "true"
}

teardown_file() {
  _teardown_file "${project_name}" "${project_name_disabled}"
}

teardown() {
  _teardown "${tmp}"
}

####################
# all-namespaces
####################

@test "policy/ocp/bestpractices/_all-namespaces" {
  alltmp=$(split_files "policy/ocp/bestpractices/_all-namespaces/test_data/integration")
  remove_ocp_resources "${alltmp}/all.yml"

  cmd="kubectl create -f ${alltmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${alltmp}"
  [ "$status" -eq 0 ]
}

####################
# ocp/bestpractices
####################

@test "policy/ocp/bestpractices/common_k8s_labels_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/common_k8s_labels_notset/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [commonk8slabelsnotset] RHCOP-OCP_BESTPRACT-00001: Deployment/nolabels"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_env_maxmemory_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container_env_maxmemory_notset/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}
  
  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containerenvmaxmemorynotset] RHCOP-OCP_BESTPRACT-00002: Deployment/nodownwardmemoryenv"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_image_latest" {
  tmp=$(split_files "policy/ocp/bestpractices/container_image_latest/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containerimagelatest] RHCOP-OCP_BESTPRACT-00003: Deployment/imageuseslatesttag"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_image_unknownregistries" {
  tmp=$(split_files "policy/ocp/bestpractices/container_image_unknownregistries/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containerimageunknownregistries] RHCOP-OCP_BESTPRACT-00004: Deployment/imagefromunknownregistry"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_java_xmx_set" {
  tmp=$(split_files "policy/ocp/bestpractices/container_java_xmx_set/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containerjavaxmxset] RHCOP-OCP_BESTPRACT-00005: Deployment/xmxviacommand"* ]]
  [[ "${lines[1]}" == *"denied the request: [containerjavaxmxset] RHCOP-OCP_BESTPRACT-00005: Deployment/xmxviaargs"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerjavaxmxset] RHCOP-OCP_BESTPRACT-00005: Deployment/xmxviaenv"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_labelkey_inconsistent" {
  tmp=$(split_files "policy/ocp/bestpractices/container_labelkey_inconsistent/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containerlabelkeyinconsistent] RHCOP-OCP_BESTPRACT-00006: Deployment/nonestandardlabel"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_liveness_readinessprobe_equal" {
  tmp=$(split_files "policy/ocp/bestpractices/container_liveness_readinessprobe_equal/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containerlivenessreadinessprobeequal] RHCOP-OCP_BESTPRACT-00007: Deployment/probssetaresame"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_livenessprobe_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container_livenessprobe_notset/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containerlivenessprobenotset] RHCOP-OCP_BESTPRACT-00008: Deployment/noproblivenessset"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_readinessprobe_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container_readinessprobe_notset/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containerreadinessprobenotset] RHCOP-OCP_BESTPRACT-00009: Deployment/noreadinessprob"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_resources_limits_cpu_set" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_limits_cpu_set/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containerresourceslimitscpuset] RHCOP-OCP_BESTPRACT-00010: Deployment/resourceslimitscpuset"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_resources_limits_memory_greater_than" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_limits_memory_greater_than/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containerresourceslimitsmemorygreaterthan] RHCOP-OCP_BESTPRACT-00011: Deployment/memorylimittoolarge"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_resources_limits_memory_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_limits_memory_notset/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containerresourceslimitsmemorynotset] RHCOP-OCP_BESTPRACT-00012: Deployment/resourcelimitsmemorynotset"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_resources_memoryunit_incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_memoryunit_incorrect/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]

  [[ "${lines[0]}" == *"spec.template.spec.containers[0].resources.requests[memory]: fractional byte value"* ]]
  [[ "${lines[1]}" == *"spec.template.spec.containers[0].resources.limits[memory]: fractional byte value"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerresourcesmemoryunitincorrect] RHCOP-OCP_BESTPRACT-00013: Deployment/invalidresourcesrequestsmemoryunits"* ]]
  [[ "${lines[3]}" == *"denied the request: [containerresourcesmemoryunitincorrect] RHCOP-OCP_BESTPRACT-00013: Deployment/invalidresourceslimitsmemoryunits"* ]]
  [[ "${#lines[@]}" -eq 4 ]]
}

@test "policy/ocp/bestpractices/container_resources_requests_cpuunit_incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_requests_cpuunit_incorrect/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containerresourcesrequestscpuunitincorrect] RHCOP-OCP_BESTPRACT-00014: Deployment/invalidresourcesrequestcpuunits"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_resources_requests_memory_greater_than" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_requests_memory_greater_than/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containerresourcesrequestsmemorygreaterthan] RHCOP-OCP_BESTPRACT-00015: Deployment/memoryrequesttoolarge"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_secret_mounted_envs" {
  tmp=$(split_files "policy/ocp/bestpractices/container_secret_mounted_envs/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containersecretmountedenvs] RHCOP-OCP_BESTPRACT-00016: Deployment/secretenvvars"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_volumemount_inconsistent_path" {
  tmp=$(split_files "policy/ocp/bestpractices/container_volumemount_inconsistent_path/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containervolumemountinconsistentpath] RHCOP-OCP_BESTPRACT-00017: Deployment/notvarrunvolumemountspath"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container_volumemount_missing" {
  tmp=$(split_files "policy/ocp/bestpractices/container_volumemount_missing/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [containervolumemountmissing] RHCOP-OCP_BESTPRACT-00018: Deployment/missingvolumemount"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/pod_hostnetwork" {
  tmp=$(split_files "policy/ocp/bestpractices/pod_hostnetwork/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [podhostnetwork] RHCOP-OCP_BESTPRACT-00020: Deployment/hostnetworkisset"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/pod_replicas_below_one" {
  tmp=$(split_files "policy/ocp/bestpractices/pod_replicas_below_one/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [podreplicasbelowone] RHCOP-OCP_BESTPRACT-00021: Deployment/replicaisone"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/pod_replicas_not_odd" {
  tmp=$(split_files "policy/ocp/bestpractices/pod_replicas_not_odd/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [podreplicasnotodd] RHCOP-OCP_BESTPRACT-00022: Deployment/replicaiseven"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

####################
# ocp/bestpractices - with disabled policy label on project
####################

@test "policy/ocp/bestpractices/_all-namespaces - disabled policy label" {
  alltmp=$(split_files "policy/ocp/bestpractices/_all-namespaces/test_data/integration")
  remove_ocp_resources "${alltmp}/all.yml"

  cmd="kubectl create -f ${alltmp} -n ${project_name_disabled}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${alltmp}"
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/common_k8s_labels_notset - disabled policy label" {
  tmp=$(split_files "policy/ocp/bestpractices/common_k8s_labels_notset/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="kubectl create -f ${tmp} -n ${project_name_disabled}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  [[ "${lines[0]}" == "deployment.apps/nolabels created" ]]
  [[ "${#lines[@]}" -eq 1 ]]
}
