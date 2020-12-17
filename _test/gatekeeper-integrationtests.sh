#!/usr/bin/env bats

load bats-support-clone
load test_helper/bats-support/load
load test_helper/redhatcop-bats-library/load

setup_file() {
  export project_name="regopolicies-undertest-$(date +'%d%m%Y-%H%M%S')"

  rm -rf /tmp/rhcop
  oc process -f _test/namespace-under-test.yml -p=PROJECT_NAME=${project_name} | oc create -f -
}

teardown_file() {
  oc delete project/${project_name}
}

teardown() {
  if [[ -n "${tmp}" ]]; then
    oc delete -f "${tmp}" --ignore-not-found=true --wait=true > /dev/null 2>&1
  fi
}

####################
# all-namespaces
# NOTE: This test should always be first, as it contains YAML to stop the 'data.inventory' policies firing when they shouldnt
####################

@test "_test/all-namespaces/ocp/bestpractices" {
  alltmp=$(split_files "_test/all-namespaces/ocp/bestpractices")

  cmd="oc create -f ${alltmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${alltmp}"
  [ "$status" -eq 0 ]
}

####################
# ocp/bestpractices
####################

@test "policy/ocp/bestpractices/common-k8s-labels-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/common-k8s-labels-notset/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by commonk8slabelsnotset] Deployment/nolabels"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by commonk8slabelsnotset] DeploymentConfig/nolabels"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-env-maxmemory-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-env-maxmemory-notset/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}
  
  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerenvmaxmemorynotset] Deployment/nodownwardmemoryenv"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerenvmaxmemorynotset] DeploymentConfig/nodownwardmemoryenv"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-image-latest" {
  tmp=$(split_files "policy/ocp/bestpractices/container-image-latest/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerimagelatest] Deployment/imageuseslatesttag"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerimagelatest] DeploymentConfig/imageuseslatesttag"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-image-unknownregistries" {
  tmp=$(split_files "policy/ocp/bestpractices/container-image-unknownregistries/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerimageunknownregistries] Deployment/imagefromunknownregistry"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerimageunknownregistries] DeploymentConfig/imagefromunknownregistry"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-java-xmx-set" {
  tmp=$(split_files "policy/ocp/bestpractices/container-java-xmx-set/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerjavaxmxset] Deployment/xmxviacommand"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerjavaxmxset] Deployment/xmxviaargs"* ]]
  [[ "${lines[2]}" == "Error from server ([denied by containerjavaxmxset] Deployment/xmxviaenv"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containerjavaxmxset] DeploymentConfig/xmxviacommand"* ]]
  [[ "${lines[4]}" == "Error from server ([denied by containerjavaxmxset] DeploymentConfig/xmxviaargs"* ]]
  [[ "${lines[5]}" == "Error from server ([denied by containerjavaxmxset] DeploymentConfig/xmxviaenv"* ]]
  [[ "${#lines[@]}" -eq 6 ]]
}

@test "policy/ocp/bestpractices/container-labelkey-inconsistent" {
  tmp=$(split_files "policy/ocp/bestpractices/container-labelkey-inconsistent/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerlabelkeyinconsistent] Deployment/nonestandardlabel"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerlabelkeyinconsistent] DeploymentConfig/nonestandardlabel"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-liveness-readinessprobe-equal" {
  tmp=$(split_files "policy/ocp/bestpractices/container-liveness-readinessprobe-equal/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerlivenessreadinessprobeequal] Deployment/probssetaresame"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerlivenessreadinessprobeequal] DeploymentConfig/probssetaresame"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-livenessprobe-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-livenessprobe-notset/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerlivenessprobenotset] Deployment/noproblivenessset"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerlivenessprobenotset] DeploymentConfig/noproblivenessset"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-readinessprobe-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-readinessprobe-notset/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerreadinessprobenotset] Deployment/noreadinessprob"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerreadinessprobenotset] DeploymentConfig/noreadinessprob"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-resources-limits-cpu-set" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-cpu-set/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourceslimitscpuset] Deployment/resourceslimitscpuset"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerresourceslimitscpuset] DeploymentConfig/resourceslimitscpuset"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-resources-limits-memory-greater-than" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-memory-greater-than/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourceslimitsmemorygreaterthan] Deployment/memorylimittoolarge"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerresourceslimitsmemorygreaterthan] DeploymentConfig/memorylimittoolarge"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-resources-limits-memory-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-memory-notset/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourceslimitsmemorynotset] Deployment/resourcelimitsmemorynotset"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerresourceslimitsmemorynotset] DeploymentConfig/resourcelimitsmemorynotset"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-resources-memoryunit-incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-memoryunit-incorrect/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourcesmemoryunitincorrect] Deployment/invalidresourcesrequestsmemoryunits"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerresourcesmemoryunitincorrect] Deployment/invalidresourceslimitsmemoryunits"* ]]
  [[ "${lines[2]}" == "Error from server ([denied by containerresourcesmemoryunitincorrect] DeploymentConfig/invalidresourcesrequestsmemoryunits"* ]]
  [[ "${lines[3]}" == "Error from server ([denied by containerresourcesmemoryunitincorrect] DeploymentConfig/invalidresourceslimitsmemoryunits"* ]]
  [[ "${#lines[@]}" -eq 4 ]]
}

