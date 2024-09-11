#!/usr/bin/env bats

load bats-support-clone
load bats-support-setup
load test_helper/bats-support/load
load test_helper/redhatcop-bats-library/load

setup_file() {
  oc api-versions --request-timeout=5s || return $?
  oc cluster-info || return $?

  export project_name="regopolicies-undertest-$(date +'%d%m%Y-%H%M%S')"
  export project_name_disabled="regopolicies-undertest-disabled-$(date +'%d%m%Y-%H%M%S')"

  _setup_file "${project_name}" "${project_name_disabled}"
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

  cmd="oc create -f ${alltmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${alltmp}"
  [ "$status" -eq 0 ]
}

####################
# ocp/bestpractices
####################

@test "policy/ocp/bestpractices/common_k8s_labels_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/common_k8s_labels_notset/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [commonk8slabelsnotset] RHCOP-OCP_BESTPRACT-00001: Deployment/nolabels"* ]]
  [[ "${lines[2]}" == *"denied the request: [commonk8slabelsnotset] RHCOP-OCP_BESTPRACT-00001: DeploymentConfig/nolabels"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_env_maxmemory_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container_env_maxmemory_notset/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}
  
  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containerenvmaxmemorynotset] RHCOP-OCP_BESTPRACT-00002: Deployment/nodownwardmemoryenv"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerenvmaxmemorynotset] RHCOP-OCP_BESTPRACT-00002: DeploymentConfig/nodownwardmemoryenv"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_image_latest" {
  tmp=$(split_files "policy/ocp/bestpractices/container_image_latest/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containerimagelatest] RHCOP-OCP_BESTPRACT-00003: Deployment/imageuseslatesttag"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerimagelatest] RHCOP-OCP_BESTPRACT-00003: DeploymentConfig/imageuseslatesttag"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_image_unknownregistries" {
  tmp=$(split_files "policy/ocp/bestpractices/container_image_unknownregistries/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containerimageunknownregistries] RHCOP-OCP_BESTPRACT-00004: Deployment/imagefromunknownregistry"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerimageunknownregistries] RHCOP-OCP_BESTPRACT-00004: DeploymentConfig/imagefromunknownregistry"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_java_xmx_set" {
  tmp=$(split_files "policy/ocp/bestpractices/container_java_xmx_set/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containerjavaxmxset] RHCOP-OCP_BESTPRACT-00005: Deployment/xmxviacommand"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerjavaxmxset] RHCOP-OCP_BESTPRACT-00005: Deployment/xmxviaargs"* ]]
  [[ "${lines[3]}" == *"denied the request: [containerjavaxmxset] RHCOP-OCP_BESTPRACT-00005: Deployment/xmxviaenv"* ]]
  [[ "${lines[4]}" == *"denied the request: [containerjavaxmxset] RHCOP-OCP_BESTPRACT-00005: DeploymentConfig/xmxviacommand"* ]]
  [[ "${lines[5]}" == *"denied the request: [containerjavaxmxset] RHCOP-OCP_BESTPRACT-00005: DeploymentConfig/xmxviaargs"* ]]
  [[ "${lines[6]}" == *"denied the request: [containerjavaxmxset] RHCOP-OCP_BESTPRACT-00005: DeploymentConfig/xmxviaenv"* ]]
  [[ "${#lines[@]}" -eq 7 ]]
}

@test "policy/ocp/bestpractices/container_labelkey_inconsistent" {
  tmp=$(split_files "policy/ocp/bestpractices/container_labelkey_inconsistent/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containerlabelkeyinconsistent] RHCOP-OCP_BESTPRACT-00006: Deployment/nonestandardlabel"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerlabelkeyinconsistent] RHCOP-OCP_BESTPRACT-00006: DeploymentConfig/nonestandardlabel"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_liveness_readinessprobe_equal" {
  tmp=$(split_files "policy/ocp/bestpractices/container_liveness_readinessprobe_equal/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containerlivenessreadinessprobeequal] RHCOP-OCP_BESTPRACT-00007: Deployment/probssetaresame"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerlivenessreadinessprobeequal] RHCOP-OCP_BESTPRACT-00007: DeploymentConfig/probssetaresame"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_livenessprobe_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container_livenessprobe_notset/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containerlivenessprobenotset] RHCOP-OCP_BESTPRACT-00008: Deployment/noproblivenessset"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerlivenessprobenotset] RHCOP-OCP_BESTPRACT-00008: DeploymentConfig/noproblivenessset"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_readinessprobe_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container_readinessprobe_notset/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containerreadinessprobenotset] RHCOP-OCP_BESTPRACT-00009: Deployment/noreadinessprob"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerreadinessprobenotset] RHCOP-OCP_BESTPRACT-00009: DeploymentConfig/noreadinessprob"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_resources_limits_cpu_set" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_limits_cpu_set/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containerresourceslimitscpuset] RHCOP-OCP_BESTPRACT-00010: Deployment/resourceslimitscpuset"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerresourceslimitscpuset] RHCOP-OCP_BESTPRACT-00010: DeploymentConfig/resourceslimitscpuset"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_resources_limits_memory_greater_than" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_limits_memory_greater_than/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containerresourceslimitsmemorygreaterthan] RHCOP-OCP_BESTPRACT-00011: Deployment/memorylimittoolarge"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerresourceslimitsmemorygreaterthan] RHCOP-OCP_BESTPRACT-00011: DeploymentConfig/memorylimittoolarge"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_resources_limits_memory_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_limits_memory_notset/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containerresourceslimitsmemorynotset] RHCOP-OCP_BESTPRACT-00012: Deployment/resourcelimitsmemorynotset"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerresourceslimitsmemorynotset] RHCOP-OCP_BESTPRACT-00012: DeploymentConfig/resourcelimitsmemorynotset"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_resources_memoryunit_incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_memoryunit_incorrect/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[3]}" == *"denied the request: [containerresourcesmemoryunitincorrect] RHCOP-OCP_BESTPRACT-00013: Deployment/invalidresourcesrequestsmemoryunits"* ]]
  [[ "${lines[4]}" == *"denied the request: [containerresourcesmemoryunitincorrect] RHCOP-OCP_BESTPRACT-00013: Deployment/invalidresourceslimitsmemoryunits"* ]]
  [[ "${lines[5]}" == *"denied the request: [containerresourcesmemoryunitincorrect] RHCOP-OCP_BESTPRACT-00013: DeploymentConfig/invalidresourcesrequestsmemoryunits"* ]]
  [[ "${lines[6]}" == *"denied the request: [containerresourcesmemoryunitincorrect] RHCOP-OCP_BESTPRACT-00013: DeploymentConfig/invalidresourceslimitsmemoryunits"* ]]
  [[ "${#lines[@]}" -eq 7 ]]
}

