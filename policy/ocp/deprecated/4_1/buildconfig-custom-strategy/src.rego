package ocp.deprecated.ocp4_1.buildconfig_custom_strategy

import data.lib.konstraint

# @title BuildConfig exposeDockerSocket deprecated
#
# 'spec.strategy.customStrategy.exposeDockerSocket' is no longer supported by BuildConfig.
# See: https://docs.openshift.com/container-platform/4.1/release_notes/ocp-4-1-release-notes.html#ocp-41-deprecated-features
#
# @kinds build.openshift.io/BuildConfig
violation[msg] {
  obj := konstraint.object
  lower(obj.apiVersion) == "build.openshift.io/v1"
  lower(obj.kind) == "buildconfig"

  obj.spec.strategy.customStrategy.exposeDockerSocket

  msg := konstraint.format(sprintf("%s/%s: 'spec.strategy.customStrategy.exposeDockerSocket' is deprecated. If you want to continue using custom builds, you should replace your Docker invocations with Podman or Buildah.", [obj.kind, obj.metadata.name]))
}