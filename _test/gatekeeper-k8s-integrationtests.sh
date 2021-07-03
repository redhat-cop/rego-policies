#!/usr/bin/env bats

load bats-support-clone
load test_helper/bats-support/load
load test_helper/redhatcop-bats-library/load

setup_file() {
  export project_name="regopolicies-undertest-$(date +'%d%m%Y-%H%M%S')"
  export project_name_disabled="regopolicies-undertest-disabled-$(date +'%d%m%Y-%H%M%S')"

  rm -rf /tmp/rhcop
  oc process --local=true -f _test/resources/namespace-under-test.yml -p=PROJECT_NAME=${project_name} | oc create -f -
  oc process --local=true -f _test/resources/namespace-under-test.yml -p=PROJECT_NAME=${project_name_disabled} -p=DISABLED="RHCOP-OCP_BESTPRACT-00001" | oc create -f -

  bestpractices=$(split_files "_test/resources/prerequisite-bestpractices.yml")
  requiresinventory=$(split_files "_test/resources/prerequisite-requiresinventory.yml")

  remove_ocp_resources "${bestpractices}/prerequisite-bestpractices.yml"
  remove_ocp_resources "${requiresinventory}/prerequisite-requiresinventory.yml"

  oc create -n ${project_name} -f "${bestpractices}/prerequisite-bestpractices.yml"
  oc create -n ${project_name} -f "${requiresinventory}/prerequisite-requiresinventory.yml"

  oc create -n ${project_name_disabled} -f "${bestpractices}/prerequisite-bestpractices.yml"
  oc create -n ${project_name_disabled} -f "${requiresinventory}/prerequisite-requiresinventory.yml"

  oc patch namespace/${project_name} --type='json' -p='[{"op": "add", "path": "/metadata/labels/redhat-cop.github.com~1gatekeeper-active", "value":"true"}]'
  oc patch namespace/${project_name_disabled} --type='json' -p='[{"op": "add", "path": "/metadata/labels/redhat-cop.github.com~1gatekeeper-active", "value":"true"}]'
}

teardown_file() {
  oc delete namespace/${project_name}
  oc delete namespace/${project_name_disabled}
}

teardown() {
  if [[ -n "${tmp}" ]]; then
    oc delete -f "${tmp}" --ignore-not-found=true --wait=true > /dev/null 2>&1
  fi
}

remove_ocp_resources() {
  yq --yml-output --in-place 'select(.apiVersion | contains("openshift.io") | not)' "${1}"
  yq --yml-output --in-place 'select(.apiVersion | contains("coreos.com") | not)' "${1}"
}

####################
# all-namespaces
####################