@test "policy/ocp/bestpractices/container-resources-requests-cpuunit-incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-requests-cpuunit-incorrect/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourcesrequestscpuunitincorrect] Deployment/invalidresourcesrequestcpuunits"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerresourcesrequestscpuunitincorrect] DeploymentConfig/invalidresourcesrequestcpuunits"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-resources-requests-memory-greater-than" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-requests-memory-greater-than/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourcesrequestsmemorygreaterthan] Deployment/memoryrequesttoolarge"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerresourcesrequestsmemorygreaterthan] DeploymentConfig/memoryrequesttoolarge"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-secret-mounted-envs" {
  tmp=$(split_files "policy/ocp/bestpractices/container-secret-mounted-envs/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containersecretmountedenvs] Deployment/secretenvvars"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containersecretmountedenvs] DeploymentConfig/secretenvvars"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-volumemount-inconsistent-path" {
  tmp=$(split_files "policy/ocp/bestpractices/container-volumemount-inconsistent-path/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containervolumemountinconsistentpath] Deployment/notvarrunvolumemountspath"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containervolumemountinconsistentpath] DeploymentConfig/notvarrunvolumemountspath"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-volumemount-missing" {
  tmp=$(split_files "policy/ocp/bestpractices/container-volumemount-missing/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containervolumemountmissing] Deployment/missingvolumemount"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containervolumemountmissing] DeploymentConfig/missingvolumemount"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/pod-hostnetwork" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-hostnetwork/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by podhostnetwork] Deployment/hostnetworkisset"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by podhostnetwork] DeploymentConfig/hostnetworkisset"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/pod-replicas-below-one" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-replicas-below-one/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by podreplicasbelowone] Deployment/replicaisone"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by podreplicasbelowone] DeploymentConfig/replicaisone"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/pod-replicas-not-odd" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-replicas-not-odd/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by podreplicasnotodd] Deployment/replicaiseven"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by podreplicasnotodd] DeploymentConfig/replicaiseven"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/route-tls-termination-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/route-tls-termination-notset/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by routetlsterminationnotset] Route/tlsterminationnotset"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}


####################
# ocp/requiresinventory
####################

@test "policy/ocp/requiresinventory/deployment-has-matching-poddisruptionbudget" {
  tmp=$(split_files "policy/ocp/requiresinventory/deployment-has-matching-poddisruptionbudget/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]

  [[ "${lines[0]}" == "servicemonitor.monitoring.coreos.com/shouldneverfire-pdb created" ]]
  [[ "${lines[1]}" == "service/shouldneverfire-pdb created" ]]
  [[ "${lines[2]}" == "Error from server ([denied by deploymenthasmatchingpoddisruptionbudget] Deployment/hasmissingpdb"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/requiresinventory/deployment-has-matching-pvc" {
  tmp=$(split_files "policy/ocp/requiresinventory/deployment-has-matching-pvc/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by deploymenthasmatchingpvc] Deployment/hasmissingpvc"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/requiresinventory/deployment-has-matching-service" {
  tmp=$(split_files "policy/ocp/requiresinventory/deployment-has-matching-service/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "poddisruptionbudget.policy/shouldneverfire-svc created" ]]
  [[ "${lines[1]}" == "Error from server ([denied by deploymenthasmatchingservice] Deployment/hasmissingsvc"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/requiresinventory/deployment-has-matching-serviceaccount" {
  tmp=$(split_files "policy/ocp/requiresinventory/deployment-has-matching-serviceaccount/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by deploymenthasmatchingserviceaccount] Deployment/hasmissingsvcaccount"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/requiresinventory/service-has-matching-servicemonitor" {
  tmp=$(split_files "policy/ocp/requiresinventory/service-has-matching-servicemonitor/test_data/integration")

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by servicehasmatchingservicemonitor] Service/hasmissingsvcmon"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}