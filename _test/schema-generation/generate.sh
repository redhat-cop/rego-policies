download_remote_schema() {
  # See: https://github.com/instrumenta/openapi2jsonschema/issues/49
  curl -kL -H "Authorization: Bearer $(oc whoami -t)" $(oc whoami --show-server)/openapi/v2 | jq '.definitions[] |= if .["x-kubernetes-group-version-kind"] then . + {properties: (.properties // {})} else . end' > _test/schema-generation/openshift-openapi-spec.json
}

generate_all_schemas() {
  podman run -i -v ${PWD}:${PWD} -v "${PWD}/_test/schema-generation/openshift-json-schema:/out" ghcr.io/yannh/openapi2jsonschema:latest --expanded --kubernetes --stand-alone --strict "${PWD}/_test/schema-generation/openshift-openapi-spec.json"
}

generate_known_schemas() {
  declare -a files=(
    "buildconfig-build-v1.json"
    "container-v1.json"
    "deployment-apps-v1.json"
    "deploymentconfig-apps-v1.json"
    "imagestream-image-v1.json"
    "namespace-v1.json"
    "networkpolicy-networking-v1.json"
    "pod-v1.json"
    "resourcequota-v1.json"
    "rolebinding-rbac-v1.json"
    "route-route-v1.json"
    "securitycontextconstraints-security-v1.json"
    "service-v1.json"
  )

  for schema in "${files[@]}"; do
    cp _test/schema-generation/openshift-json-schema/schemas/${schema} _test/schema-generation/openshift-json-schema
  done
}

if [[ ! -f "_test/schema-generation/openshift-openapi-spec.json" ]]; then
  download_remote_schema
fi

# Process arguments
case $1 in
  generate_all_schemas)
    generate_all_schemas
    ;;
  generate_known_schemas)
    generate_known_schemas
    ;;
  *)
    echo "Not an option"
    exit 1
esac