# METADATA
# title: 'RHCOP-OCP_DEPRECATED-4_1-00001: BuildConfig exposeDockerSocket deprecated'
# description: |-
#   'spec.strategy.customStrategy.exposeDockerSocket' is no longer supported by BuildConfig.
#   See: https://docs.openshift.com/container-platform/4.1/release_notes/ocp-4-1-release-notes.html#ocp-41-deprecated-features
# custom:
#   matchers:
#     kinds:
#     - apiGroups:
#       - build.openshift.io
#       kinds:
#       - BuildConfig
#   skipConstraint: true
package ocp.deprecated.ocp4_1.buildconfig_custom_strategy

import data.lib.konstraint.core as konstraint_core

violation[msg] {
  lower(konstraint_core.apiVersion) == "build.openshift.io/v1"
  lower(konstraint_core.kind) == "buildconfig"

  konstraint_core.resource.spec.strategy.customStrategy.exposeDockerSocket

  msg := konstraint_core.format_with_id(sprintf("%s/%s: 'spec.strategy.customStrategy.exposeDockerSocket' is deprecated. If you want to continue using custom builds, you should replace your Docker invocations with Podman or Buildah.", [konstraint_core.kind, konstraint_core.name]), "RHCOP-OCP_DEPRECATED-4.1-00001")
}