@test "policy/ocp/bestpractices/container_resources_requests_cpuunit_incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_requests_cpuunit_incorrect/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containerresourcesrequestscpuunitincorrect] RHCOP-OCP_BESTPRACT-00014: Deployment/invalidresourcesrequestcpuunits"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerresourcesrequestscpuunitincorrect] RHCOP-OCP_BESTPRACT-00014: DeploymentConfig/invalidresourcesrequestcpuunits"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_resources_requests_memory_greater_than" {
  tmp=$(split_files "policy/ocp/bestpractices/container_resources_requests_memory_greater_than/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containerresourcesrequestsmemorygreaterthan] RHCOP-OCP_BESTPRACT-00015: Deployment/memoryrequesttoolarge"* ]]
  [[ "${lines[2]}" == *"denied the request: [containerresourcesrequestsmemorygreaterthan] RHCOP-OCP_BESTPRACT-00015: DeploymentConfig/memoryrequesttoolarge"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_secret_mounted_envs" {
  tmp=$(split_files "policy/ocp/bestpractices/container_secret_mounted_envs/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containersecretmountedenvs] RHCOP-OCP_BESTPRACT-00016: Deployment/secretenvvars"* ]]
  [[ "${lines[2]}" == *"denied the request: [containersecretmountedenvs] RHCOP-OCP_BESTPRACT-00016: DeploymentConfig/secretenvvars"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_volumemount_inconsistent_path" {
  tmp=$(split_files "policy/ocp/bestpractices/container_volumemount_inconsistent_path/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containervolumemountinconsistentpath] RHCOP-OCP_BESTPRACT-00017: Deployment/notvarrunvolumemountspath"* ]]
  [[ "${lines[2]}" == *"denied the request: [containervolumemountinconsistentpath] RHCOP-OCP_BESTPRACT-00017: DeploymentConfig/notvarrunvolumemountspath"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container_volumemount_missing" {
  tmp=$(split_files "policy/ocp/bestpractices/container_volumemount_missing/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [containervolumemountmissing] RHCOP-OCP_BESTPRACT-00018: Deployment/missingvolumemount"* ]]
  [[ "${lines[2]}" == *"denied the request: [containervolumemountmissing] RHCOP-OCP_BESTPRACT-00018: DeploymentConfig/missingvolumemount"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/deploymentconfig_triggers_containername" {
  tmp=$(split_files "policy/ocp/bestpractices/deploymentconfig_triggers_containername/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [deploymentconfigtriggerscontainername] RHCOP-OCP_BESTPRACT-00027: DeploymentConfig/deploymentconfigtriggerscontainername"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/pod_hostnetwork" {
  tmp=$(split_files "policy/ocp/bestpractices/pod_hostnetwork/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[2]}" == *"denied the request: [podhostnetwork] RHCOP-OCP_BESTPRACT-00020: Deployment/hostnetworkisset"* ]]
  [[ "${lines[3]}" == *"denied the request: [podhostnetwork] RHCOP-OCP_BESTPRACT-00020: DeploymentConfig/hostnetworkisset"* ]]
  [[ "${#lines[@]}" -eq 4 ]]
}

@test "policy/ocp/bestpractices/pod_replicas_below_one" {
  tmp=$(split_files "policy/ocp/bestpractices/pod_replicas_below_one/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [podreplicasbelowone] RHCOP-OCP_BESTPRACT-00021: Deployment/replicaisone"* ]]
  [[ "${lines[2]}" == *"denied the request: [podreplicasbelowone] RHCOP-OCP_BESTPRACT-00021: DeploymentConfig/replicaisone"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/pod_replicas_not_odd" {
  tmp=$(split_files "policy/ocp/bestpractices/pod_replicas_not_odd/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[1]}" == *"denied the request: [podreplicasnotodd] RHCOP-OCP_BESTPRACT-00022: Deployment/replicaiseven"* ]]
  [[ "${lines[2]}" == *"denied the request: [podreplicasnotodd] RHCOP-OCP_BESTPRACT-00022: DeploymentConfig/replicaiseven"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/route_tls_termination_notset" {
  tmp=$(split_files "policy/ocp/bestpractices/route_tls_termination_notset/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [routetlsterminationnotset] RHCOP-OCP_BESTPRACT-00025: Route/tlsterminationnotset"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

####################
# ocp/bestpractices - with disabled policy label on project
####################

@test "policy/ocp/bestpractices/_all-namespaces - disabled policy label" {
  alltmp=$(split_files "policy/ocp/bestpractices/_all-namespaces/test_data/integration")

  cmd="oc create -f ${alltmp} -n ${project_name_disabled}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${alltmp}"
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/common_k8s_labels_notset - disabled policy label" {
  tmp=$(split_files "policy/ocp/bestpractices/common_k8s_labels_notset/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name_disabled}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  [[ "${lines[0]}" == "deployment.apps/nolabels created" ]]
  [[ "${lines[2]}" == "deploymentconfig.apps.openshift.io/nolabels created" ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

####################
# ocp/requiresinventory
####################

@test "policy/ocp/requiresinventory/deployment_has_matching_poddisruptionbudget" {
  tmp=$(split_files "policy/ocp/requiresinventory/deployment_has_matching_poddisruptionbudget/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]

  [[ "${lines[0]}" == *"denied the request: [deploymenthasmatchingpoddisruptionbudget] RHCOP-OCP_REQ_INV-00001: Deployment/hasmissingpdb"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/requiresinventory/deployment_has_matching_pvc" {
  tmp=$(split_files "policy/ocp/requiresinventory/deployment_has_matching_pvc/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [deploymenthasmatchingpvc] RHCOP-OCP_REQ_INV-00002: Deployment/hasmissingpvc"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/requiresinventory/deployment_has_matching_service" {
  tmp=$(split_files "policy/ocp/requiresinventory/deployment_has_matching_service/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [deploymenthasmatchingservice] RHCOP-OCP_REQ_INV-00003: Deployment/hasmissingsvc"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/requiresinventory/deployment_has_matching_serviceaccount" {
  tmp=$(split_files "policy/ocp/requiresinventory/deployment_has_matching_serviceaccount/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [deploymenthasmatchingserviceaccount] RHCOP-OCP_REQ_INV-00004: Deployment/hasmissingsvcaccount"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/requiresinventory/service_has_matching_servicemonitor" {
  tmp=$(split_files "policy/ocp/requiresinventory/service_has_matching_servicemonitor/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == *"denied the request: [servicehasmatchingservicemonitor] RHCOP-OCP_REQ_INV-00005: Service/hasmissingsvcmon"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}
