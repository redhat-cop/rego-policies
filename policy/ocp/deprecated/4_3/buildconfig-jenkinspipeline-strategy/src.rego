package ocp.deprecated.ocp4_3.buildconfig_jenkinspipeline_strategy

import data.lib.konstraint

# violation: Check if 'jenkinsPipelineStrategy' is set on a BuildConfig. See: https://docs.openshift.com/container-platform/4.3/release_notes/ocp-4-3-release-notes.html#ocp-4-3-deprecated-features
# @Kinds build.openshift.io/BuildConfig
violation[msg] {
  obj := konstraint.object
  lower(obj.apiVersion) == "build.openshift.io/v1"
  lower(obj.kind) == "buildconfig"

  obj.spec.strategy.jenkinsPipelineStrategy

  msg := konstraint.format(sprintf("%s/%s: 'spec.strategy.jenkinsPipelineStrategy' is deprecated. Use Jenkinsfiles directly on Jenkins or OpenShift Pipelines instead.", [obj.kind, obj.metadata.name]))
}