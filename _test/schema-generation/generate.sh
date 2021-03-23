clone_forked_openapi2jsonschema() {
  # See: https://github.com/instrumenta/openapi2jsonschema/issues/49
  rm -rf _test/openapi2jsonschema || exit 0
  git clone --depth 1 --single-branch https://github.com/garethahealy/openapi2jsonschema.git _test/schema-generation/openapi2jsonschema

  chmod +x _test/schema-generation/openapi2jsonschema/openapi2jsonschema/command.py
}

download_remote_schema() {
  curl -kL -H "Authorization: Bearer $(oc whoami -t)" $(oc whoami --show-server)/openapi/v2 > _test/schema-generation/openshift-openapi-spec.json
}

generate_all_schemas() {
  _test/schema-generation/openapi2jsonschema/openapi2jsonschema/command.py -o "_test/schema-generation/all-openshift-json-schema" --expanded --kubernetes --stand-alone --strict "_test/schema-generation/openshift-openapi-spec.json"
}

generate_known_schemas() {
  declare -a apiKinds=(
    "v1,namespace;"
    "v1,resourcequota;"
    "rbac/v1,rolebinding;"
    "networking/v1,networkpolicy;"
    "build/v1,buildconfig;"
    "image/v1,imagestream;"
    "v1,container;"
    "v1,pod;"
    "apps/v1,deploymentconfig;"
    "apps/v1,deployment;"
    "v1,service;"
    "route/v1,route;"
    "security/v1,securitycontextconstraints"
  )

  _test/schema-generation/openapi2jsonschema/openapi2jsonschema/command.py -o "_test/schema-generation/openshift-json-schema" --expanded --kubernetes --stand-alone --strict --apiversionkind "$(printf "%s" "${apiKinds[@]}")" "_test/schema-generation/openshift-openapi-spec.json"
}

if [[ ! -d "_test/schema-generation/openapi2jsonschema" ]]; then
  clone_forked_openapi2jsonschema
fi

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