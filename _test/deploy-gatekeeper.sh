#!/usr/bin/env bash

deploy_gatekeeper() {
  echo ""
  echo "Deploying gatekeeper..."
  oc delete constrainttemplate.templates.gatekeeper.sh --all --ignore-not-found=true
  oc delete -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/v3.1.0-beta.10/deploy/gatekeeper.yaml --ignore-not-found=true
  oc create -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/v3.1.0-beta.10/deploy/gatekeeper.yaml

  echo ""
  echo "Patching gatekeeper to work on OCP..."
  oc adm policy add-scc-to-user anyuid system:serviceaccount:gatekeeper-system:gatekeeper-admin
  oc patch Deployment/gatekeeper-controller-manager --type json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations"}]' -n gatekeeper-system

  echo ""
  echo "Waiting for gatekeeper to be ready..."
  oc rollout status Deployment/gatekeeper-audit -n gatekeeper-system --watch=true
  oc rollout status Deployment/gatekeeper-controller-manager -n gatekeeper-system --watch=true
}

generate_constraints() {
  echo "Creating ConstraintTemplates via konstraint..."
  konstraint doc -o POLICIES.md

  # Ignores explained:
  # - podman: the data is 'off-cluster' so cant be tested against gatekeeper
  # - ocp/deprecated: tests cant be deployed to a 4.x cluster so cant be tested against gatekeeper
  # - ocp/bestpractices/deploymentconfig-triggers-notset: OCP API-Server adds a default ConfigChange trigger by default so cant be tested against gatekeeper
  # - ocp/bestpractices/rolebinding-roleref-apigroup-notset: OCP API-Server does not accept data matching this criteria but they are good for conftest when people are moving from 3.11 to 4.x
  # - ocp/bestpractices/rolebinding-roleref-kind-notset: OCP API-Server does not accept data matching this criteria but they are good for conftest when people are moving from 3.11 to 4.x
  # TODO LIST
  # - ocp/bestpractices/container-resources-limits-memory-greater-than: TODO: https://github.com/redhat-cop/rego-policies/issues/76
  # - ocp/bestpractices/container-resources-requests-memory-greater-than: TODO: https://github.com/redhat-cop/rego-policies/issues/76
  # - combine: TODO: https://github.com/redhat-cop/rego-policies/issues/70
  konstraint create --ignore "(podman|ocp\/deprecated|ocp\/bestpractices\/deploymentconfig-triggers-notset|ocp\/bestpractices\/rolebinding-roleref-apigroup-notset|ocp\/bestpractices\/rolebinding-roleref-kind-notset|ocp\/bestpractices\/container-resources-limits-memory-greater-than|ocp\/bestpractices\/container-resources-requests-memory-greater-than|combine)"
}

deploy_constraints() {
  echo ""
  echo "Deploying ConstraintTemplates..."

  for file in $(find policy/* -name "template.yaml" -type f | xargs); do
    oc create -f "${file}" -o jsonpath="{.metadata.name}" || exit $?

    local name="$(yq -r '.metadata.name' "${file}")"
    echo ""

    until oc get constrainttemplate/${name} -o json | jq ".status.created" | grep -q "true";
    do
      echo "Waiting for: .status.created == true"
      sleep 5s
    done

    until oc get constrainttemplate/${name} -o json | jq ".status.byPod | length" | grep -q "2";
    do
      echo "Waiting for: .status.byPod | length == 2"
      sleep 5s
    done

    until [[ -z $(oc get constrainttemplate/${name} -o json | jq "select(.status.byPod[].errors != null)") ]];
    do
      echo "Waiting for: .status.byPod[].errors == ''"
      sleep 5s
    done

    echo ""
  done

  echo "Deploying Constraints..."

  for file in $(find policy/* -name "constraint.yaml" -type f | xargs); do
    oc create -n gatekeeper-system -f "${file}" || exit $?
  done
}

command -v oc &> /dev/null || { echo >&2 'ERROR: oc not installed - Aborting'; exit 1; }
command -v konstraint &> /dev/null || { echo >&2 'ERROR: konstraint not installed - Aborting'; exit 1; }

deploy_gatekeeper
generate_constraints
deploy_constraints