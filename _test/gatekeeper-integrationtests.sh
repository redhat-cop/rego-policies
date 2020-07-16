#!/usr/bin/env bats

load bats-support-clone
load test_helper/bats-support/load
load test_helper/redhatcop-bats-library/load

####################
# all-namespaces
####################

@test "_test/all-namespaces/ocp/bestpractices" {
  tmp=$(split_files "_test/all-namespaces/ocp/bestpractices")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  #Cleanup afterwards
  oc delete -f "${tmp}" --ignore-not-found=true --wait=true
}

####################
# combine
####################

## TODO ##

####################
# ocp/bestpractices
####################

@test "policy/ocp/bestpractices/common-k8s-labels-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/common-k8s-labels-notset/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by commonk8slabelsnotset] Deployment/nolabels"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by commonk8slabelsnotset] DeploymentConfig/nolabels"* ]]
  [[ "${lines[2]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-env-maxmemory-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-env-maxmemory-notset/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}
  
  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerenvmaxmemorynotset] Deployment/nodownwardmemoryenv"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containerenvmaxmemorynotset] DeploymentConfig/nodownwardmemoryenv"* ]]
  [[ "${lines[4]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-image-latest" {
  tmp=$(split_files "policy/ocp/bestpractices/container-image-latest/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerimagelatest] Deployment/imageuseslatesttag"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containerimagelatest] DeploymentConfig/imageuseslatesttag"* ]]
  [[ "${lines[4]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-java-xmx-set" {
  tmp=$(split_files "policy/ocp/bestpractices/container-java-xmx-set/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerjavaxmxset] Deployment/xmxviacommand"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containerjavaxmxset] Deployment/xmxviaargs"* ]]
  [[ "${lines[6]}" == "Error from server ([denied by containerjavaxmxset] Deployment/xmxviaenv"* ]]
  [[ "${lines[9]}" == "Error from server ([denied by containerjavaxmxset] DeploymentConfig/xmxviacommand"* ]]
  [[ "${lines[10]}" == "Error from server ([denied by containerjavaxmxset] DeploymentConfig/xmxviaargs"* ]]
  [[ "${lines[11]}" == "Error from server ([denied by containerjavaxmxset] DeploymentConfig/xmxviaenv"* ]]
  [[ "${lines[12]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-labelkey-inconsistent" {
  tmp=$(split_files "policy/ocp/bestpractices/container-labelkey-inconsistent/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerlabelkeyinconsistent] Deployment/nonestandardlabel"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerlabelkeyinconsistent] DeploymentConfig/nonestandardlabel"* ]]
  [[ "${lines[2]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-liveness-readinessprobe-equal" {
  tmp=$(split_files "policy/ocp/bestpractices/container-liveness-readinessprobe-equal/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerlivenessreadinessprobeequal] Deployment/probssetaresame"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containerlivenessreadinessprobeequal] DeploymentConfig/probssetaresame"* ]]
  [[ "${lines[4]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-livenessprobe-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-livenessprobe-notset/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerlivenessprobenotset] Deployment/noproblivenessset"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containerlivenessprobenotset] DeploymentConfig/noproblivenessset"* ]]
  [[ "${lines[4]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-readinessprobe-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-readinessprobe-notset/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerreadinessprobenotset] Deployment/noreadinessprob"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containerreadinessprobenotset] DeploymentConfig/noreadinessprob"* ]]
  [[ "${lines[4]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-resources-limits-cpu-set" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-cpu-set/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourceslimitscpuset] Deployment/resourceslimitscpuset"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containerresourceslimitscpuset] DeploymentConfig/resourceslimitscpuset"* ]]
  [[ "${lines[4]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-resources-limits-memory-greater-than" {
  skip
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-memory-greater-than/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourceslimitsmemorygreaterthan] Deployment/memorylimittoolarge"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containerresourceslimitsmemorygreaterthan] DeploymentConfig/memorylimittoolarge"* ]]
  [[ "${lines[4]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-resources-limits-memory-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-memory-notset/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourceslimitsmemorynotset] Deployment/resourcelimitsmemorynotset"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containerresourceslimitsmemorynotset] DeploymentConfig/resourcelimitsmemorynotset"* ]]
  [[ "${lines[4]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-resources-memoryunit-incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-memoryunit-incorrect/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourcesmemoryunitincorrect] Deployment/invalidresourcesrequestsmemoryunits"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containerresourcesmemoryunitincorrect] Deployment/invalidresourceslimitsmemoryunits"* ]]
  [[ "${lines[6]}" == "Error from server ([denied by containerresourcesmemoryunitincorrect] DeploymentConfig/invalidresourcesrequestsmemoryunits"* ]]
  [[ "${lines[7]}" == "Error from server ([denied by containerresourcesmemoryunitincorrect] DeploymentConfig/invalidresourceslimitsmemoryunits"* ]]
  [[ "${lines[8]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-resources-requests-cpuunit-incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-requests-cpuunit-incorrect/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourcesrequestscpuunitincorrect] Deployment/invalidresourcesrequestcpuunits"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containerresourcesrequestscpuunitincorrect] DeploymentConfig/invalidresourcesrequestcpuunits"* ]]
  [[ "${lines[4]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-resources-requests-memory-greater-than" {
  skip
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-requests-memory-greater-than/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourcesrequestsmemorygreaterthan] Deployment/memoryrequesttoolarge"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerresourcesrequestsmemorygreaterthan] DeploymentConfig/memoryrequesttoolarge"* ]]
  [[ "${lines[2]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-secret-mounted-envs" {
  tmp=$(split_files "policy/ocp/bestpractices/container-secret-mounted-envs/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containersecretmountedenvs] Deployment/secretenvvars"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containersecretmountedenvs] DeploymentConfig/secretenvvars"* ]]
  [[ "${lines[4]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-volumemount-inconsistent-path" {
  tmp=$(split_files "policy/ocp/bestpractices/container-volumemount-inconsistent-path/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containervolumemountinconsistentpath] Deployment/notvarrunvolumemountspath"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containervolumemountinconsistentpath] DeploymentConfig/notvarrunvolumemountspath"* ]]
  [[ "${lines[4]}" = "" ]]
}

@test "policy/ocp/bestpractices/container-volumemount-missing" {
  tmp=$(split_files "policy/ocp/bestpractices/container-volumemount-missing/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containervolumemountmissing] Deployment/missingvolumemount"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containervolumemountmissing] DeploymentConfig/missingvolumemount"* ]]
  [[ "${lines[2]}" = "" ]]
}

@test "policy/ocp/bestpractices/pod-hostnetwork" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-hostnetwork/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by podhostnetwork] Deployment/hostnetworkisset"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by podhostnetwork] DeploymentConfig/hostnetworkisset"* ]]
  [[ "${lines[2]}" = "" ]]
}

@test "policy/ocp/bestpractices/pod-replicas-below-one" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-replicas-below-one/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by podreplicasbelowone] Deployment/replicaisone"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by podreplicasbelowone] DeploymentConfig/replicaisone"* ]]
  [[ "${lines[2]}" = "" ]]
}

@test "policy/ocp/bestpractices/pod-replicas-not-odd" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-replicas-not-odd/test_data/integration")

  cmd="oc create -f ${tmp}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by podreplicasnotodd] Deployment/replicaiseven"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by podreplicasnotodd] DeploymentConfig/replicaiseven"* ]]
  [[ "${lines[2]}" = "" ]]
}