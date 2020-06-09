#!/usr/bin/env bats

load _helpers

@test "_test/deny-k8s-rolebinding-roleref" {
  split_via_yq "_test/deny-k8s-rolebinding-roleref/*.yml" ".items[]"
  run conftest test /tmp/rego-policies/_test/deny-k8s-rolebinding-roleref --output tap

  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - /tmp/rego-policies/_test/deny-k8s-rolebinding-roleref/list.yml - RoleBinding/NoApiGroup: RoleBinding roleRef.apiGroup key is null, use rbac.authorization.k8s.io instead." ]
  [ "${lines[2]}" = "not ok 2 - /tmp/rego-policies/_test/deny-k8s-rolebinding-roleref/list.yml - RoleBinding/NoKind: RoleBinding roleRef.kind key is null, use ClusterRole or Role instead." ]
  [ "${lines[3]}" = "# Successes" ]
}

@test "_test/deny-ocp42-all-deprecated-apiversions" {
  split_via_yq "_test/deny-ocp42-all-deprecated-apiversions/*.yml" ".items[]"
  run conftest test /tmp/rego-policies/_test/deny-ocp42-all-deprecated-apiversions --output tap

  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - /tmp/rego-policies/_test/deny-ocp42-all-deprecated-apiversions/list.yml - Foo/Bar: servicecatalog.k8s.io/v1beta1 is deprecated." ]
  [ "${lines[2]}" = "not ok 2 - /tmp/rego-policies/_test/deny-ocp42-all-deprecated-apiversions/list.yml - Foo/Bar: automationbroker.io/v1alpha1 is deprecated." ]
  [ "${lines[3]}" = "not ok 3 - /tmp/rego-policies/_test/deny-ocp42-all-deprecated-apiversions/list.yml - Foo/Bar: osb.openshift.io/v1 is deprecated." ]
  [ "${lines[4]}" = "not ok 4 - /tmp/rego-policies/_test/deny-ocp42-all-deprecated-apiversions/list.yml - Foo/Bar: operatorsources.operators.coreos.com/v1 is deprecated." ]
  [ "${lines[5]}" = "not ok 5 - /tmp/rego-policies/_test/deny-ocp42-all-deprecated-apiversions/list.yml - Foo/Bar: catalogsourceconfigs.operators.coreos.com/v1 is deprecated." ]
  [ "${lines[6]}" = "not ok 6 - /tmp/rego-policies/_test/deny-ocp42-all-deprecated-apiversions/list.yml - Foo/Bar: catalogsourceconfigs.operators.coreos.com/v2 is deprecated." ]
  [ "${lines[7]}" = "# Successes" ]
}

@test "_test/deny-ocp43-all-deprecated-apiversions/template.yml" {
  copy_file_via_yq "_test/deny-ocp43-all-deprecated-apiversions/template.yml"
  run conftest test _test/deny-ocp43-all-deprecated-apiversions/template.yml --output tap

  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - _test/deny-ocp43-all-deprecated-apiversions/template.yml - Template/Foo: API v1 for Template is no longer served by default, use template.openshift.io/v1 instead." ]
  [ "${lines[2]}" = "# Successes" ]
}

@test "_test/deny-ocp43-all-deprecated-apiversions/list.yml" {
  split_via_yq "_test/deny-ocp43-all-deprecated-apiversions/list.yml" ".items[]"
  run conftest test /tmp/rego-policies/_test/deny-ocp43-all-deprecated-apiversions/list.yml --output tap

  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "not ok 1 - /tmp/rego-policies/_test/deny-ocp43-all-deprecated-apiversions/list.yml - SecurityContextConstraints/Bar: API v1 for SecurityContextConstraints is no longer served by default, use security.openshift.io/v1 instead." ]
  [ "${lines[2]}" = "not ok 2 - /tmp/rego-policies/_test/deny-ocp43-all-deprecated-apiversions/list.yml - ProjectRequest/Bar: API v1 for ProjectRequest is no longer served by default, use project.openshift.io/v1 instead." ]
  [ "${lines[3]}" = "not ok 3 - /tmp/rego-policies/_test/deny-ocp43-all-deprecated-apiversions/list.yml - ImageStream/Bar: API v1 for ImageStream is no longer served by default, use image.openshift.io/v1 instead." ]
  [ "${lines[4]}" = "not ok 4 - /tmp/rego-policies/_test/deny-ocp43-all-deprecated-apiversions/list.yml - BuildConfig/Bar: API v1 for BuildConfig is no longer served by default, use build.openshift.io/v1 instead." ]
  [ "${lines[5]}" = "not ok 5 - /tmp/rego-policies/_test/deny-ocp43-all-deprecated-apiversions/list.yml - DeploymentConfig/Bar: API v1 for DeploymentConfig is no longer served by default, use apps.openshift.io/v1 instead." ]
  [ "${lines[6]}" = "not ok 6 - /tmp/rego-policies/_test/deny-ocp43-all-deprecated-apiversions/list.yml - RoleBinding/Bar: API v1 for RoleBinding is no longer served by default, use rbac.authorization.k8s.io/v1 instead." ]
  [ "${lines[7]}" = "not ok 7 - /tmp/rego-policies/_test/deny-ocp43-all-deprecated-apiversions/list.yml - Route/Bar: API v1 for Route is no longer served by default, use route.openshift.io/v1 instead." ]
  [ "${lines[8]}" = "# Successes" ]
}