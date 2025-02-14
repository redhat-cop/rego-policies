if [[ ! -d "_test/test_helper/bats-support" ]]; then
  # Download bats-support dynamically so it doesnt need to be added into source
  git clone https://github.com/ztombol/bats-support _test/test_helper/bats-support --depth 1
fi

if [[ ! -d "_test/test_helper/redhatcop-bats-library" ]]; then
  # Download redhat-cop/bats-library dynamically so it doesnt need to be added into source
  git clone https://github.com/redhat-cop/bats-library _test/test_helper/redhatcop-bats-library --depth 1
fi
