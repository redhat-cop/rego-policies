#!/usr/bin/env bats

@test "k8s-validation-rolebinding" {
    run conftest test _test/k8s-validation-rolebinding --output tap

    [ "$status" -eq 1 ]
    [ "${lines[1]}" = "not ok 1 - _test/k8s-validation-rolebinding/list.yml - RoleBinding/NoApiGroup: RoleBinding roleRef.apiGroup key is null, use rbac.authorization.k8s.io instead." ]
    [ "${lines[2]}" = "not ok 2 - _test/k8s-validation-rolebinding/list.yml - RoleBinding/NoKind: RoleBinding roleRef.kind key is null, use ClusterRole or Role instead." ]
    [ "${lines[3]}" = "# Successes" ]
}

@test "ocp-42-deprecated-apiversions" {
    run conftest test _test/ocp-42-deprecated-apiversions --output tap

    [ "$status" -eq 1 ]
    [ "${lines[1]}" = "not ok 1 - _test/ocp-42-deprecated-apiversions/list.yml - Foo/Bar: servicecatalog.k8s.io/v1beta1 is deprecated." ]
    [ "${lines[2]}" = "not ok 2 - _test/ocp-42-deprecated-apiversions/list.yml - Foo/Bar: automationbroker.io/v1alpha1 is deprecated." ]
    [ "${lines[3]}" = "not ok 3 - _test/ocp-42-deprecated-apiversions/list.yml - Foo/Bar: osb.openshift.io/v1 is deprecated." ]
    [ "${lines[4]}" = "not ok 4 - _test/ocp-42-deprecated-apiversions/list.yml - Foo/Bar: operatorsources.operators.coreos.com/v1 is deprecated." ]
    [ "${lines[5]}" = "not ok 5 - _test/ocp-42-deprecated-apiversions/list.yml - Foo/Bar: catalogsourceconfigs.operators.coreos.com/v1 is deprecated." ]
    [ "${lines[6]}" = "not ok 6 - _test/ocp-42-deprecated-apiversions/list.yml - Foo/Bar: catalogsourceconfigs.operators.coreos.com/v2 is deprecated." ]
    [ "${lines[7]}" = "# Successes" ]
}

@test "ocp-43-deprecated-apiversions" {
    run conftest test _test/ocp-43-deprecated-apiversions --output tap

    [ "$status" -eq 1 ]
    [ "${lines[1]}" = "not ok 1 - _test/ocp-43-deprecated-apiversions/template.yml - Template/Foo: API v1 for Template is no longer served by default, use template.openshift.io/v1 instead." ]
    [ "${lines[2]}" = "not ok 2 - _test/ocp-43-deprecated-apiversions/template.yml - ProjectRequest/Bar: API v1 for ProjectRequest is no longer served by default, use project.openshift.io/v1 instead." ]
    [ "${lines[3]}" = "not ok 3 - _test/ocp-43-deprecated-apiversions/template.yml - ImageStream/Bar: API v1 for ImageStream is no longer served by default, use image.openshift.io/v1 instead." ]
    [ "${lines[4]}" = "not ok 4 - _test/ocp-43-deprecated-apiversions/template.yml - BuildConfig/Bar: API v1 for BuildConfig is no longer served by default, use build.openshift.io/v1 instead." ]
    [ "${lines[5]}" = "not ok 5 - _test/ocp-43-deprecated-apiversions/template.yml - DeploymentConfig/Bar: API v1 for DeploymentConfig is no longer served by default, use apps.openshift.io/v1 instead." ]
    [ "${lines[6]}" = "not ok 6 - _test/ocp-43-deprecated-apiversions/template.yml - RoleBinding/Bar: API v1 for RoleBinding is no longer served by default, use rbac.authorization.k8s.io/v1 instead." ]
    [ "${lines[7]}" = "not ok 7 - _test/ocp-43-deprecated-apiversions/template.yml - Route/Bar: API v1 for Route is no longer served by default, use route.openshift.io/v1 instead." ]
    [ "${lines[8]}" = "not ok 8 - _test/ocp-43-deprecated-apiversions/template.yml - SecurityContextConstraints/Bar: API v1 for SecurityContextConstraints is no longer served by default, use security.openshift.io/v1 instead." ]
    [ "${lines[9]}" = "# Successes" ]
}