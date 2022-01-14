remove_ocp_resources() {
  yq --yml-output --in-place 'select(.apiVersion | contains("openshift.io") | not)' "${1}"
  yq --yml-output --in-place 'select(.apiVersion | contains("coreos.com") | not)' "${1}"
}

_setup_file() {
  project_name=$1
  project_name_disabled=$2
  remove_ocp=$3

  rm -rf /tmp/rhcop

  oc process --local=true -f _test/resources/namespace-under-test.yml -p=PROJECT_NAME=${project_name} | oc create -f -
  oc process --local=true -f _test/resources/namespace-under-test.yml -p=PROJECT_NAME=${project_name_disabled} -p=DISABLED="RHCOP-OCP_BESTPRACT-00001" | oc create -f -

  bestpractices=$(split_files "_test/resources/prerequisite-bestpractices.yml")
  requiresinventory=$(split_files "_test/resources/prerequisite-requiresinventory.yml")

  if [[ -n "${remove_ocp}" ]]; then
    remove_ocp_resources "${bestpractices}/prerequisite-bestpractices.yml"
    remove_ocp_resources "${requiresinventory}/prerequisite-requiresinventory.yml"
  fi

  oc create -n ${project_name} -f "${bestpractices}/prerequisite-bestpractices.yml"
  oc create -n ${project_name} -f "${requiresinventory}/prerequisite-requiresinventory.yml"

  oc create -n ${project_name_disabled} -f "${bestpractices}/prerequisite-bestpractices.yml"
  oc create -n ${project_name_disabled} -f "${requiresinventory}/prerequisite-requiresinventory.yml"

  oc patch namespace/${project_name} --type='json' -p='[{"op": "add", "path": "/metadata/labels/redhat-cop.github.com~1gatekeeper-active", "value":"true"}]'
  oc patch namespace/${project_name_disabled} --type='json' -p='[{"op": "add", "path": "/metadata/labels/redhat-cop.github.com~1gatekeeper-active", "value":"true"}]'
}

_teardown_file() {
  project_name=$1
  project_name_disabled=$2

  if [[ -n ${project_name} ]]; then
    oc delete namespace/${project_name}
    oc delete namespace/${project_name_disabled}
  fi
}

_teardown() {
  tmp=$1

  if [[ -n "${tmp}" ]]; then
    oc delete -f "${tmp}" --ignore-not-found=true --wait=true > /dev/null 2>&1
  fi
}
