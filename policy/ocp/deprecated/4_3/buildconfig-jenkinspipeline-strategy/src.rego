package ocp.deprecated.ocp4_3.buildconfig_jenkinspipeline_strategy

import data.lib.konstraint.core as konstraint_core

# @title RHCOP-OCP_DEPRECATED-4.3-00001: BuildConfig jenkinsPipelineStrategy is deprecated
#
# 'spec.strategy.jenkinsPipelineStrategy' is no longer supported by BuildConfig.
# See: https://docs.openshift.com/container-platform/4.3/release_notes/ocp-4-3-release-notes.html#ocp-4-3-deprecated-features
#
# @kinds build.openshift.io/BuildConfig
violation[msg] {
  lower(konstraint_core.apiVersion) == "build.openshift.io/v1"
  lower(konstraint_core.kind) == "buildconfig"

  konstraint_core.resource.spec.strategy.jenkinsPipelineStrategy

  msg := konstraint_core.format_with_id(sprintf("%s/%s: 'spec.strategy.jenkinsPipelineStrategy' is deprecated. Use Jenkinsfiles directly on Jenkins or OpenShift Pipelines instead.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.3-00001")
}