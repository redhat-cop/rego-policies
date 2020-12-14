package ocp.deprecated.ocp4_3.buildconfig_jenkinspipeline_strategy

import data.lib.konstraint.core as konstraint_core

# @title BuildConfig jenkinsPipelineStrategy is deprecated
#
# 'spec.strategy.jenkinsPipelineStrategy' is no longer supported by BuildConfig.
# See: https://docs.openshift.com/container-platform/4.3/release_notes/ocp-4-3-release-notes.html#ocp-4-3-deprecated-features
#
# @kinds build.openshift.io/BuildConfig
violation[msg] {
  obj := konstraint.object
  lower(obj.apiVersion) == "build.openshift.io/v1"
  lower(obj.kind) == "buildconfig"

  obj.spec.strategy.jenkinsPipelineStrategy

  msg := konstraint_core.format(sprintf("%s/%s: 'spec.strategy.jenkinsPipelineStrategy' is deprecated. Use Jenkinsfiles directly on Jenkins or OpenShift Pipelines instead.", [konstraint_core.kind, konstraint_core.name]))
}