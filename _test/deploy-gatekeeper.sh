#!/usr/bin/env bash

command -v oc &> /dev/null || { echo >&2 'ERROR: oc not installed - Aborting'; exit 1; }
command -v konstraint &> /dev/null || { echo >&2 'ERROR: konstraint not installed - Aborting'; exit 1; }

gatekeeper_version="v3.1.0-rc.1"

cleanup_gatekeeper_constraints() {
  echo ""
  echo "Deleting all ConstraintTemplates..."
  oc delete constrainttemplate.templates.gatekeeper.sh --all --ignore-not-found=true

  find policy/* \( -name "template.yaml" -o -name "constraint.yaml" \) -type f -exec rm -f {} \;
}

cleanup_gatekeeper() {
  echo ""
  echo "Cleaning up previous gatekeeper installation..."
  oc delete config.config.gatekeeper.sh -n gatekeeper-system --all --ignore-not-found=true
  oc delete -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/${gatekeeper_version}/deploy/gatekeeper.yaml --ignore-not-found=true
  oc delete -f gatekeeper/gatekeeper-template-manager.yml --ignore-not-found=true
}

deploy_gatekeeper() {
  echo ""
  echo "Patching control-plane related namespaces so that OPA ignores them..."
  for namespace in $(oc get namespaces -o jsonpath='{.items[*].metadata.name}' | xargs); do
    if [[ "${namespace}" =~ openshift.* ]] || [[ "${namespace}" =~ kube.* ]] || [[ "${namespace}" =~ default ]]; then
      oc patch namespace/${namespace} -p='{"metadata":{"labels":{"admission.gatekeeper.sh/ignore":"true"}}}'
    else
      # Probably a users project, so leave it alone
      echo "Skipping: ${namespace}"
    fi
  done

  echo ""
  echo "Deploying gatekeeper..."
  oc create -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/${gatekeeper_version}/deploy/gatekeeper.yaml

  echo ""
  echo "Patching gatekeeper to work on OCP..."
  oc create clusterrole allow-anyuid-scc --verb=use --resource=securitycontextconstraints.security.openshift.io --resource-name=anyuid
  oc create rolebinding gatekeeper-anyuid-scc --serviceaccount=gatekeeper-system:gatekeeper-admin --clusterrole=allow-anyuid-scc -n gatekeeper-system

  oc patch Deployment/gatekeeper-audit --type json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/container.seccomp.security.alpha.kubernetes.io~1manager"}]' -n gatekeeper-system
  oc patch Deployment/gatekeeper-controller-manager --type json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/container.seccomp.security.alpha.kubernetes.io~1manager"}]' -n gatekeeper-system

  echo ""
  echo "Waiting for gatekeeper to be ready..."
  oc rollout status Deployment/gatekeeper-audit -n gatekeeper-system --watch=true
  oc rollout status Deployment/gatekeeper-controller-manager -n gatekeeper-system --watch=true

  oc create -f gatekeeper/config.yml -n gatekeeper-system
  oc create -f gatekeeper/gatekeeper-template-manager.yml
}

patch_namespaceselector_for_webhook() {
  echo ""
  echo "Patching ValidatingWebhookConfiguration/gatekeeper-validating-webhook-configuration to only watch namespaces with: 'redhat-cop.github.com/gatekeeper-active == true'..."
  oc patch ValidatingWebhookConfiguration/gatekeeper-validating-webhook-configuration -p='{"webhooks":[{"name":"validation.gatekeeper.sh","namespaceSelector":{"matchExpressions":[{"key":"redhat-cop.github.com/gatekeeper-active","operator":"In","values":["true"]}]}}]}'

  echo ""
  echo "Restarting Gatekeeper and waiting for it to be ready..."
  oc delete pods --all -n gatekeeper-system
  oc rollout status Deployment/gatekeeper-audit -n gatekeeper-system --watch=true
  oc rollout status Deployment/gatekeeper-controller-manager -n gatekeeper-system --watch=true
}

generate_constraints() {
  echo "Creating ConstraintTemplates via konstraint..."
  konstraint doc -o POLICIES.md
  konstraint create

  # shellcheck disable=SC2038
  for file in $(find policy/* \( -name "template.yaml" -o -name "constraint.yaml" \) -type f | xargs); do
    if [[ "${file}" == *"/combine/"* ]]; then
      # the data is 'off-cluster' so cant be tested against gatekeeper
      rm -f "${file}"
    elif [[ "${file}" == *"/ocp/deprecated/"* ]]; then
      # tests cant be deployed to a 4.x cluster so cant be tested against gatekeeper
      rm -f "${file}"
    elif [[ "${file}" == *"/ocp/bestpractices/deploymentconfig-triggers-notset/"* ]]; then
      # OCP API-Server adds a default ConfigChange trigger by default so cant be tested against gatekeeper
      rm -f "${file}"
    elif [[ "${file}" == *"/ocp/bestpractices/rolebinding-roleref-apigroup-notset/"* ]]; then
      # OCP API-Server does not accept data matching this criteria but they are good for conftest when people are moving from 3.11 to 4.x
      rm -f "${file}"
    elif [[ "${file}" == *"/ocp/bestpractices/rolebinding-roleref-kind-notset/"* ]]; then
      # OCP API-Server does not accept data matching this criteria but they are good for conftest when people are moving from 3.11 to 4.x
      rm -f "${file}"
    elif [[ "${file}" == *"/podman/"* ]]; then
      # the data is 'off-cluster' so cant be tested against gatekeeper
      rm -f "${file}"
    fi
  done
}

deploy_constraints() {
  echo ""
  echo "Deploying Constraints..."

  # shellcheck disable=SC2038
  for file in $(find policy/* \( -name "template.yaml" -o -name "constraint.yaml" \) -type f | xargs); do
    name=$(oc create -f "${file}" -n gatekeeper-system -o name || exit $?)
    echo "${name}"

    until oc get ${name} -o json | jq ".status.byPod | length" | grep -q "4";
    do
      echo "Waiting for: .status.byPod | length == 4"
      sleep 5s
    done

    until [[ -z $(oc get ${name} -o json | jq "select(.status.byPod[].errors != null)") ]];
    do
      echo "Waiting for: .status.byPod[].errors == ''"
      sleep 5s
    done

    echo ""
  done
}

# Process arguments
case $1 in
  deploy_gatekeeper)
    cleanup_gatekeeper_constraints
    cleanup_gatekeeper
    deploy_gatekeeper
    ;;
  patch_namespaceselector)
    patch_namespaceselector_for_webhook
    ;;
  deploy_constraints)
    cleanup_gatekeeper_constraints
    generate_constraints
    deploy_constraints
    ;;
  *)
    echo "Not an option"
    exit 1
esac