@test "policy/ocp/bestpractices/_all-namespaces" {
  alltmp=$(split_files "policy/ocp/bestpractices/_all-namespaces/test_data/integration")
  remove_ocp_resources "${alltmp}/all.yml"

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
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by commonk8slabelsnotset] RHCOP-OCP_BESTPRACT-00001: Deployment/nolabels"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-env-maxmemory-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-env-maxmemory-notset/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}
  
  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerenvmaxmemorynotset] RHCOP-OCP_BESTPRACT-00002: Deployment/nodownwardmemoryenv"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-image-latest" {
  tmp=$(split_files "policy/ocp/bestpractices/container-image-latest/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerimagelatest] RHCOP-OCP_BESTPRACT-00003: Deployment/imageuseslatesttag"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-image-unknownregistries" {
  tmp=$(split_files "policy/ocp/bestpractices/container-image-unknownregistries/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerimageunknownregistries] RHCOP-OCP_BESTPRACT-00004: Deployment/imagefromunknownregistry"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-java-xmx-set" {
  tmp=$(split_files "policy/ocp/bestpractices/container-java-xmx-set/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerjavaxmxset] RHCOP-OCP_BESTPRACT-00005: Deployment/xmxviacommand"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerjavaxmxset] RHCOP-OCP_BESTPRACT-00005: Deployment/xmxviaargs"* ]]
  [[ "${lines[2]}" == "Error from server ([denied by containerjavaxmxset] RHCOP-OCP_BESTPRACT-00005: Deployment/xmxviaenv"* ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "policy/ocp/bestpractices/container-labelkey-inconsistent" {
  tmp=$(split_files "policy/ocp/bestpractices/container-labelkey-inconsistent/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerlabelkeyinconsistent] RHCOP-OCP_BESTPRACT-00006: Deployment/nonestandardlabel"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-liveness-readinessprobe-equal" {
  tmp=$(split_files "policy/ocp/bestpractices/container-liveness-readinessprobe-equal/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerlivenessreadinessprobeequal] RHCOP-OCP_BESTPRACT-00007: Deployment/probssetaresame"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-livenessprobe-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-livenessprobe-notset/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerlivenessprobenotset] RHCOP-OCP_BESTPRACT-00008: Deployment/noproblivenessset"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-readinessprobe-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-readinessprobe-notset/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerreadinessprobenotset] RHCOP-OCP_BESTPRACT-00009: Deployment/noreadinessprob"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-resources-limits-cpu-set" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-cpu-set/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourceslimitscpuset] RHCOP-OCP_BESTPRACT-00010: Deployment/resourceslimitscpuset"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-resources-limits-memory-greater-than" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-memory-greater-than/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourceslimitsmemorygreaterthan] RHCOP-OCP_BESTPRACT-00011: Deployment/memorylimittoolarge"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-resources-limits-memory-notset" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-limits-memory-notset/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourceslimitsmemorynotset] RHCOP-OCP_BESTPRACT-00012: Deployment/resourcelimitsmemorynotset"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-resources-memoryunit-incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-memoryunit-incorrect/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourcesmemoryunitincorrect] RHCOP-OCP_BESTPRACT-00013: Deployment/invalidresourcesrequestsmemoryunits"* ]]
  [[ "${lines[1]}" == "Error from server ([denied by containerresourcesmemoryunitincorrect] RHCOP-OCP_BESTPRACT-00013: Deployment/invalidresourceslimitsmemoryunits"* ]]
  [[ "${#lines[@]}" -eq 2 ]]
}

@test "policy/ocp/bestpractices/container-resources-requests-cpuunit-incorrect" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-requests-cpuunit-incorrect/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourcesrequestscpuunitincorrect] RHCOP-OCP_BESTPRACT-00014: Deployment/invalidresourcesrequestcpuunits"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-resources-requests-memory-greater-than" {
  tmp=$(split_files "policy/ocp/bestpractices/container-resources-requests-memory-greater-than/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containerresourcesrequestsmemorygreaterthan] RHCOP-OCP_BESTPRACT-00015: Deployment/memoryrequesttoolarge"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-secret-mounted-envs" {
  tmp=$(split_files "policy/ocp/bestpractices/container-secret-mounted-envs/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containersecretmountedenvs] RHCOP-OCP_BESTPRACT-00016: Deployment/secretenvvars"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-volumemount-inconsistent-path" {
  tmp=$(split_files "policy/ocp/bestpractices/container-volumemount-inconsistent-path/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containervolumemountinconsistentpath] RHCOP-OCP_BESTPRACT-00017: Deployment/notvarrunvolumemountspath"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/container-volumemount-missing" {
  tmp=$(split_files "policy/ocp/bestpractices/container-volumemount-missing/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by containervolumemountmissing] RHCOP-OCP_BESTPRACT-00018: Deployment/missingvolumemount"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/pod-hostnetwork" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-hostnetwork/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by podhostnetwork] RHCOP-OCP_BESTPRACT-00020: Deployment/hostnetworkisset"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/pod-replicas-below-one" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-replicas-below-one/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by podreplicasbelowone] RHCOP-OCP_BESTPRACT-00021: Deployment/replicaisone"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

@test "policy/ocp/bestpractices/pod-replicas-not-odd" {
  tmp=$(split_files "policy/ocp/bestpractices/pod-replicas-not-odd/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 1 ]
  [[ "${lines[0]}" == "Error from server ([denied by podreplicasnotodd] RHCOP-OCP_BESTPRACT-00022: Deployment/replicaiseven"* ]]
  [[ "${#lines[@]}" -eq 1 ]]
}

####################
# ocp/bestpractices - with disabled policy label on project
####################

@test "policy/ocp/bestpractices/_all-namespaces - disabled policy label" {
  alltmp=$(split_files "policy/ocp/bestpractices/_all-namespaces/test_data/integration")
  remove_ocp_resources "${alltmp}/all.yml"

  cmd="oc create -f ${alltmp} -n ${project_name_disabled}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${alltmp}"
  [ "$status" -eq 0 ]
}

@test "policy/ocp/bestpractices/common-k8s-labels-notset - disabled policy label" {
  tmp=$(split_files "policy/ocp/bestpractices/common-k8s-labels-notset/test_data/integration")
  remove_ocp_resources "${tmp}/list.yml"

  cmd="oc create -f ${tmp} -n ${project_name_disabled}"
  run ${cmd}

  print_info "${status}" "${output}" "${cmd}" "${tmp}"
  [ "$status" -eq 0 ]

  [[ "${lines[0]}" == "deployment.apps/nolabels created" ]]
  [[ "${#lines[@]}" -eq 1 ]]
}
