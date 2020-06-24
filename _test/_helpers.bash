split_via_yq() {
  SEARCH_PATH=$1
  SEARCH_DIR=$(dirname "$1")
  KEY=$2

  mkdir -p /tmp/rego-policies/${SEARCH_DIR}

  for file in $(ls ${SEARCH_PATH} | xargs) ; do
    yq --yaml-output "${KEY}" ${file} > /tmp/rego-policies/${SEARCH_DIR}/$(basename "${file}")
  done
}

split_via_jq() {
  SEARCH_PATH=$1
  SEARCH_DIR=$(dirname "$1")
  KEY=$2

  mkdir -p /tmp/rego-policies/${SEARCH_DIR}

  for file in $(ls ${SEARCH_PATH} | xargs) ; do
    jq "${KEY}" ${file} > /tmp/rego-policies/${SEARCH_DIR}/$(basename "${file}")
  done
}

copy_file_via_yq() {
  FILE_PATH=$1
  FILE_DIR=$(dirname "$1")

  mkdir -p /tmp/rego-policies/${FILE_DIR}

  yq --yaml-output "." ${FILE_PATH} > /tmp/rego-policies/${FILE_DIR}/$(basename ${FILE_PATH})
}

copy_file_via_jq() {
  FILE_PATH=$1
  FILE_DIR=$(dirname "$1")

  mkdir -p /tmp/rego-policies/${FILE_DIR}

  jq "." ${FILE_PATH} > /tmp/rego-policies/${FILE_DIR}/$(basename ${FILE_PATH})
}

copy_dir_via_jq() {
  SEARCH_PATH=$1
  SEARCH_DIR=$(dirname "$1")

  mkdir -p /tmp/rego-policies/${SEARCH_DIR}

  for file in $(ls ${SEARCH_PATH} | xargs) ; do
    jq '.' ${file} > /tmp/rego-policies/${SEARCH_DIR}/$(basename ${file})
  done
}

print_err() {
  if [ "$1" -ne 0 ]; then echo "$2"; fi
}